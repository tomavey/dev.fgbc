	<cffunction name="personUpdatedAt">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc=structNew()>
	<cfset loc.return = "">
	<cfset loc.check = model("Handbookupdate").findOne(where="recordid = #arguments.personid# AND modelname = 'Handbookperson' AND datatype = 'update'")>
	<cfif isObject(loc.check)>
	<cfset loc.return = loc.check.createdAt>
	</cfif>
	<cfreturn loc.return>
	</cffunction>
	

	<cffunction name="scrubSelectName">
	<cfargument name="selectname" required="true" type="string">
	<cfset var scrubbedSelectname = arguments.selectName>
	<cfset scrubbedSelectname = replace(scrubbedSelectname,", Non","","one")>
	<cfset scrubbedSelectname = replace(scrubbedSelectname,", , Non","","one")>
	<cfreturn scrubbedSelectname>
	</cffunction>
