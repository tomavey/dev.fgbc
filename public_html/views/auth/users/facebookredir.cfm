<cfif isDefined("url.code") and url.state is session.state>
<cfset session.fbcode = url.code>
 
<cfhttp url="https://graph.facebook.com/oauth/access_token?client_id=#application.fbappid#&redirect_uri=#urlEncodedFormat(application.fbredirecturl)#&client_secret=#application.fbsecret#&code=#session.fbcode#">
 
<cfif findNoCase("access_token=", cfhttp.filecontent)>
<cfset parts = listToArray(cfhttp.filecontent, "&")>
<cfset at = parts[1]>
<cfset session.fbaccesstoken = listGetAt(at, 2, "=")>
<cflocation url="http://localhost:8888/index.cfm/auth.users/facebooktest" addtoken="false">
<cfelse>
<!---
This is an error case.
--->
<cfdump var="#cfhttp#">
</cfif>
 
 
 
<cfelseif isDefined("url.error_reason")>
 
<!--- Handle error here. Variables are:
url.error_reason and error_description
--->
 
</cfif>