	<cfform name="form1" method="POST" action="https://secure.goemerchant.com/secure/custompayment/fellowshipofgracen/5782/default.aspx">
	<cfinput type="hidden" name="order_id" value="#payonline.orderid#">
	<cfinput type="hidden" name="email" value="#payonline.email#">
	<cfinput type="hidden" name="amount" value="#payonline.amount#">
	<cfinput type="hidden" name="URL" value="#payonline.url#">
	</cfform>

	<script>
	
		document.form1.submit();
	
	</script>
