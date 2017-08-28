<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing Events</h1>
<cfoutput>
	<p>#linkTo(text="Create a new Event", action="new")#</p>
</cfoutput>
<table class="table">
<cfoutput>
<tr>
	<th>
		#linkTo(text="Event", params="sortby=event")#
	</th>
	<th>
		<cfif isDefined("params.sortby") && params.sortby is "ascendingDates">
			#linkTo(text="Begin &uarr;", params="")#
		<cfelseif isDefined("params.sortby") && params.sortby NEQ "ascendingDates">
			#linkTo(text="Begin &darr;", params="sortby=ascendingDates")#
		<cfelse>	
			#linkTo(text="Begin &darr;", params="sortby=ascendingDates")#
		</cfif>
	</th>
	<th>
		End
	</th>
	<th>
		#linkTo(text="Sponsor", params="sortby=sponsor")#
	</th>
	<th>
		&nbsp;
	</th>
</tr>
</cfoutput>
<cfoutput query="events">
	<tr>
		<td>
			#linkTo(text=event, href=eventlink)#
		</td>
		<td>
			#dateformat(Begin,'medium')#
		</td>
		<td>
			#dateformat(end,'medium')#
		</td>
		<td>
			#linkto(text=sponsor, href=sponsorlink)#
		</td>
		<td>
			#showTag()# #editTag()# #deleteTag(class="noajax")# #copyTag()#
		</td>
	</tr>
	
</cfoutput>
</table>
				
<cfoutput>
	<p>#linkTo(text="Create a new Event", action="new")#</p>
</cfoutput>

</div></div>