<div class="eachItemShown" id="familyRegs">
<cfoutput query="family" group="id">
<h1>Family name:#lname#</h1>
	
	<cfoutput group="equip_peopleid">
		<h2>#fname#</h2>
		<ul>
		<cfoutput group="equip_optionsid">
			<li>#buttondescription# [#linkto(text="Invoice", controller="register", action="invoice", key=equip_invoicesId)#]</li>
		</cfoutput>
		</ul>
		#buttonTo(text="Add to the registration for #fname#", controller="register", action="addoptions", key=equip_peopleid)#
	</cfoutput>

</cfoutput>

</div>