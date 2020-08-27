<!DOCTYPE html> 
<html> 
	<title>FGBC Mobile</title> 
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
<head>
	<cfoutput>
		#styleSheetLinkTag("jquery.mobile-1.3.1,mobile,mobilecustom")#    
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
		<cfif application.wheels.environment NEQ "development">
			#javaScriptIncludeTag("jquery.mobile-1.3.1.min")#
		</cfif>
	</cfoutput>
</head>

<body>
<cfoutput>	
 	#includeContent()#
</cfoutput>
</body>
</html>