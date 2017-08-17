<cfparam name="districts" type="query">
<div class="span11">
<cfoutput query="districts">
<h2>#district#</h2>
<p>#report#</p>
</cfoutput>
</div>