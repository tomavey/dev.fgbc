<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Fellowship Council Reports</title>
</head>

<body>
   <cfinvoke component="control" method="get_content_fc" returnvariable="content" id="1">
   <cfinvoke component="control" method="get_content_fc" returnvariable="content2" id="18">
<cfoutput>
   <div id="content">
            <cfoutput>
	   #content2.paragraph#
            </cfoutput>
   </div>
</cfoutput>

</body>
</html>
