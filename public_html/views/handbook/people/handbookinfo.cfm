<cfoutput>
<cfif isDefined("params.showupdate")>
#linkTo(text="Hide Updated Date", params="key=params.key")#
<cfelse>
#linkTo(text="Show Updated Date", params="key=#params.key#&showupdate=1")#
</cfif>
<br/><br/>
</cfoutput>
<cfset count = 0>
    <cfoutput query="people">

	#includePartial("/_shared/handbookinfo")#
	<cfif isDefined("params.showupdate")>
	<cfif isDate(reviewedAt)>Reviewed:#dateformat(reviewedAt)#<br/></cfif>
	<cfif updatedAt NEQ reviewedat>Updated:#dateformat(updatedAt)#<br/></cfif>
	</cfif>

	
	<br>
<cfset count = count +1>
	</cfoutput>
<cfoutput>
<p>Count: #count#</p>
</cfoutput>	