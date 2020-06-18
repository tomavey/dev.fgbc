<cfparam name="params.previouspage" default=0>
<cfparam name="params.nextpage" default=0>
<cfparam name="handbookorganizations" type="query">
<cfparam name="linkToTextMaxLength" default = 75>
<cfset count = 0>

<cfif isDefined("params.showAtt")>
	<cfset request.showAtt = true>
	<cfset totalAtt = 0>
<cfelse>
	<cfset request.showAtt = false>
</cfif>

<div class="postbox" id="maininfo">

<h1>Churches and Organizations</h1>

	<p id="statelinks">
		<cfoutput>#linkto(text="ALL", action="index")#</cfoutput>
		<cfoutput query="states" group="state_mail_abbrev">
			#linkto(text=state_mail_abbrev, action="index", params="state=#state_mail_abbrev#", class="tooltip2", title="Churches in #state#.")#
		</cfoutput>
	</p>
	<p>&nbsp;</p>
	<cfif isDefined("districts")>
	<p id="districtlinks">
		<cfoutput query="districts">
			<cfif district does not contain "empty" AND district does not contain "Ministry">
				#linkto(text=district, action="index", params="district=#districtid#", class="tooltip2", title="Churches in the #district# district.")#;
			</cfif>
		</cfoutput>
	</p>
	</cfif>
	<cfif request.showpagination>
		<cfoutput>
			#includePartial("/_shared/paginationlinks")#
		</cfoutput>
	</cfif>

<div id="ajaxinfo">
	<cfoutput query="handbookorganizations" group="state">
		<h2>#state#</h2>
		<cfoutput>
		<p><cfset linkToText = "#name#: #listedAsCity(org_city,listed_as_city)# #state_mail_abbrev#">
			<cfif len(linkToText) GTE linkToTextMaxLength-3>
				<cfset linkToText = linkToText & "...">
			</cfif>
			#linkTo(
				text=left("#linkToText#",linkToTextMaxLength),
				route="handbookOrganization",
				key=id,
				class="tooltip2 ajaxclickable",
				title="Click to show #name# in the center panel."
				)#
		<cfif request.showAtt>
			<cfset thisatt = getAtt(id)>
			<cfif val(thisatt)>
				<cfset totalAtt = totalAtt + thisatt>
			</cfif>
			#thisatt#
		</cfif>
		</p>
		<cfset count = count + 1>
		</cfoutput>
	</cfoutput>
</div>

	<cfif request.showpagination>
		<cfoutput>
			#includePartial("/_shared/paginationlinks")#
		</cfoutput>
	</cfif>
<hr/>
<p>
	<cfoutput>
		Count = #count#<br/>
		<cfif request.showAtt>
		Total Attendance in #year(now())-1#: #Totalatt#
		</cfif>
	</cfoutput>
</p>
</div>

