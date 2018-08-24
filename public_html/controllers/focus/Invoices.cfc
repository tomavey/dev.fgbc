<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset useslayout(template='/focus/layoutadmin', except="show,payonline,agent,thankyou")>
		<cfset filters(through='checkOffice', except="testconfirm,show,payonline,agent,confirm,thankyou,tryagain")>
		<cfset filters(through="getRetreats", except="testconfirm")>
		<cfset filters(through="setReturn", only="index,show")>
		<cfset filters(through="getRetreatRegions", except="testconfirm")><!---In controllers/controller.cfc--->
	</cffunction>

<!----------------------------------------------->	
<!-------------CRUD------------------------------>	
<!----------------------------------------------->	

	<!--- -invoices/index --->
	<cffunction name="index">
		<cfset invoices = model("Focusinvoice").findAll(order="createdAt DESC")>
	</cffunction>

	<!--- -invoices/show/key --->
	<cffunction name="show">

		<!--- Find the invoice --->
	   	<cfset invoice = model("Focusinvoice").findByKey(params.key)>
			<cfif isDefined("params.ccstatus")>
				<cfset invoice.ccstatus = params.ccstatus>
				<cfset invoice.update()>
			</cfif>
	   	<!---Find the items connected to this invoice in a registration record--->
		<cfset items = model("Focusregistration").findAll(where="invoiceId = '#params.key#'", include="item,registrant")>

	<!--- Check if the record exists --->
	    <cfif NOT IsObject(invoice)>
	        <cfset flashInsert(error="Invoice #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
	<cfset renderPage(layout="/focus/layoutadmin")>

	</cffunction>

	<!--- -invoices/new --->
	<cffunction name="new">
		<cfset invoice = model("Focusinvoice").new()>
	</cffunction>

	<!--- -invoices/edit/key --->
	<cffunction name="edit">

		<!--- Find the invoice --->
    	<cfset invoice = model("Focusinvoice").findByKey(params.key)>
		<cfset invoice.ccstatus = getstatus(invoice.ccstatus)><!---in controllers/Controller.cfc--->

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(invoice)>
	        <cfset flashInsert(error="Invoice #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- -invoices/create --->
	<cffunction name="create">
		<cfset invoice = model("Focusinvoice").new(params.invoice)>

		<!--- Verify that the invoice creates successfully --->
		<cfif invoice.save()>
			<cfset flashInsert(success="The invoice was created successfully.")>
		            <cfset returnBack()><!---in /controllers/Controller.cfc--->
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the invoice.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- -invoices/update --->
	<cffunction name="update">
		<cfset invoice = model("Focusinvoice").findByKey(params.key)>

		<!--- Verify that the invoice updates successfully --->
		<cfif invoice.update(params.invoice)>
			<cfset flashInsert(success="The invoice was updated successfully.")>
		            <cfset returnBack()><!---in /controllers/Controller.cfc--->
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the invoice.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- -invoices/delete/key --->
	<cffunction name="delete">
		<cfset invoice = model("Focusinvoice").findByKey(params.key)>

		<!--- Verify that the invoice deletes successfully --->
		<cfif invoice.delete()>
			<cfset flashInsert(success="The invoice was deleted successfully.")>
            		<cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the invoice.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!-------------------------------------------------->
<!------OTHER VIEW CONTROLLERS---------------------->
<!-------------------------------------------------->

	<cffunction name="agent">
		<cfset renderPage(layout='/focus/layout2')>
	</cffunction>

	<cffunction name="payonline" 
		hint="This controller calls a payonline view with a form that auto submits with document.form1.submit();">
		<cfset payonline = model("Focusinvoice").findByKey(params.key)>
		<cfset payonline.merchant = "fellowshipofgracen">
		<cfset payonline.email = payonline.agent>
		<cfset payonline.amount = payonline.ccamount>
		<cfset payonline.url = "http://#CGI.http_host#/?controller=focus.invoices&action=confirm">
		<cfif isdefined("session.auth.office") and session.auth.office>
			<cfif listfind(getSetting('testagents'),payonline.email)>
				<cflocation url="http://#CGI.http_host#/?controller=focus.invoices&action=confirm&OrderID=#payonline.orderid#&total=#payonline.amount#&Status=1&approval_code=064435&authresponse=APPROVED&avs=Y&cvv2=M&Cardname=visa&NameonCard=Thomas%20D%20Avey&Cardstreet=PO%20Box%20386&Cardcity=Winona%20Lake&Cardstate=IN&Cardzip=46590&Cardcountry=US&email=tomavey@fgbc.org&phone=574-527-6061">
			</cfif>
		<cfelseif payonline.amount is 0>
				<cflocation url="http://#CGI.http_host#/?controller=focus.invoices&action=confirm&OrderID=#payonline.orderid#&total=#payonline.amount#&Status=1&approval_code=064435&authresponse=APPROVED&avs=Y&cvv2=M&Cardname=free&NameonCard=Free&Cardstreet=Free&Cardcity=Free&Cardstate=Free&Cardzip=Free&Cardcountry=US&email=#payonline.agent#&phone=Free">
		</cfif>
		<cfset sendEmail(layout="/focus/emaillayout", to=application.wheels.registrant, from=application.wheels.registrant, subject="Focus Retreat Invoice has been started.", template="notify")>
		<cfset renderPage(layout='/focus/layout2')>
	</cffunction>

	<cffunction name="confirm" 
		hint="goemerchant will call back to this controller">
		<cfset var invoiceid = val(params.orderid)>

		<cfif params.status is 0>
			<cfset redirectTo(action="tryAgain", key=invoiceid)>
		</cfif>

		<cfset invoice = model("Focusinvoice").findByKey(invoiceid)>
		<cfset invoice.ccamount = params.total>
		<cfset invoice.ccname = params.nameoncard>
		<cfset invoice.ccstatus = params.status>
		<cfset invoice.ccaddress = params.cardcity>
		<cfset invoice.update()>


		<cfset invoiceid = val(params.orderid)>
		<cfset items = model("Focusregistration").findAll(where="invoiceId = #invoiceid#", include="item,registrant")>
		<cfset sendEmail(layout="/focus/emaillayout", to=application.wheels.registrant, from=invoice.agent, cc=invoice.agent, subject="Focus Retreat Registration", template="confirm")>
		<cfset redirectTo(action="thankyou", key=invoiceid)>
	</cffunction>

	<cffunction name="thankyou">
		<cfif !isDefined("params.key") && isDefined("url.order_id")>
			<cfset params.key = val(url.order_id)>
		</cfif>	
		<cfif isDefined("url.auth_response") && url.auth_response is "APPROVED">
			<cfset markInvoicePaid(params.key)>
		</cfif>
		<cftry>
		<cfset invoice = model("Focusinvoice").findByKey(params.key)>
		<cfset items = model("Focusregistration").findAll(where="invoiceId = '#params.key#'", include="item,registrant")>
		<cfset renderPage(layout="/focus/layout2")>
		<cfcatch>
			<cfset noinvoice = true>
		</cfcatch>
		</cftry>	
		<cfset renderPage(layout='/focus/layout2')>
	</cffunction>

<cfscript>

    public function markInvoicePaid(id){
        var args = arguments;
        var invoice = model("Focusinvoice").findOne(where="id='#args.id#'");
        invoice.ccstatus = "Paid";
        invoice.update();
    }

</cfscript>

	<cffunction name="testConfirm">
		<cflocation url="http://dev.fgbc.org/focus/invoices/confirm?OrderID=16Aeast11&total=10.00&Status=1&approval_code=064435&authresponse=APPROVED&avs=Y&cvv2=M&Cardname=visa&NameonCard=Thomas%20D%20Avey&Cardstreet=PO%20Box%20386&Cardcity=Winona%20Lake&Cardstate=IN&Cardzip=46590&Cardcountry=US&email=tomavey@fgbc.org&phone=574-527-6061">
	</cffunction>

</cfcomponent>
