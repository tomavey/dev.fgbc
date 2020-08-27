<div class="container">
<cfif regIsOpen()>
<div id="selectoptions" class="span6 showfamilyregs">
<cfoutput query="family" group="id">
<h3>Current registrations for the #lname# family:</h3>

	<cfoutput group="equip_peopleid">
	<div class="well">
		<h2>#fname#</h2>
		<ul>
		<cfoutput group="equip_optionsid">
			<li>#buttondescription#
					<cfif equip_invoicesId NEQ 1115>[#linkto(text="Invoice", controller="conference.register", action="invoice", key=equip_invoicesId)#]</cfif>
			</li>
		</cfoutput>
		</ul>
		#linkTo(text="Add meals or options for #fname#", controller="conference.register", action="addoptions", key=equip_peopleid, id="addOptionsButton", class="btn")#
	</div>
	</cfoutput>


</cfoutput>
	<cfoutput>#linkTo(text="Add a new adult registration", action="selectoptions", params="single=", id="addPersonToFamily", class="btn")#
	<p>&nbsp;</p>
	<cfif childRegIsOpen()>
		#linkTo(text="Add a new child to the #family.lname# family registrations", action="selectoptions", params="familyid=#family.id#&children=", id="addPersonToFamily", class="btn")#
	</cfif>
	</cfoutput>
	</div>
	<cfset cartformaction = "checkOutAddedOptions">
	<div class="pull-right" id="shoppingcart">
	<cfoutput>#includePartial("shoppingcart")#</cfoutput>
	</div>

	<cfif application.wheels.environment is "development">
	<cfdump var="#session.shoppingcart#">
	</cfif>
<cfelse>
	The online registration system is closed.  See you at conference!
</cfif>
</div>