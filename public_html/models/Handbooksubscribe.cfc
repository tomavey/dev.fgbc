<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("handbooksubscriptions")>
		<cfset property(name="useremail", sql="select email from auth_users where id = handbooksubscriptions.userid")>
		<cfset property(name="handbookemail", sql="select email from handbookpeople where id = handbooksubscriptions.handbookid")>
	</cffunction>

</cfcomponent>s