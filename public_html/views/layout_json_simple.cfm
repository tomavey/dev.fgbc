<cfsetting enablecfoutputonly="true">
<cfheader name="Access-Control-Allow-Origin" value="*" />
<cfheader name="Access-Control-Allow-Methods" value="GET,PUT,POST,DELETE" />
<cfheader name="Access-Control-Allow-Headers" value="Content-Type" />
<cfheader name="Access-Control-Allow-Credentials" value="true" />
<cfheader name="Content-Type" value="text/html">

<cfoutput>#contentForLayout()#</cfoutput>
<!---
<cfdump
    var="#GetHttpRequestData()#"
    label="GetHttpResponseData() Values"
    />
--->
</cfsetting>