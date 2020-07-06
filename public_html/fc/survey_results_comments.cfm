<cfquery datasource="#dsn#" name="comments">
	SELECT comment, name
	FROM cel_survey_10
	WHERE comment <> ""
	ORDER BY datetime DESC
</cfquery>	
<cfoutput query="comments">
<p style="text-align:left;font-size:1em;font-weight:normal;padding:10px">#comment#</p>
<p style="text-align:right;font-size:.7em;color:gray">#name#</p>
<hr>
</cfoutput>
