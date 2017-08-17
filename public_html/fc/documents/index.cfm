<html>
<head></head>
<body>
<cfdump var="#cf_template_path#"><cfabort>
<cfset fileToDownload = replace(cf_template_path,"index.cfm","") & "DelinquentChurches2.pdf">
<cffile action="read" file="#fileToDownload#" variable="downloadedfile">
<cfoutput>#downloadedfile#</cfoutput>
</body>
</html>