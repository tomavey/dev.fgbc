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
<a href="forum.cfm?tag=#tag#" class="#class#">#lcase(tags.tag)# (#tagCount#)</a>
</cfoutput>
