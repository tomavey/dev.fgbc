<cfparam name="states" type="query">
<cfparam name="peoplelist" default="">
<cfparam name="formFieldList" type="string">
<cfparam name="formaction" type="string">
<cfparam name="formparams" type="string">
<cfparam name="params" type="struct">
<cfparam name="params.iscouple" default="false">
<cfparam name="instructions" default="Before proceeding we need more information about each person you are registering...">
<cfparam name="isGroupReg" default="false">
<cfparam name="familyInfoLegend" default="Family Information: ">
<cfparam name="displayClass" default="showfield">

<cfif session.registration.regType is "group">
	<cfset instructions = "Now give us a little more information about the facilitator for this group so we can contact you later.">
	<cfset displayClass = "hidefield">
	<cfset familyInfoLegend = "Facilitator's Last Name:">
	<cfset isGroupReg = true>
</cfif>

<div class="container">


<div id="personForm">
<cfoutput>

<cfif flashKeyExists("message")>
<p class="Message">
#flash("message")#
</p>
</cfif>

	#startFormTag(action=formaction, spamProtection=true, params=formparams)#
	#hiddenFieldTag(name="key", value=params.key)#
	#hiddenFieldTag(name="thisperson", value=params.thisperson)#
	#hiddenFieldTag(name="type", value=params.regtype)#
	<div id="instructions">#instructions#</div>
	<span id="requiredinfo">* = required information</span>
	<fieldset id="personInfo">
	<legend><span id="regabout">...About #params.thisperson# </span></legend>
		<span class="#displayClass#">
			#textFieldTag(name="fname", value=params.fname, label="* Registrants first name: ", value=params.fname)#
		</span>

		<span class="#displayClass#">
			#selectTag(name="gender", options="Male,Female", selected=params.gender, label="#params.fname#'s Gender: ")#
		</span>	
		<cfif (params.regtype is "Adult" AND params.isCouple)>
			#textFieldTag(name="sname", value=params.sname, label="Spouses first name: ")#
		<cfelse>
			#hiddenFieldTag(name="sname", value=params.sname)#
		</cfif>
		<cfif params.regtype is "Adult">
		#textFieldTag(name="email", value="#params.email#", label="* Email: ")#
		#textFieldTag(name="phone", value="#params.phone#", label="Cell Phone:")#
		<cfelse>
			#hiddenFieldTag(name="email", value="parent")#
			#hiddenFieldTag(name="phone", value="")#
		</cfif>
		<span class="#displayClass#">
			#selectTag(name="age", valueField="id", selected=params.age, textfield="description", options=ageRanges, label="Age Range: ", includeBlank="Select an Age Range")#
		</span>	
	</fieldset>

	<br/>

		<fieldset id="familyInfo">
		<legend>#familyInfoLegend#</legend>
			<cfif isdefined("thisfamily")>
				<div class="familyInfo">
					<p>
					#hiddenFieldTag(name="familyid", value=thisfamily.id)#
					<span class="lname">#thisfamily.lname#</span><br/>

					<div class="optional">
						<cfif len(thisfamily.address) AND thisfamily.address NEQ "test">
							#thisfamily.address#<br/>
						</cfif>
						<cfif len(thisfamily.city)>
							#thisfamily.city#,
						</cfif>
						<cfif len(thisfamily.state.state)>
							#thisfamily.state.state#
						</cfif>
						<cfif len(thisfamily.zip)>
							#thisfamily.zip#<br/>
						</cfif>
						<cfif len(thisfamily.province)>
							#thisfamily.province#
						</cfif>
						<cfif len(thisfamily.country)>
							#thisfamily.country#<br/>
						</cfif>
						<cfif len(thisfamily.email)>
							#thisfamily.email#
						</cfif>
						<cfif len(thisfamily.phone)>
							#thisfamily.phone#<br/>
						</cfif>
					</div>

					</p>

					#hiddenFieldTag(name="lname", value=thisfamily.lname)#
					#hiddenFieldTag(name="address", value=thisfamily.address)#
					#hiddenFieldTag(name="city", value=thisfamily.city)#
					#hiddenFieldTag(name="handbook_statesID", value=thisfamily.state.id)#
					#hiddenFieldTag(name="zip", value=thisfamily.zip)#
					#hiddenFieldTag(name="city", value=thisfamily.city)#
					#hiddenFieldTag(name="province", value=thisfamily.province)#
					#hiddenFieldTag(name="country", value=thisfamily.country)#
					#hiddenFieldTag(name="familyemail", value=thisfamily.email)#
					#hiddenFieldTag(name="familyphone", value=thisfamily.phone)#
					#hiddenFieldTag(name="usecontactfrom", value="")#

				</div>
			<cfelse>
				<cfif len(peoplelist)>
					<div id="useContactFrom" class="#displayClass#">
						#selectTag(name="useContactFrom", options=peoplelist, includeBlank="No One", label="Copy family information from: ", class="useSameFamilyInfo" )#
					</div>
				<cfelse>
					#hiddenFieldTag(name="useContactFrom", value="")#
				</cfif>

				<div class="familyInfo">
				#textFieldTag(name="lname", value=params.lname, label="* Last name: ")#
					<div class="optional">
						#textFieldTag(name="address", value="#params.address#", label="Address:(optional)  ")#
						#textFieldTag(name="city", value="#params.city#", label="City:(optional) ")#
						#selectTag(name="handbook_statesID", options=states, label="State: (optional)", includeBlank="Select a State")#
						#textFieldTag(name="zip", value="#params.zip#", label="Zip: (optional)")#
						#textFieldTag(name="province", value="#params.province#", label="Province: (optional)")#
						#textFieldTag(name="country", value="#params.country#", label="Country: (optional)")#
						#textFieldTag(name="familyEmail", value="#params.familyemail#", label="Family Email: (optional)")#
						#textFieldTag(name="familyPhone", value="#params.familyphone#", label="Family Phone: (optional)")#
					</div>
				</div>
			</cfif>
		</fieldset>

		<br/>

		<span class="#displayClass#">
		<fieldset id="specialNeeds">
		<legend>Special Needs (for children only): </legend>
			#textAreaTag(name="specialneeds", value="#params.specialneeds#")#

		</fieldset>
		</span>

	#submitTag("#submitbutton#")#
	#endFormTag()#

<!---
<cfif application.wheels.environment is "development">

	<cftry>
		Registration Cart:
		<cfdump var="#session.registrationCart#">
	<cfcatch></cfcatch></cftry>

	<cftry>
		<cfloop list="#structKeyList(session.registrationCart)#" index="i">
			<cfdump var="#getCartPersonsType(session.registrationCart[i])#">
		</cfloop>
	<cfcatch></cfcatch></cftry>

	Shopping Cart:
	<cfdump var="#session.shoppingcart#">

	Params:
	<cfdump var="#params#">
</cfif>
--->

</cfoutput>
</div>
</div>