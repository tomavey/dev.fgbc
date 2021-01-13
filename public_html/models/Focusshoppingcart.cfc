//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("focus_shoppingcarts")>
		<cfset afterSave("setShoppingCartid")>
	</cffunction>

	<cffunction name="setShoppingCartid">
		<cfif !isDefined("this.shoppingcartid")>
			<cfset this.shoppingcartid = this.id>
			<cfset this.updateByKey(this.id,this)>
		</cfif>
	</cffunction>
	
</cfcomponent>