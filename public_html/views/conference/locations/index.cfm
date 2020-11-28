<h1>Listing locations</h1>
<cfoutput>
<div class="eachItemShown #params.action#">
</cfoutput>
<cftable query="locations" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Room Number or Name" text="#roomnumber#" />
				
					<cfcol header="Capacity" text="#capacity#" />
				
					<cfcol header="Size" text="#size#" />
				
					<cfcol header="Equipment" text="#left(equipment,15)#" />
				
					<cfcol header="Setup" text="#defaultsetup#" />
				
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag(class="noajax")#" />
	<cfcol header="" text="#copyTag()#" />
</cftable>

<cfoutput>
	<p>#addTag()#</p>
	<p>Count: #locations.recordcount#</p>
	<p>#linkto(text="Duplicate #getPreviousEvent()# locations into #getEvent()#.", action="conference.locations", action="copyAllToCurrentEvent", class="btn pull-right")#</p>
	<P>
		Maps:
		#includePartial(partial="maps")#
	</P>
	<p>#linkto(text="View Simple List", action="list")#</p>

</cfoutput>
