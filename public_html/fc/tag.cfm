<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Tagger</title>
<link href="tags.css" rel="stylesheet" type="text/css">

</head>

<cfif isdefined("form.submit")>
<cfset tagsarray = arraynew(1)>
<cfset tagsarray = listtoarray(tags, " ")>
<cfoutput>
<cfloop index="counter" from="1" to=#arraylen(tagsarray)#>

<cfquery datasource="#dsn#">
insert into fc_tags (item_id, tag)
values ('#form.id#', '#tagsarray[counter]#')
</cfquery>
</cfloop>
</cfoutput>
</cfif>

<cfquery datasource="#dsn#" name="tags">
select *
from fc_tags
where item_id = #url.id#
</cfquery>

<cfset tagnew = "">
<cfoutput query="tags">
<cfset tagnew = "#tag#" & " " & "#tagnew#">
</cfoutput>

<body>
<table>
<tr>
<td><cfoutput><form action="" method="post">
<input name="tags" type="text" size="100" maxlength="100" <cfif tags.recordcount GT 0>value="#tagnew#"</cfif>/>
<input name="submit" type="submit" value="submit" />
<input name="id" type="hidden" value=#url.id# />
</form></cfoutput>
</td>
</tr>
</table>

<cfquery name="tags" datasource="#dsn#">
SELECT COUNT(tag) AS tagCount, tag
FROM fc_tags
GROUP BY tag
ORDER BY tag ASC
</cfquery>
<!--- Calulate the frequency --->
<cfset tagValueArray = ListToArray(ValueList(tags.tagCount))>
<cfset max = ArrayMax(tagValueArray)>
<cfset min = ArrayMin(tagValueArray)>
<!--- Calculate the difference --->
<cfset diff = max - min>;
<cfset distribution = diff / 4>
<cfoutput query="tags">
<cfif tags.tagCount EQ min>
<cfset class="smallestTag">
<cfelseif tags.tagCount EQ max>
<cfset class="largestTag">
<cfelseif tags.tagCount GT (min + (distribution*2))>
<cfset class="largeTag">
<cfelseif tags.tagCount GT (min + distribution)>
<cfset class="mediumTag">
<cfelse>
<cfset class="smallTag">
</cfif>
<a href="index.cfm?tag=#tag#" class="#class#">#lcase(tags.tag)# (#tagCount#)</a>
</cfoutput>


</body>
</html>
