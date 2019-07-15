<cfsetting enablecfoutputonly="true">
<cfheader name="Access-Control-Allow-Origin" value="*" />

<cfoutput>#contentForLayout()#</cfoutput>
<!---
<cfdump
    var="#GetHttpRequestData()#"
    label="GetHttpResponseData() Values"
    />
--->
</cfsetting>