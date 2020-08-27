<div class="container">
<cfoutput>
    <cftry>
        <cfif invoicesByEmail.recordcount is 0>
            <h2 class="text-center">#message#</h2>
            <p class="well">
            We have no registrations online associated with #params.email#. Go to #linkto(route="conferencereg", onlyPath=false, class="btn")# to start a new registration.
            </p>
        <cfelse>
            <h2>#message#</h2>
            <p class="well">
            There are multiple invoices associated with #params.email#. Select one to add additional items to your registration.  In most cases we will combine your registrations so that all your tickets are in one envelope at the Welcome Center when you arrive.
            </p>

            <ul>
                <cfoutput query="invoicesByEmail">
                    <li>
                    <p class="alert alert-success">#linkto(text=invoices[invoiceid].ccorderid, route="showInvoice", key=invoiceid, onlypath=false, class="btn")#
                     for #dollarformat(invoices[invoiceid].ccamount)# on #dateformat(invoices[invoiceid].createdAt)# (items selected=
                    <cfloop query = "registrations[invoiceid]">
                        #buttondescription#;
                    </cfloop>
                    )</p>
                    </li>
                </cfoutput>
            </ul>
        </cfif>

        <cfcatch>
            <h2>Oops</h2>
            <p class="alert">
            Something isn't working correctly.  But you can still go to #linkto(route="conferencereg", onlyPath=false, class="btn")# to start a new registration or purchase tickets.
            </p>
        </cfcatch>

    </cftry>
</cfoutput>
</div>