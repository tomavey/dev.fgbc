<cfparam name="churches" type="query">
<cfparam name="previousListedAsCity" default="">
<cfset count = 0>
<cfset memberCount = 0>
<cfset comemberCount = 0>
<cfset potentialMemberCount = 0>
<cfset dateToCompareWithNow = "#year(now())#-07-01">
<cfset params.reverse = 0>

<cfoutput>
  <cfif !isDefined("params.noFormat")>
    <p>
      <cfif isDefined("params.showreview")>
        #linkto(text="Hide Reviewed Dates and links", action="yellowpages", params="", class="btn")#
        <h3 style="color:red">Showing review alerts for churches not reviewed since #dateToCompareWithNow#</h3>
      <cfelse>
        #linkto(text="Show Reviewed Dates and Links", action="yellowpages", params="showreview=&showlinks=", class="btn")#
      </cfif>
        #linkto(text="Remove Formatting", action="yellowpages", params="noformat=", class="btn")#
    </p>
  </cfif>
</cfoutput>

<p>&nbsp;</p>

<cfoutput query="churches" group="state">
  <span style="font-family:'Times New Roman';font-size:22pt">#state#</span><br/>

  <cfoutput group="listed_as_city">
  
    <!---this cfif block puts the listed_as_city into the same div as the first listing--->
    <cfif listed_as_city NEQ previousListedAsCity><!---this cfif block puts the listed_as_city into the same div as the first listing--->
      <div style='mso-pagination:widow-orphan lines-together'>
      <span style="font-size:12pt;font-weight:bold;">#listed_as_city#</span><br/>
    </cfif>
  <cfoutput group="id">

    <!---this cfif block puts the listed_as_city into the same div as the first listing--->
    <cfif listed_as_city IS previousListedAsCity>
      <div style='mso-pagination:widow-orphan lines-together'>
    </cfif>

    <cfset count = count +1>
    <cfif statusid is 1>
    	  <cfset membercount = membercount + 1>
    </cfif>
    <cfif statusid is 8>
    	  <cfset comembercount = comembercount + 1>
    </cfif>
    <cfif statusid is 2>
          <cfset potentialmembercount = potentialmembercount + 1>
    </cfif>

    <span style="font-size:10pt">#name#</span>
    <cfif statusid is 2>
    **
    </cfif>
	<cfif isDefined("showlinks")>
		&nbsp;#linkTo(text='<i class="icon-search"></i>', controller="handbook.organizations", action="show", key=id, onclick="window.open(this.href); return false;")#
	</cfif>
	<br/>
    <cfif len(address1)>
    <span style="font-family:'Times New Roman';font-size:9pt;text-transform:capitalize">#fixAddress(address1)#</span><br/>
    </cfif>
    <cfif len(address2)>
    <span style="font-family:'Times New Roman';font-size:9pt;text-transform:capitalize">#fixAddress(address2)#</span><br/>
    </cfif>
    <span style="font-family:'Times New Roman';font-size:9pt;text-transform:capitalize">#lcase(org_city)#, #state_mail_abbrev# #zip#<span><br/>
    <cfif len(meetingplace)>
	    <span style="font-family:'Times New Roman';font-size:9pt">Meeting at: #fixMeetingPlace(meetingplace)#</span></br>
    </cfif>
	<cfif len(phone)>
		<span style="font-family:'Times New Roman';font-size:9pt">#fixphone(phone)#</span><br/>
	</cfif>
	<cfif len(email)>
		<span style="font-family:'Times New Roman';font-size:9pt">#email#</span>
		  <cfif isDefined("params.showreview")>
        #createEmailToUpdateOrg(id,email,name)#
		  </cfif>

	<br/>
	</cfif>
	<cfif len(website)>
    <span style="font-family:'Times New Roman';font-size:9pt">#fixWebSite(website)#</span><br/>
    <cfif isDefined("params.showreview") && urlExists(website)>
      <span>OK</span>
    </cfif>
	</cfif>

  <cfoutput>
  		  <cfif len(trim(position)) AND position NEQ "AGBM Only">
  		  		<span style="font-family:'Times New Roman';font-size:9pt">#position#:
			  <cfif params.reverse>
			  	#lname#, #fname#
			  <cfelse>
			    #fname# #lname#
			  </cfif>
			  <cfif isDefined("params.showreview") and len(handbookpersonemail)>
          #createEmailToUpdateOrg(id,handbookpersonemail,name,fname)#
			  </cfif>
			  </span>
			  <br/>
		  </cfif>
  </cfoutput>

	  <cfif isDefined("params.showreview")>
                    <cfif statusid is 1>
                        Member Church
                     <cfelseif statusid is 8>
                        Campus
                      <cfelseif statusid is 2>
                         New Church
                      <cfelse>
                        Oops! Membership Status needs to be fixed
                      </cfif>
            	       <p>Last reviewed on #dateformat(reviewedAt)# by #reviewedBy#<br/>
            	       Last updated: #dateformat(updatedAt)#</p>
            	       <cfif isDate(reviewedAt) AND datecompare(reviewedAt,dateToCompareWithNow) is 1>
            	           #dateformat(reviewedAt)# #reviewedBy#<br/>
            	       <cfelse>
            	           <span style="color:red">NOT REVIEWED</span><br/>
	       </cfif>
	  </cfif>
	  <br/>
</div>
  <cfset previousListedAsCity = listed_as_city>
	</cfoutput><!---Each Church--->
	</cfoutput><!---Each City--->
</cfoutput><!---Each State--->

<cfif !isDefined("params.key")>
  <cfoutput>
    <p>** This is a new church that is not yet a formal member.</p>
    <br/>
    Member Count: #membercount#<br/>
    Campus Church Count: #comembercount#<br/>
    Potential Member Count: #potentialmembercount#<br/>
    Total Count:#count#
  </cfoutput>
</cfif>
