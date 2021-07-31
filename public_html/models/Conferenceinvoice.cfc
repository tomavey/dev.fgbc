//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_invoices")>
		<cfset hasMany(name="registrations", modelName="Conferenceregistration",foreignKey="equip_invoicesID")>
		<cfset property(name="event", defaultValue=getEvent())>
	</cffunction>

            <cffunction name="findInvoicesForEmail">
            <cfargument name="email" required=true type="string">
            <cfset var loc = arguments>
            <cfquery datasource='#getDatasourceName()#' name='loc.invoicesForThisEmail'>
                SELECT id as invoiceid
                FROM equip_invoices ei
                WHERE 
                    (ei.agent = '#trim(loc.email)#' OR ei.ccEmail = '#trim(loc.email)#')
                    AND ei.event = '#getEvent()#'
                    AND ei.deletedat IS NULL
            </cfquery>    

                <cfset loc.regsForThisEmail = getRegsForThisEmail(loc.email)>

                <!--- abstracted
                <cfset loc.regsForThisEmail = model("Conferenceregistration").findall(
                    select="equip_invoicesid as invoiceId", 
                    where="equip_people.email = '#trim(loc.email)#' AND event='#getEvent()#'", 
                    include="option,person(family)")>

                --->
                <cfquery dbType="query" name="loc.allInvoices">
                    SELECT * FROM loc.invoicesForThisEmail
                    UNION
                    SELECT * FROM loc.regsForThisEmail
                </cfquery>
                <cfquery dbType="query" name="loc.allInvoicesInOrder">
                    SELECT *
                    FROM loc.allInvoices
                    WHERE invoiceId <> 1115
                    ORDER BY invoiceId
                </cfquery>
                <cfquery dbType="query" name="loc.allUniqueInvoices">
                    SELECT DISTINCT invoiceid
                    FROM loc.allInvoicesInOrder
                </cfquery>

                <cfreturn loc.allUniqueInvoices>

            </cffunction>

            <cffunction name="getRegsForThisEmail">
            <cfargument name="email" required="true" type="string">
            <cfset var loc = arguments>
                <cfset loc.regsForThisEmail = model("Conferenceregistration").findall(
                    select='equip_invoicesid AS invoiceId', 
                    where="equip_people.email = '#trim(loc.email)#' AND event='#getEvent()#'", 
                    include="option,person(family)")>
                <cfreturn loc.regsForThisEmail>
            </cffunction>


</cfcomponent>
