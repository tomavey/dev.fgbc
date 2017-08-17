<cfif isDefined("form.submit") and len(form.captcha) AND form.captcha is decrypt(form.captcha_check,'fellowshipcouncil',"CFMX_COMPAT","Hex")>
<cflocation url="act_sendemail.cfm?id=#form.id#">	
<cfelse>	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FC!</title>
</head>

<body style="width:500px;margin:0 auto;border:1px solid gray;text-align:center">

<cfinvoke component="control" method="getCaptcha" action="checkcaptcha" id="#url.id#" returnvariable="captcha">	

<cfoutput>#captcha#</cfoutput>


</body>
</html>

</cfif>