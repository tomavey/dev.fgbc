<cfif !isDefined("errormessage")>
	<cfparam name="listOfNamesInRegCart" type="string">
	<cfparam name="rc" type="struct">
	<cfparam name="sc" type="array">
	<cfparam name="formaction" type="string">
	<cfparam name="thisperson" default="">

	<cfoutput>
	<cfset cartTotal = 0>

	<div class="container">


	<!---Loop through each person in the registration cart--->
	<cfloop list="#listOfNamesInRegCart#" index="i">

	<!---Set the query string for links to edit each person--->
	<cfset editQueryString = "">
	<cfset editQueryString = "person="&urlEncodedFormat(i)>

	<!---Create the name or couples name for this person--->

	<cfset thisperson = rc[i].fname>

	<cftry>
		<cfif rc[i].sname is not "" and (rc[i].fname is not rc[i].sname)>
			<cfset thisperson = thisperson & " and " & rc[i].sname>
		</cfif>
		<cfcatch></cfcatch>
	</cftry>

	<!---if usecontactfrom is set, grab lname and contact informtion from that person--->
	<cfset iii = i><!---Set a temporary person variable for address info--->

	<cfif len(rc[iii].usecontactfrom)>
		<cfset iii = rc[iii].usecontactfrom>
		<cfset rc[i].lname = rc[iii].lname>
	</cfif>

	<cfset thisperson = thisperson & " " & rc[i].lname>


		<div class="eachregistration">
			<div class="personsname"><span>#thisperson#</span><br/>
				<cfif len(rc[i].email)>
					<cfif rc[i].email is "parent">
						Use Parent's email
					<cfelse>
					#rc[i].email#
					</cfif>
					<br/>
				</cfif>
				<cfif len(rc[i].phone)>#rc[i].phone#<br/></cfif>
			</div>
			<div class="address">
				<cfif rc[iii].address is not "">#rc[iii].address#<br/></cfif>
				<cfif rc[iii].city is not "">#rc[iii].city#, </cfif>
				<cfif rc[iii].handbook_statesID is not "">#getState(rc[iii].handbook_statesID).stateabbrev# </cfif>
				<cfif rc[iii].province is not "">#rc[iii].province# </cfif>
				<cfif rc[iii].zip is not "">#rc[iii].zip#<br/></cfif>
				<cfif rc[iii].country is not "">#rc[iii].country#<br/></cfif>

				[#linkTo(action="person", params="person=#iii#", text="Edit this person's information")#]

				<cfset iii="">
			</div>

			<div class="registeredfor">
	<table class="shoppingCartReview">
		<tr>
			<th colspan="3" class="person">
				Items selected for #thisperson#
			</th>
		</tr>


				<cfset thisTotal = 0>

				<cfloop from="1" to="#arraylen(sc)#" index="ii">
					<cfif sc[ii].person is i>

	<!---Each Item for this person--->
		<tr>
			<td class="regdescription">
				#getOptionDescriptionAndPrice(sc[ii].item).buttondescription#&nbsp;-
			</td>
			<td class="quantity">
				#sc[ii].quantity#&nbsp;@
			</td>
			<td class="price">
				<cfset pricetotal = val(getOptionDescriptionAndPrice(sc[ii].item).cost)*val(sc[ii].quantity)>
				#dollarformat(pricetotal)#
			</td>
		</tr>

					<cfset thisTotal = pricetotal + thisTotal>
					<cfset editQueryString = editQueryString & "&" & sc[ii].item & "=" & sc[ii].quantity>

					</cfif>


				</cfloop>
	<!---	<tr>
			<th colspan="3" class="person">
				[#linkto(text="Edit these items", controller="register", action="selectOptions", params="#editQueryString#&return=showregs")#]
			</th>
		</tr>
	--->
	</table>

					Total for #rc[i].fname# = #dollarformat(thisTotal)#

				<cfset cartTotal = cartTotal + thisTotal>
			</div>
		</div>


	</cfloop>

		<div id="cartTotal">
			<cfif cartTotal LT 0>
				Cart Total = #dollarformat(0)#<br/>
				<span style="font-size:.7em">Cart total cannot be less than $0</span>
			<cfelse>
				Cart Total = #dollarformat(cartTotal)#<br/>
			</cfif>
			<cfif isdefined("session.shoppingcart[1].groupRegId")>
				#linkTo(text="Finalize this Registration", action=formaction, class="btn")#
			<cfelse>
				#linkTo(text="Proceed to Payment Center", action=formaction, class="btn")#
			</cfif>
		</div>

	</cfoutput>

	</div>

<cfelse>
	<div class="container">
		<cfoutput>
			<div class="text-center alert">#errormessage#</div>
		</cfoutput>
	</div>
</cfif>

<!---
<cfif application.wheels.environment is "development">
<cftry>
	session.registrationcart:<br/>
	<cfdump var="#session.registrationCart#">
	session.shoppingcart:<br/>
	<cfdump var="#session.shoppingcart#">
	Params:<br/>
	<cfdump var="#params#">
<!---
	<cfdump var="#application.wheels#">
 --->
 <cfcatch></cfcatch>
 </cftry>
</cfif>
--->