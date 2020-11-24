<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("handbooknotes")>
		<cfset belongsTo(name="handbookPerson", foreignKey="personid")>
		<cfset belongsTo(name="handbookOrganization", foreignKey="organizationid")>
		<cfset property(name="createdBy", defaultValue=session.auth.email)>
	</cffunction>

</cfcomponent>