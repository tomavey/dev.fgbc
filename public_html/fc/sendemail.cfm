<cfif url.key NEQ "fcopen">
<cfabort>
</cfif>

<cfinvoke component="control" method="get_staff_email" staffid="#url.id#" returnvariable="thisstaff" />

<cfif thisstaff.email is "tomavey@fgbc.org">
	<cfset email = "tomavey@comcast.net">
<cfelse>
	<cfset email = thisstaff.email>
</cfif>

<cfmail from="tomavey@fgbc.org" to="#email#" subject="Your link to the Fellowship Council web site" type="html">
<html>
<head>
<title></title>
</head>
<body>
Here is your link to the Fellowship Council web site: <br />
<a href="http://www.fgbc.org/fc?code=fellowshipcouncil&email=#thisstaff.email#">http://www.fgbc.org/fc?code=fellowshipcouncil&email=#thisstaff.email#</a></body>
</html>
</cfmail>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FC!</title>
<cfinvoke component="control" method="getstaffinfo" tag="EVLC" returnvariable="staff" />
</head>

<body style="width:500px;margin:0 auto;border:1px solid gray;text-align:center">


<cfoutput>
An email was sent to #email# with your link.
</cfoutput>


</body>
</html>
