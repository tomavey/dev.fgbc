<<<<<<< HEAD
<html>
<head></head>
<body>
<cfdump var="#cf_template_path#"><cfabort>
<cfset fileToDownload = replace(cf_template_path,"index.cfm","") & "DelinquentChurches2.pdf">
<cffile action="read" file="#fileToDownload#" variable="downloadedfile">
<cfoutput>#downloadedfile#</cfoutput>
</body>
=======
<html>
<head></head>
<body>
<cfdump var="#cf_template_path#"><cfabort>
<cfset fileToDownload = replace(cf_template_path,"index.cfm","") & "DelinquentChurches2.pdf">
<cffile action="read" file="#fileToDownload#" variable="downloadedfile">
<cfoutput>#downloadedfile#</cfoutput>
</body>
>>>>>>> 9771d8480cbcd5a3e762bdebc1d1f9f1c1383ed9
</html>