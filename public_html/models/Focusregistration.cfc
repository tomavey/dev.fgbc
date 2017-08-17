<cfcomponent extends="Model" output="false">
	
	<cffunction name='init'>
		<cfset table("focus_registrations")>
		<cfset belongsTo(name='invoice', modelName="Focusinvoice", foreignKey="invoiceId")>
		<cfset belongsTo(name='registrant', modelName="Focusregistrant", foreignKey="registrantId")>
		<cfset belongsTo(name='item', modelName="Focusitem", foreignKey="itemId")>
	</cffunction>

	<cffunction name="countRegsToDate">
		<cfargument name="itemname" required="true" type="string">
		<cfargument name="date" default="#now()#">
		<cfset regs = findall(where="name = '#arguments.itemname#' AND createdAt <= '#arguments.date#'", include="registrant,item(retreat)")>
		<cfreturn regs.recordcount>
	</cffunction>

</cfcomponent>