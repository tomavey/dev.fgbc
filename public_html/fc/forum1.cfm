<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<cfif form.lname is "">
<cfset session.message_lname = "Last Name required">
<cfif form.post is "">
<cfset session.message_post = "Comment cannot be blank">
<cflocation url="forum.cfm">
</cfif>
</cfif>

<cfquery datasource="#dsn#" name="userdata">
select staffid, fname, email
from staff 
where lname = '#form.lname#'
</cfquery>

<cfif userdata.staffid is "">
<cflocation url="forum.cfm">
</cfif>

<cfquery datasource="#dsn#">
insert into fc_forum (staffid, topic, post, lname, fname)
values (#userdata.staffid#, 'FC Terms', '#post#', '#form.lname#', '#form.fname#')
</cfquery>

<cfif post is "tda">
<cfoutput>
<cfmail from="tomavey@fgbc.org" to="tomavey@fgbc.org" subject="FC Forum Comment" type="html">
The following message was posted on the comment by #fname# #lname#:<br /><br />
#post#

Please add your ideas at <a href="http://www.fgbc.org/fc/forum.cfm">www.fgbc.org/fc/forum.cfm</a><br />
username = "fc"<br />
password = "ggl"
</cfmail>
</cfoutput>
<cfelse>
<cfoutput>
<cfmail from="tomavey@fgbc.org" to="pastorlarry@lvgbc.org; Pastordoug@fgbc.org; svgbcle@zoominternet.net; tomhocking@fgbc.org; newbeginnings@nbn.net; andy@wrgbc.com; dan@cofh.com; jmcintosh@gracebrethren.com; psparling@auburninternet.com; pastortim@pvcwired.com; pulpitguy@tracygrace.org; jbrown@gracecommunity-church.com; dano@gcwired.com; rsmals@neo.rr.com; nmzak@earthlink.net; Revjoyce411@aol.com; ocnpat@msn.com; jerichards@sbcglobal.net; sandy@fgbc.org; Revjoyce411@aol.com; ocnpat@msn.com; tomavey@fgbc.org" subject="FC Forum Comment" type="html">
The following message was posted on the comment by #fname# #lname#:<br /><br />
#post#

Please add your ideas at <a href="http://www.fgbc.org/fc/forum.cfm">www.fgbc.org/fc/forum.cfm</a><br />
username = "fc"<br />
password = "ggl"
</cfmail>
</cfoutput>
</cfif>

<cflocation url="forum.cfm">

<body>
</body>
</html>
