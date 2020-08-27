<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
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