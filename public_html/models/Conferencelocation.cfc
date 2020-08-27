<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_locations")>
		<cfset hasMany(name="events", modelName="Conferenceevent", foreignKey="locationid", joinType="outer")>
		<cfset property(name="event", defaultValue=getEvent())>
	</cffunction>

</cfcomponent>
