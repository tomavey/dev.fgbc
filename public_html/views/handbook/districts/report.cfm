<cfparam name="districts" type="query">
<div class="span11">
<cfoutput query="districts">
<p>
<h2>#district#</h2>
<span>#report#</span>
</p>
</cfoutput>
</div>