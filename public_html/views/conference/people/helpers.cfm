<cffunction name="listRegsEvents">
<cfargument name="personid" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset regs = model("Registration").findPersonsRegs(#arguments.personid#)> 
<cfsavecontent variable="loc.return">
	<cfoutput query="regs" group="event">
		#event#; 
	</cfoutput>
</cfsavecontent>
<cfreturn loc.return>
</cffunction>