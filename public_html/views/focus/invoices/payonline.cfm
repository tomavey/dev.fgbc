	<cfform name="form1" method="POST" action="https://secure.goemerchant.com/secure/gateway/process.aspx">
	<cfinput type="hidden" name="Merchant" value="#payonline.merchant#">
	<cfinput type="hidden" name="OrderID" value="#payonline.orderid#">
	<cfinput type="hidden" name="email" value="#payonline.email#">
	<cfinput type="hidden" name="total" value="#payonline.amount#">
	<cfinput type="hidden" name="URL" value="#payonline.url#">
	</cfform>

	<script>
	
		document.form1.submit();
	
	</script>
