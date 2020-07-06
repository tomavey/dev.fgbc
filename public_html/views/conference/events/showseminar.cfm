<div id="seminars">
<cfoutput>
<div class="eachItemShown #params.action#">

		<div class="title">#event.description#</div>
		<p>#event.manager#</p><br/>
		<p>#event.comment#</p>
		<p>[#dateFormat(event.date,"Full")# at #timeFormat(event.timeBegin)#]</p>

</div>
</cfoutput>
</div>