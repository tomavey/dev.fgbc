<cfparam name="districts" type="query">
<div class="span11">
<cfoutput query="districts">
<p>
<h2>#district#</h2>
<span>#report#</span>
<p>Last updated: #dateformat(updatedAt)#</p>
</p>
<p>&nbsp;</p>
</cfoutput>
</div>