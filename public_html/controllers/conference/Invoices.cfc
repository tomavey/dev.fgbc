<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout", except="invoices")>
		<cfset usesLayout("/conference/layout2018", only="invoices")>
		<cfset filters(through="officeOnly,setEvent", except="show,showByEmail")>
		<cfset filters(through="setReturn", only="index,show,list")>
	</cffunction>

	<cffunction name="setEvent">
		<cfif isDefined("params.event")>
			 <cfset request.event = params.event>
		<cfelse>
			 <cfset request.event = getEvent()>
		</cfif>
	</cffunction>

	<!--- invoices/index --->
	<cffunction name="index">
		<cfset invoices = model("Conferenceinvoice").findAll(include="registrations", where="event='#request.event#'")>
	</cffunction>

	<cffunction name="showByEmail">
	<cfscript>
		if (!isValid("email",params.email)){
			flashInsert(error="Provide a valid email address");
			redirectTo(controller="conference.users", action="myRegs");
		}
		invoices = structNew();
		registrations = structNew();
		invoicesByEmail = model("Conferenceinvoice").findInvoicesForEmail(params.email);
		if (isDefined("invoicesByEmail.recordcount") AND invoicesByEmail.recordcount is 1){
			message = "Here is the invoice that is connected with #params.email#";
		}
		elseif (isDefined("invoicesByEmail.recordcount") AND invoicesByEmail.recordcount GT 1){
			message = "Here are all the invoices that are connected with #params.email#";
		}
		else {
			message = "We have no invoices for #params.email#";
		};
	</cfscript>
	<cfloop query = "invoicesByEmail">
		<cfset invoices[invoicesByEmail.invoiceid] = model("Conferenceinvoice").findAll(where="id = #invoicesByEmail.invoiceid# AND event='#getEvent()#'")>
	</cfloop>
	<cfloop query = "invoicesByEmail">
		<cfset registrations[invoicesByEmail.invoiceid] = model("Conferenceregistration").findAll(where="equip_invoicesid = #invoicesByEmail.invoiceid# AND event='#getEvent()#'", include="option")>
	</cfloop>
		<cftry>
			<cfset subjectString = "Your #getEventAsText()# Registration(s)">
		<cfcatch>
			<cfset subjectString = "Your Conference Registrations(s)">
		</cfcatch>
		</cftry>
		<cfset sendemail(from=get("requestInvoiceReceiptFrom"), to=params.email, template="showByEmail", subject=subjectString, layout="/layout_for_email")>

		<cfif gotRights("office")>
			<cfset renderPage(template="showByEmail", layout="/conference/layout2017")>
		<cfelse>	
			<cfset renderPage(action="regsSent", layout="/conference/layout2017")>
		</cfif>

	</cffunction>

	<cffunction name="regsSent">
	</cffunction>

	<!--- invoices/show/key --->
	<cffunction name="show">
	<cfset var whereString = "">	

	<cfif !isDefined("params.key") and isDefined("params.email")>
		<cfset redirectTo(action="showByEmail", params="email=#params.email#")>
	</cfif>

	<!--- Find the record --->
    	<cfset thisinvoice = model("Conferenceinvoice").findByKey(params.key)>

    	<cfif isDefined("params.ccstatus")>
    		<cfset thisinvoice.ccStatus = params.ccStatus>
    		<cfset thisinvoice.save()>
    	</cfif>

	<cfset whereString = "equip_invoicesid = #params.key# AND quantity <> 0"> 
		<cfif isDefined("params.showall")>
			<cfset whereString = "equip_invoicesid = #params.key#"> 
		</cfif>	

	<cfset optionsInThisInvoice = model("Conferenceregistration").findall(where=whereString, include="option,person(family)", order="equip_people.id")>

	<cftry>
    	<cfif isDefined("params.ccstatus")>
    		<cfset thisinvoice.ccEmail = optionsInThisInvoice.email>
    		<cfset thisinvoice.ccName = optionsInThisInvoice.fullname>
    		<cfset thisinvoice.save()>
    	</cfif>
    	<cfcatch></cfcatch>
    	</cftry>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(thisinvoice)>
	        <cfset flashInsert(error="invoice #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	    <cfif gotRights("superadmin,office")>
	    	<cfset renderPage(controller="conference.register", action="invoice", layout="/conference/adminlayout")>
	    <cfelse>
	    	<cfset renderPage(controller="conference.register", action="invoice", layout="/conference/layout2017")>
	    </cfif>

	</cffunction>

	<cffunction name="invoiceByEmail">
	</cffunction>

	<!--- invoices/new --->
	<cffunction name="new">
		<cfset invoice = model("Conferenceinvoice").new()>
	</cffunction>

	<!--- invoices/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset invoice = model("Conferenceinvoice").findByKey(params.key)>
    	<cftry>
		<cfset invoice.ccstatus = payStatus(invoice.ccstatus)>
		<cfcatch><cfset invoice.status = "NA"></cfcatch></cftry>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(invoice)>
	        <cfset flashInsert(error="invoice #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- invoices/create --->
	<cffunction name="create">

		<cfset invoice = model("Conferenceinvoice").new(params.invoice)>

		<!--- Verify that the invoice creates successfully --->
		<cfif invoice.save()>
			<cfset flashInsert(success="The invoice was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the invoice.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- invoices/update --->
	<cffunction name="update">
		<cfset invoice = model("Conferenceinvoice").findByKey(params.key)>

		<!--- Verify that the invoice updates successfully --->
		<cfif invoice.update(params.invoice)>
			<cfset flashInsert(success="The invoice was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the invoice.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- invoices/delete/key --->
	<cffunction name="delete">
		<cfset invoice = model("Conferenceinvoice").findByKey(params.key)>
		<cfset check = model("Conferenceregistration").deleteAll(where="equip_invoicesid = #params.key#")>

		<!--- Verify that the invoice deletes successfully --->
		<cfif invoice.delete()>
			<cfset flashInsert(success="The invoice was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the invoice.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="setccamount">
	<cfabort>
		<cfquery datasource="fgbc_main_3">
			update equip_invoices
			set ccamount = 280
			where event = "visionconference2014"
			AND ccamount = 300
		</cfquery>
		<cfquery datasource="fgbc_main_3" name="data">
			select *
			from equip_invoices
			where event = "visionconference2014"
		</cfquery>

		<cfdump var="#data#"><cfabort>

	</cffunction>

	<cfscript>
		public function markpaid(){
			if (isDefined("params.ccorderid")){
				var invoice = model("Conferenceinvoice").findOne(where="ccorderid='#params.ccorderid#'");
			}
			if (isDefined("params.id")){
				var invoice = model("Conferenceinvoice").findOne(where="id='#params.id#'");
			}
			invoice.ccstatus = "Paid";
			invoice.update();
			redirectTo(route="showinvoice", key=invoice.id);
			writeDump(invoice);abort;
		}
	</cfscript>

</cfcomponent>
