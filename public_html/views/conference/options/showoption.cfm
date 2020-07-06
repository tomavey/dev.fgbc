<cfoutput query="option">
<div class="buttondescription"><h1>#BUTTONDESCRIPTION#: <cfif val(cost)>#dollarformat(cost)#<cfelse>Included</cfif></h1></div>
<div class="description">
#description#
</div>
<div class="ad">
#ad#
</div>
</cfoutput>
