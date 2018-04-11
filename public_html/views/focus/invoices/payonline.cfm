	<cfform name="form1" method="GET" action="https://secure.goemerchant.com/secure/custompayment/fellowshipofgracen/5782/default.aspx">
	<cfinput type="hidden" name="OrderID" value="#payonline.orderid#">
	<cfinput type="hidden" name="email" value="#payonline.email#">
	<cfinput type="hidden" name="total" value="#payonline.amount#">
	<cfinput type="hidden" name="URL" value="#payonline.url#">
	</cfform>

	<script>
	
		document.form1.submit();
	
	</script>
