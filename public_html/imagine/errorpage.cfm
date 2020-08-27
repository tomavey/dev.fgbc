<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Error Page</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div id="wrapper">
<h2><center>An error has occured in our system. Try using the back button on your browser to repeat the last action.  However, you may need to start all over again.  A report has been sent to the FGBC office about this error but if the error repeats, please email <a href="tomavey@fgbc.org">Tom Avey</a>.</center></h2>	

<cftry>
<cfmail to="tomavey@fgbc.org" from="tomavey@fgbc.org" subject="Imagine Web Page error" type="html">
<p>An error has occured on the imagine.fgbc.org</p>
<cfoutput>
Diagnostics:#error.diagnostics#<br />
Page:#error.template#<br />
Linked From:#error.HTTPReferer#<br />
So far:#error.generatedContent#<br />
Query String:#error.queryString#<br />
Browser:#error.browser#<br />
Username:<cfif isdefined("session.auth.username")>#session.auth.username#</cfif><br/>
User email:<cfif isdefined("session.auth.email")><a href="#session.auth.email#">#session.auth.email#</a></cfif>
</cfoutput>
</cfmail>
<cfcatch></cfcatch>
</cftry>
</div>
</body>
</html>