<cfparam name="noinvoice" default="false">
<cfoutput>

<div id="#params.controller##params.action#">	
	<cfif !noinvoice>
		<h1>Thank you for your registration</h1>	
			#includePartial('invoice')#
		<p>Please please print out this page for your records.</p>	
	<cfelse>
		<h1 style="text-align:center">Oops.  Something is wrong with your focus registration.<br/>  Contact #mailto(getSetting("mainregistrar"))# for help!</h1>
	</cfif>
</div>	

</cfoutput>