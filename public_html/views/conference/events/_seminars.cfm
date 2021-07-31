<cfoutput>	
	<div class="eachItemShown">
		<div class="title">#description#</div>
		<p>#manager#</p><br/>
		<p>#comment#</p>
		<p>[#dateFormat(date,"Full")# at #timeFormat(timeBegin)#] [#linkTo(text="Link", controller="events", action="showseminar", key=id)#]</p>
	</div>
</cfoutput>