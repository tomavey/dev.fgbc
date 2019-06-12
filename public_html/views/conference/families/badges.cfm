<!---cfdump var="#badges#"><cfabort--->
<cfif isDefined("params.forWorkshops") or isDefined("params.download")>
    <cfset forWorkshops = false>
<cfelse>
    <cfset forWorkshops = true>
</cfif>

<cfset count = 0>
<cfset previousname = "">
  <cfif not isdefined("params.download")>
  <cfoutput>
    #startFormTag(action="badges")#
    #dateSelectTags(name="date")#
    #submitTag("Date After")#
    #endFormTag()#
    <cfif isDefined("params.previousyear")>
      #linkTo(text="Download as Excel", action="badges",  params="download=true&previousyear")#
    <cfelseif isDefined("params.date")>
      #linkTo(text="Download as Excel", action="badges",  params="download=true&date=#dateformat(params.date,'yyyy-mm-dd')#")#
    <cfelse>
      #linkTo(text="Download as Excel", action="badges",  params="download=true")#
    </cfif>
    <cfif not isDefined("params.previousyear")>
      <p>#linkTo(text="Previous Year", action="badges", params="previousyear")#</p>
    <cfelse>
      <p>#linkTo(text="Current Year", action="badges")#</p>
    </cfif>
  </cfoutput>
</cfif>

<table class="table">

  <cfif isDefined("params.previousyear")>
  <tr>
    <th colspan="2"><h2>Badges for Previous Year</h2>
    <p>for comparison</p></th>
  </tr>
  </cfif>

  <tr>
  	<th>FName</th>
  	<th>LName</th>
    <cfif forWorkshops>
    <th>Email</th>
    <th colspan="2" style="text-align:center">Links</th>
    </cfif>
  </tr>
  <cfoutput query="badges">
    <cfif previousname NEQ fullname>
    <tr>
    	<td>
        #linkto(text=capname(fname), controller="conference.people", action="show", key=ID, target="_blank")#
    	</td>
    	<td>#linkTo(text=capname(lname), controller="conference.registrations", action="showsearch", params="search=#lname#", target="_blank")# <cfif lname is fname>####Need's fixin'####</cfif>
    	</td>
      <cfif forWorkshops>
      <td>
        <cfif len(email)>#trim(email)#<cfelse>#trim(getSpouseEmail(id))#</cfif>
      </td>
      <td>
        #linkTo(text="Workshops", href="http://www.fgbc.org/conference/select/workshops/#simpleEncode(id,13)#")#
      </td>
      <td>
        #linkTo(text="Excursions", href="http://www.fgbc.org/conference/select/riskursions/#simpleEncode(id,13)#")#
      </td>
      </cfif>
    </tr>
    <cfset previousname = fullname>
    <cfset count = count +1>
    </cfif>
  </cfoutput>
</table>

<cfoutput>Count: #count#</cfoutput>