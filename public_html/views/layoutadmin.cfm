<cfoutput>

<!DOCTYPE HTML>
<html>
	<head>
		<title>Charis Fellowship</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<LINK REL="SHORTCUT ICON" HREF="/images/favicon.ico">


		#styleSheetLinkTag("bootstrap,main,custom,/assets/vendor/icon-awesome/css/font-awesome.min")#

		#javaScriptIncludeTag("jquery.min,bootstrap,responsiveslides.min,iCanHaz.min,application,jquery_ujs,ajaxdelete")#

	</head>
	<body>
		#includePartial("/login")#

		<div id="header-wrapper">
			<div id="header" class="container">
				<div class="row-fluid">
					<div class="span3">
						<div id="logo-wrapper-admin">
							<div><p>&nbsp;<p></div>
						</div>
					</div>

					<div class="span7 offset5">
						#includePartial("/topLinks")#
					</div>
				</div>
				<div class="row-fluid" id="main-links-wrapper">
					<div class="span9 offset3"">
						#includePartial("/mainLinks")#
					</div>
				</div>
			</div>
		</div>
		<div id="content-wrapper">
			<div id="content" class="container">
				#includeContent()#
			</div>
		</div>
#forcecfcatch()#
	</body>
</html>

</cfoutput>