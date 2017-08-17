<cfcomponent output="false">

<cffunction name="init" access="public" returnType="facebook" output="false">
<cfargument name="accesstoken" type="string" required="true">
<cfset variables.accesstoken = arguments.accesstoken>
<cfreturn this>
</cffunction>

<cffunction name="getFriends" access="public" returnType="array" output="false">
<cfset var httpResult = "">
<cfset var initialResult = "">

<cfhttp url="https://graph.facebook.com/me/friends?fields=email,name&access_token=#variables.accesstoken#" result="httpResult">
<cfset initialResult = deserializeJSON(httpResult.filecontent)>
<!---
For now, skipping pagination.
--->
<cfreturn initialResult.data>

</cffunction>

<cffunction name="getMe" access="public" returnType="struct" output="false">
<cfset var httpResult = "">

<cfhttp url="https://graph.facebook.com/me?access_token=#variables.accesstoken#" result="httpResult">
<cfreturn deserializeJSON(httpResult.filecontent)>

</cffunction>

</cfcomponent>