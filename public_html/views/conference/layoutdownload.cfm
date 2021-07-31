<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfparam name="pagetitle" default="Excel Download">
<cfparam name="params.download" default=1>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<cfif params.download>
<cfheader name="Content-disposition" value="inline;filename=data.xls">
<cfcontent type="application/msexcel">
</cfif>

<cfoutput>
<title>#pagetitle#</title>
</head>
<body>
#contentForLayout()#
</body>
</cfoutput>
</html>