<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfparam name="pagetitle" default="Vision Conference">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<cfif isdefined("params.download")>
<cfheader name="Content-disposition" value="inline;filename=data.doc">
<cfcontent type="application/msword">
</cfif>

<cfoutput>
#styleSheetLinkTag(source="print", media="all")#
<link rel="stylesheet" href="/stylesheets/conference/bootstrap.css" type="text/css">
<link rel="stylesheet" href="/stylesheets/conference/mobile.css" type="text/css">
<title>#pagetitle#</title>
</head>
<body>
#contentForLayout()#
</body>
</cfoutput>
</html>