<cffunction name="cleanRss">
<cfargument name="description" required="yes">
           <cfset arguments.description = REReplaceNoCase(arguments.description, "<[^>]*>", "", "ALL")>
           <cfset arguments.description = Replace(arguments.description, "&nbsp;", " ", "ALL")>
           <cfset arguments.description = Replace(arguments.description, "&", " ", "ALL")>
           <cfif find(":",arguments.description) is 1>
				<cfset arguments.description= replace(arguments.description,": ","")>
		   </cfif>
<cfreturn arguments.description>
</cffunction>