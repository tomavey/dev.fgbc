<cffunction name="displaypost">
<cfargument name="post" required="yes" type="string">
<cfset var thispost = "">
<cfset thispost = replace(arguments.post,"<p>","","all")>
<cfset thispost = replace(thispost,"</p>","","all")>
<cfset thispost = replace(thispost,"</br>","","all")>
<cfset thispost = left(thispost,125)>
<cfreturn thispost>
</cffunction>
