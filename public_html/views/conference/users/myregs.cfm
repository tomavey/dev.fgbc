<cfset totalAll = 0>
<cfset totalEachFamily = 0>
<cfset totalEachPerson = 0>
<!---
	<cfdump var="#regs#"><cfabort>
--->
<div id="myregs" class="container">
<h1 class="text-center">Enter your email address below<br/> and we will fetch all invoices connected to your email address.</h1>
<cfoutput>
<cfif !flashIsEmpty()>
    <div class="alert">
        <h3 class="text-center">#flash("error")#</h3>
    </div>
</cfif>
<div class="text-center">
#startFormTag(controller="conference.users", action="getInvoices")#
#textFieldTag(name="email", placeholder="email address")#
#submitTag(value="Fetch my invoices!", class="btn")#
</div>
</cfoutput>
</div>