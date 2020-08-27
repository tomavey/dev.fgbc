<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<!-- Place HTML here that should be used as the default layout of your application -->
<html>
		<cfoutput>
	<head>
			<cfsetting requestTimeout="60">
			#javaScriptIncludeTag("jquery.min.js,ajaxdelete,bootstrap,jquery_ujs,tooltips,conference/admin/scripts")#
			#styleSheetLinkTag("/conference/regreset,/conference/jquery.ui.theme,conference/jquery-ui-timepicker,conference/jquery.ui.core,conference/jquery-ui.custom,conference/data_table,conference/regstyle,bootstrap,bootstrap-responsive.min,/assets/vendor/icon-awesome/css/font-awesome.min")#
	</head>
	<body style="padding-top:40px">
</div>
			#includePartial("/conference/adminnavigation")#
			<div id="contentForLayout">
			#contentForLayout()#
			</div>

		<cfif gotRights("superadmin")>
			#application.wheels.sendemailonerror#<br/>
			#application.wheels.erroremailsubject#<br/>
			<cfif isDefined("session.originalUrl")>
				Original URL:#session.originalUrl#<br/>
			</cfif>
			<cfif isDefined("session.previousUrl")>
				Previous URL#session.previousUrl#<br/>
			</cfif>
		</cfif>

		<!--- <cftry>
			<cfdump var="#cgi#">
			#getPageContext().getRequest().GetRequestUrl()#
		<cfcatch></cfcatch>	
		</cftry> --->

		<cfif isDefined("session.auth.rightslist")>
			<p>#session.auth.rightslist#</p>
		</cfif>

#forcecfcatch()#
	</body>
		</cfoutput>
</html>