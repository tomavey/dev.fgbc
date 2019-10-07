<cffunction name="getSeniorPastor">
<cfargument name="id" required="true" type="numeric">
<cfset var loc = structNew()>
	<cfset loc.seniorpastor = model("Handbookperson").findOne(where="organizationid = #arguments.id# AND p_sortorder=1", include="Handbookpositions,Handbookstate")>
 	<cfif isObject(loc.seniorpastor)>
		<cfset loc.return.name = loc.seniorpastor.fname & " " & loc.seniorpastor.lname>
		<cfset loc.return.fname = loc.seniorpastor.fname>
             <cfset loc.return.lname = loc.seniorpastor.lname>
		<cfset loc.return.email = loc.seniorpastor.email>
		<cfset loc.return.phone = loc.seniorpastor.phone>
	<cfelse>
		<cfset loc.return.name = "">
		<cfset loc.return.fname = "">
              <cfset loc.return.lname = "">
		<cfset loc.return.email = "">
		<cfset loc.return.phone = "">
	</cfif>
	<cfreturn loc.return>
</cffunction>

<cffunction name="hasPictures">
<cfargument name="personid" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset loc.return=false>

<cfset pictures = model("Handbookpicture").findAll(where="personid = #personid#")>

<cfif pictures.recordcount>
	  <cfset loc.return = true>
</cfif>

<cfreturn loc.return>
</cffunction>

<cffunction name="isNatOrg">
<cfargument name="orgStatusId" required="true" type="numeric">
  <cfset var loc=structNew()>
  <cfset loc.return = false>
  <cfif arguments.orgStatusId is 10 or arguments.orgStatusId is 11>
  <cfset loc.return = true>
  </cfif>
<cfreturn loc.return>
</cffunction>

<cffunction name="getHandbooksCount">
<cfargument name="churchid" required="true" type="numeric">
<cfset var loc=structNew()>

<cfset loc.return = 2>

<cfset loc.church = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#year(now())-1#'")>

<cfif isObject(loc.church)>

	<cfset loc.att = loc.church.att>

<cfelse>

  <cfset loc.church = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#year(now())-2#'")>

  <cfif isObject(loc.church)>
    <cfset loc.att = loc.church.att>
  </cfif>

</cfif>

    <cftry>
      <cfif loc.att GTE 75>
      	  <cfset loc.return = 3>
      </cfif>
      <cfif loc.att GTE 200>
      	  <cfset loc.return = 5>
      </cfif>
      <cfif loc.att GTE 500>
      	  <cfset loc.return = 7>
      </cfif>
      <cfif loc.att GTE 1000>
      	  <cfset loc.return = 10>
      </cfif>
      <cfif loc.att GTE 1500>
      	  <cfset loc.return = 20>
      </cfif>
      <cfif loc.att GTE 2500>
      	  <cfset loc.return = 30>
      </cfif>
    <cfcatch><cfset loc.return = 2></cfcatch></cftry>

<cfreturn loc.return>

</cffunction>

<cffunction name="showHandbookListingLink">
<cfargument name="churchid" required="true" type="numeric">
<cfargument name="showbefore" default="#application.wheels.showLinkToHandbookPageBefore#">
<cfset var loc = structNew()>
<cfset loc.return = "">

     <cfif isBefore(arguments.showbefore)>

      <cfset church = model("Handbookorganization").findOne(where="id=#arguments.churchid#", include="Handbookstate")>

        <!---Only show link if the last review has NOT been between 2 months prior to the deadline and the deadline--->
      <cfif NOT isDate(church.reviewedAt) OR dateDiff("m",parseDateTime(church.reviewedAt),parseDateTime(arguments.showbefore)) GTE 2>

              <cfif church.statusid NEQ 10 and church.statusid NEQ 11>

                    <cfset loc.text = "Edit the printed handbook listing for #church.selectName#">

                      <cfsavecontent variable="loc.return">
                            <cftry>
                                  <cfif (isdefined("session.auth.handbook.people") AND gotHandbookOrganizationRights(arguments.churchid)) OR gotRights("superadmin,office,agbmadmin")>
                                <p>
                                <cfoutput>
                                    #linkTo(text=loc.text, controller="handbook.organizations",action="handbookpages",key=params.key, class="btn btn-primary btn-large")#
                      </cfoutput>
                                </p>
                              </cfif>
                            <cfcatch></cfcatch>
                            </cftry>
                  </cfsavecontent>

                </cfif>

      </cfif>

     </cfif>

  <cfreturn loc.return>

</cffunction>

<cffunction name="fixMeetingPlace">
<cfargument name='meetingplace' required="true" type="string">
<cfset var loc=structNew()>
<cfset loc.return = arguments.meetingplace>
<cfset loc.return = replace(loc.return,"(","","all")>
<cfset loc.return = replace(loc.return,")","","all")>
<cfset loc.return = ReplaceNoCase(loc.return,"Meeting:","","all")>
<cfset loc.return = ReplaceNoCase(loc.return,"Meeting","","all")>
<cfset loc.return = ReplaceNoCase(loc.return,":","","all")>
<cfset loc.return = ReplaceNoCase(loc.return,".","","all")>
<cfset loc.return = trim(loc.return)>
<cfreturn loc.return>
</cffunction>

<cfscript>
  private function $changeMessageDate(date){
    return "#date#, #year(now())#";
  }

  private function $dayOfDateAsString(date){
    return dayOfWeekAsString(dayOfWeek(date))
  }

  private function $deadLineAsString(dayMonth = getSetting('churchReviewDeadline')){
    var deadLine = "#dayMonth#, #year(now())#"
    return "#$dayOfDateAsString(deadline)#, #deadline#";
  }
</cfscript>

<cffunction name="createEmailToUpdateOrg">
<cfargument name="id" required="true" type="numeric">
<cfargument name="email" required="true" type="string">
<cfargument name="name" default="Greetings">
<cfargument name="fname" required="false">
<cfargument name="message">
<cfargument name="subject" default='#URLEncodedFormat("Please review #name# Charis Fellowship Handbook listing")#'>
<cfargument name="changeMessageDate" default="September 20">
<cfset changeMessageDate = $changeMessageDate(getSetting('churchReviewDeadline'))>

<cfsavecontent variable="createEmailLink">
<cfoutput>
          <cfif isDefined("fname")>
            <cfset name = fname>
          </cfif>
            <cfif isBefore(changeMessageDate)>
                 <cfset message = URLEncodedFormat("#name# - We are starting production of the the #year(now())+1# Charis Fellowship handbook.  Can you review this for me?  By #$deadLineAsString()#?  Be sure to click the 'This information is all correct' link at the top when you are finished. Thanks so much https://charisfellowship.us/reviewhandbook/#simpleencode(id)#?reviewer=#email#")>
            <cfelse>
                 <cfset message = URLEncodedFormat("#name# - I'm finishing up the #year(now())+1# Charis Fellowship handbook.  Can you review this for me?  Today?  Be sure to click the 'This information is all correct' link at the top when you are finished. Thanks so much https://charisfellowship.us/reviewhandbook/#simpleencode(id)#?reviewer=#email#")>
            </cfif>     

			  #mailTo(name='<i class="icon-envelope"></i>', emailaddress="#email#?subject=#subject#&body=#message#")#
</cfoutput>
</cfsavecontent>

<cfreturn createemaillink>

</cffunction>
