//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name='config'>
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

	<cffunction name="regsCountToDate">
		<cfargument name="itemname" required="true" type="string">
		<cfargument name="date" default="#now()#">
		<cfset regs = findall(where="name = '#arguments.itemname#' AND createdAt <= '#arguments.date#'", include="registrant,item(retreat)")>
		<cfset var total = 0>
		<cfloop query=regs>
			<cfset total = total + val(regCount)>
		</cfloop>
		<cfreturn total>
		<cfreturn total>
	</cffunction>

</cfcomponent>