<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
	<cfoutput>
		#styleSheetLinkTag("bootstrap,forums,/assets/vendor/icon-awesome/css/font-awesome.min")#    	

		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		#javaScriptIncludeTag("jquery_ujs")#
	</cfoutput>
</head>

<body>
	<cfoutput>
		#includePartial("navbar")#
	</cfoutput>
	<div class="container">
		<cfoutput>#contentForLayout()#</cfoutput>
	</div>	
	<cfoutput>		
		#javaScriptIncludeTag("forums,bootstrap")#
	</cfoutput>
</body>

</html>

