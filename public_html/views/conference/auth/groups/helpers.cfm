<cffunction name="listGroupRights">
<cfargument name="groupId" required="true"  type="numeric">	
<cfset var rightslist = "">
<cfset rightslist = Model("GroupsRight").findall(where="auth_groupid = #arguments.groupid#", include="right")>
<cfreturn rightslist>
</cffunction>