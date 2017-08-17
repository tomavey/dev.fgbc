<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table('focus_items')>
		<cfset hasMany(name='registration', modelName="Focusregistration", foreignKey="itemId")>
		<cfset belongsTo(name='retreat', modelName="Focusretreat", foreignKey="retreatId")>
		<cfset validatesUniquenessOf(property="name")>
	</cffunction>

            <cffunction name="findCountSold">
            <cfargument name="itemId" require="true" type="numeric">
            <cfset var loc = structNew()>
                <cfset   loc=arguments>
                <cfset loc.itemsSold = model("Focusregistration").findAll(where="itemid=#loc.itemid#")>
                <cfset loc.return = loc.itemsSold.recordcount>
                <cfreturn loc.return>
            </cffunction>

</cfcomponent>