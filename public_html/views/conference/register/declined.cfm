<div id="declined">
<h2>So sorry!<br/> For some reason, this credit card was declined by our online payment system.<br/> Please use this link to try again with a different credit card or call 574-269-1269 for assistance.</h2>
<p>	<cfform name="form1" method="POST" action="https://secure.goemerchant.com/secure/gateway/process.aspx">
	<cfinput type="hidden" name="Merchant" value="#payonline.merchant#">
	<cfinput type="hidden" name="OrderID" value="#payonline.orderid#">
	<cfinput type="hidden" name="email" value="#payonline.email#">
	<cfinput type="hidden" name="total" value="#payonline.amount#">
	<cfinput type="hidden" name="URL" value="#payonline.url#">
	<cfinput type="Submit" name="submit" value="Try Again!">
	</cfform>
</p>
</div>