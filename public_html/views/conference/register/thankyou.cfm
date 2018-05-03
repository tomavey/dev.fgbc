<cfparam name="showLinkToinvoice" dafault="false">
<cfoutput>

<h2 style="text-align:center">Thank you for registering for #getEventastext()#.</h2>

<cfif showLinkToinvoice>
    <p class="alert alert-success text-center">
    #linkto(text="Your Registration", controller="conference.invoices", action="show", params="ccstatus=paid", key="#paidInvoiceId#", class="btn btn-block btn-large btn-info")#
    </p>
<cfelse>
    <p class="well" style="text-align:center">We will send you an email confirmation in the next few days.  If you don't receive one, email #mailto(application.wheels.requestInvoiceReceiptFrom)#.</p>
</cfif>

</cfoutput>