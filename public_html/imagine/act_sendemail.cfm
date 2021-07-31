<cfinvoke component="control" method="get_staff" staffid="#url.id#" returnvariable="thisstaff" />

<cffunction name="getkey" output="no">
<cfargument name="email" required="yes" type="string">
<cfset var key="">
	<cfset key = encrypt(arguments.email,Session.PasswordKey,"CFMX_COMPAT","Hex")>
    <cfreturn key>
</cffunction>

<cfset key = getkey(thisstaff.email)>

<cfif thisstaff.email is "tomavey@fgbc.org">
	<cfset thisstaff.email = "tomavey@comcast.net">
</cfif>

<cfmail from="tomavey@fgbc.org" to="#thisstaff.email#" subject="Your link to the EVLC web site" type="html">
<html>
<head>
<title></title>
</head>
<body>
Here is your link to the EVLC web site: <br />
<a href="http://www.fgbc.org/imagine?key=#key#">http://www.fgbc.org/imagine?key=#key#</a></body>
</html>
</cfmail>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Imagine!</title>
<cfinvoke component="control" method="getstaffinfo" tag="EVLC" returnvariable="staff" />
</head>

<body style="width:500px;margin:0 auto;border:1px solid gray;text-align:center">


<cfoutput>
An email was sent to #thisstaff.email# with your link.
</cfoutput>


</body>
</html>


