<cfparam name=showSimpleDecline default=false>
<div id="declined">
	<cfif showSimpleDecline>

		<h2>So sorry!<br/> For some reason, this credit card was declined by our online payment system.<br/> Please email <a href="mailto:sharmion@charisfellowship.us">sharmion@charisfellowship.us</a> or call 574-269-1269 for assistance.</h2>

	<cfelse>	

		<h2>So sorry!<br/> For some reason, this credit card was declined by our online payment system.<br/> Please use this link to try again with a different credit card or call 574-269-1269 for assistance.</h2>
		<p>	
			<cfform name="form1" method="POST" action="https://secure.goemerchant.com/secure/custompayment/fellowshipofgracen/5782/default.aspx">
				<cfinput type="hidden" name="order_id" value="#payonline.orderid#">
				<cfinput type="hidden" name="amount" value="#payonline.amount#">
				<cfinput type="Submit" name="submit" value="Try Again!">
			</cfform>
		</p>

	</cfif>

</div>