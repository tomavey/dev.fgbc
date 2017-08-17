<cfparam name="params.personid" default=0>
<div id='selectworkshops' class="container">
<!---
<h1>We are busy lining up workshops for Flinch Conference however they are not online yet.  We will send out notifications when they are ready.</h1>
--->
<cfif isObject(person)>
<cfoutput>
<h1>Select #pluralize(translateType(params.type))# for #person.fullname#</h1>
#linkto(text="<span style='font-size:.6em'>Not #person.fullname#?</span>", route="selectpersonselectworkshops")#
</cfoutput>
</cfif>

<cfoutput>
	#startFormTag(action=formaction)#
	#hiddenFieldTag(value=params.personid,name="personid")#
	#hiddenFieldTag(value=params.type,name="type")#
	#hiddenFieldTag(name="radioButtonGroups", value="0")#
</cfoutput>

<cfoutput query="workshops" group="eventDate">
<h2>#eventDay# - #eventDate#</h2>
<cfoutput group="radioButtonGroup">
#radioButtonGroup#
#hiddenFieldTag(name="radioButtonGroups", value=radioButtonGroup)#
<table class="eacheventdate table-stripped">
	<tr><td>#radioButtonTag(value=0, name=eventdate, label="No #params.type# for me today!", checked=true)#</td><td>&nbsp;</td></tr>
	<tr><td colspan="2"><hr/></td></tr>
<cfoutput>
	<cfif countsold GTE max AND val(max) NEQ 0>
		<cfset full = "full">
	<cfelse>
		<cfset full = "gotroom">
	</cfif>

	<cfif isInWorkshop(personid=params.personid,workshopid=id)>
		<tr>
			<td>
				#radioButtonTag(
					value=id,
					name=eventdate,
					label="#title#",
					checked=true)# [SELECTED]
			</td>
			<td>
				#linkto(
					text="more info",
					controller="conference.courses",
					action="view",
					key=id,
					target="_new",
					class="moreinfo"
					)#
			</td>
		</tr>
	<cfelseif full is "full">
		<tr>
			<td>
				#radioButtonTag(
					value=id,
					name=eventdate,
					label="#title#",
					disabled="true"
					)#
			</td>
			<td>
				<span class="moreinfo">FULL!</span>
			</td>
		</tr>
	<cfelse>
		<tr>
			<td>
				#radioButtonTag(
					value=id,
					name="#eventdate##radioButtonGroup#",
					label="#title#"
					)#
			</td>
			<td>
				#linkto(
					text="More info",
					controller="conference.courses",
					action="view",
					key=id,
					target="_new",
					class="moreinfo"
					)#
			</td>
		</tr>
	</cfif>

	<tr><td colspan="2"><hr/></td></tr>
</cfoutput>
</table>
</cfoutput>
</cfoutput>

<cfoutput>
	#submitTag("Sign Me Up!")#
	#endFormTag()#
</cfoutput>
</div>