<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Fellowship Council</title>
<cfinvoke component="control" method="getstaffinfo" tag="fc" returnvariable="staff" />
</head>

<body style="width:500px;margin:0 auto;border:1px solid gray;text-align:center">
<h2>Please click on your email address and we will send you a link to the Fellowship Council Web Site</h2>

<cfoutput query="staff">
  <a href="captcha.cfm?id=#itemid#">#fname# #lname#</a><br />
</cfoutput>

<p>If cookies are allowed in your browser, you will not need the special link after the first time you visit the Fellowship Council Web Site</p>
<cfif isDefined("url.debug")>
  <cfdump var="#session.auth#">
</cfif>

</body>
</html>
