<cfparam name="params.previouspage" default=0>
<cfparam name="params.nextpage" default=0>
<cfparam name="handbookpeople" type="query">
<cfparam name="allhandbookpeople" type="query">

<div class="postbox" id="maininfo">


<h1>People</h1>


	<div id="stateLinks">
		<cfoutput>#linkto(text="ALL", action="index", params="all=true")#</cfoutput>
		<cfoutput query="allhandbookpeople" group="alpha">
			#linkto(text=alpha, action="index", params="alpha=#alpha#")#
		</cfoutput>
		<cfoutput>#linkto(text="[*]", controller="handbook.positions", action="listpeople", class="tooltipside", title="By Position type")#</cfoutput>
	</div>

	<cfif not isDefined('params.alpha') and not isDefined("params.all")>
		<cfoutput>
			#includePartial("/_shared/paginationlinks")#
		</cfoutput>
	</cfif>

	<div id="ajaxinfo">
	<cfoutput query="handbookpeople" group="alpha">
		<h1>#alpha#</h1>
		<cfoutput group="id">
		<cfset linktext = "#alias('lname',lname,id)#, #alias('fname',fname,id)# <i>#alias('spouse',spouse,id)#</i>: #city#, #state_mail_abbrev#">
		<cfset linktext = left(linktext,50)>
		<cfif find("<i>",linktext) AND not find("</i>",linktext)>
		<cfset linktext = linktext & "</i>">
		</cfif>
		<cfset linktext = replace(linktext,", Non","")>
			<p>
				#linkTo(
					text=linktext,
					action="show",
					key=id,
					id="ajaxclickable",
					class="tooltip2",
					title="Click to show #fname# #lname# in the center panel."
					)#
			</p>
		</cfoutput>
	</cfoutput>
	</div>

	<cfif not isDefined('params.alpha') and not isDefined("params.all")>
		<cfoutput>
			#includePartial("/_shared/paginationlinks")#
		</cfoutput>
	</cfif>


</div>

