<!--- Place HTML here that should be used as the default layout of your application --->
<html>
<title>Nominations For Fellowship Council</title>
<head>
<cfoutput>
		#styleSheetLinkTag("bootstrap,nominations,,/assets/vendor/icon-awesome/css/font-awesome.min")#
</cfoutput>
</head>	
	<body>
		<div class="container" id="nominations">
			<cfoutput>#includeContent()#</cfoutput>
		</div>
	</body>
</html>