<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<cfif form.lname is "">
<cfif form.post is "">
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

<cfif isdefined("post.file_forum")>
<cffile filefield="file_forum" action="upload" nameconflict="makeunique" accept="image/jpg" destination="http://www.fgbc.org/fc/forumdocs"></cfif> 


<cflocation url="forum.cfm">

<body>
</body>
</html>
