<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Listing Events</h1>
<cfoutput>
	<p>#linkTo(text="Create a new Event", action="new")#</p>
</cfoutput>
<table class="table">
<tr>
	<th>
		Event
	</th>
	<th>
		Begin
	</th>
	<th>
		End
	</th>
	<th>
		Sponsor
	</th>
	<th>
		&nbsp;
	</th>
</tr>
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