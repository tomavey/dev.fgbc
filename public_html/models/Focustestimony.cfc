<cfcomponent extends="Model" output="false">
	
	<cffunction name='init'>
		<cfset table('focus_testimonies')>
		<cfset belongsTo(modelName='focusretreat', name="retreat", foreignKey="retreatid")>
	</cffunction>

</cfcomponent>