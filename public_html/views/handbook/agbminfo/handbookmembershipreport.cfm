<div is="agmhandbookreport">
<cfset countall = 0>
<cfset alert = 1>

<cfoutput>

  <cfif !isDefined("params.plain")>
    #linkTo(text="Show without formating", action="handbookmembershipreport", params="plain", class="btn")#
  </cfif>

  #getContent('inspiremem').content#

  <cfif gotRights("office,agbmadmin")>
    #editTag(controller="admin.contents", id=getContent('inspiremem').id)#
  </cfif>

</cfoutput>

<cfif ordained.recordcount>
  <div class="well">
    <h2>Ordained Ministers</h2>
    <cfset count = 0>
    <cfoutput query="ordained">
		<cfoutput>
		</cfoutput>
	    #includePartial("handbookMembershipListing")#
    	<cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>


<cfif commissioned.recordcount>
  <div class="well">
    <h2>Commissioned Ministers</h2>
    <cfset count = 0>
    <cfoutput query="commissioned">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>


<cfoutput>
<p>
   Count all = #countall#
</p>
</cfoutput>
</div>
