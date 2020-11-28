<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
	<cfsetting requestTimeOut="60">
	<cfoutput>
		#styleSheetLinkTag("bootstrap,handbook,/assets/vendor/icon-awesome/css/font-awesome.min")#
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

		#javaScriptIncludeTag("bootstrap,jquery_ujs,custom")#

	<!-- Favicon -->
	<link rel="shortcut icon" href="/assets/img/favicon2.ico">

	</cfoutput>
</head>

<body style="padding-top: 60px;">
	<cfoutput>
		#includePartial(partial="/handbook/navbaragbm")#
	</cfoutput>
	<div class="container">
		<cfoutput>#contentForLayout()#</cfoutput>
	</div>
	<cfoutput>
		#javaScriptIncludeTag("handbook,bootstrap")#
	</cfoutput>
</body>

</html>

