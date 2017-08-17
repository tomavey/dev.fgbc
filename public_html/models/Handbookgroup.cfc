<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("handbookgroups")>
		<cfset belongsTo(name="handbookPerson", foreignkey="personid")>
		<cfset belongsTo(name="handbookGroupType", foreignkey="grouptypeid", jointype="outer")>
	</cffunction>

</cfcomponent>