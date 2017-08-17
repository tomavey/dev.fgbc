<cffunction name="getcontent">
<cfargument name="identifier">
<cfset var data = "">

	<cfif val(arguments.identifier) gt 0>
		<cfset data = model('Focuscontent').findOne(arguments.identifier)>
	<cfelse>
		<cfset data = model('Focuscontent').findOne(where="name='#arguments.identifier#'")>
	</cfif>

<cfreturn data.content>
</cffunction>

<cffunction name="showItem">
<cfargument name="id" required="true" type="numeric">
    <cfreturn  !itemIsSoldOut(arguments.id)>
</cffunction>
