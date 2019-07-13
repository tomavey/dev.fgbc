<cfsetting enablecfoutputonly="true">
<cfheader name="Access-Control-Allow-Origin" value="http://localhost:8080" />
<cfoutput>#contentForLayout()#</cfoutput>
<!---
<cfdump
    var="#GetHttpRequestData()#"
    label="GetHttpResponseData() Values"
    />
--->
</cfsetting>