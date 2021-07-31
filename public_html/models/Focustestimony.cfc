//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name='config'>
		<cfset table('focus_testimonies')>
		<cfset belongsTo(modelName='focusretreat', name="retreat", foreignKey="retreatid")>
	</cffunction>

</cfcomponent>