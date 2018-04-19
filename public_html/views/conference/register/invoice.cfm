<cfscript>
	totalCost=0;
	totalMeals=0;
	totalChildCare=0;
	totalReg=0;
	totalPreConf=0;
	totalExcursion=0;
	totalOther=0;
	totalChildDiscount=0;
	totalDiscount=0;
	totalAll=0;
	errorInTotal="";
	public function isPublic(){
		if (params.controller is "conference.Register") {
			return true;
		}
		elseif (params.controller is "invoice"){
			return false;
		}
		else {
			return false;
		};
	}
</cfscript>

<cfparam name="thisinvoice" type="struct">
<cfparam name="optionsInThisInvoice" type="query">
<cfparam name="containsGroupReg" default="false">
<cfparam name="groupRegId" default=0>
<cfset ageRanges = model("Conferenceage_range").findAll(where="type='adult'", order="name")>

<cftry>
<cfset session.conference.invoiceid = params.key>
<cfcatch></cfcatch></cftry>

<cfoutput>

	<div id="invoice" class="container">
	<cfif isPublic()>
		<p>
			Thank you for registering for the #getEventAsText()#. Please print this out for your records. When you arrive at conference, proceed to the registration table and pick up your registration packet including all items in this receipt. No refunds after July 15.
		</p>
	</cfif>
		<div id="invoicePayment">
			<ul>
				<li><span class="invoiceItem">Order Id:</span> #thisinvoice.ccorderid#</li>
				<li><span class="invoiceItem">Amount:</span> #dollarformat(thisinvoice.ccamount)#</li>
				<li>
					<span class="invoiceItem">Status:</span> #payStatus(thisinvoice.ccstatus)# 
					<cfif gotRights("office") && isDefined("params.key") && (payStatus(thisinvoice.ccstatus) is "Pending" || payStatus(thisinvoice.ccstatus) is "temp" || payStatus(thisinvoice.ccstatus) is "TBD")>
						#linkto(text="Mark Paid", route="conferenceInvoicesMarkPaid", params="id=#params.key#", onlyPath=false, class="pull-right")#
					</cfif>	
				</li>
				<cfif thisinvoice.ccname NEQ "NA">	
					<li><span class="invoiceItem">Name on card:</span> #thisinvoice.ccname#</li>
				</cfif>
				<li><span class="invoiceItem">Date:</span> #dateformat(thisinvoice.updatedat,"medium")#</li>
				<cfif thisinvoice.ccemail NEQ "NA">
					<li><span class="invoiceItem">Email on card:</span> #thisinvoice.ccemail#</li>
				</cfif>
			</ul>
				<cfif !isPublic()>
					#editTag(controller="conference.invoices", id=params.key)#
					#deleteTag(controller="conference.invoices", id=params.key, class="noajax")#
				</cfif>
		</div>
		<cfif payStatus(thisinvoice.ccstatus) is "Pending">
			This invoice is marked with a status of "Pending" because we are waiting on confirmation from our payment center that payment was successfully processed.  We will contact you if we need additional information to complete payment. In other words... "No news is good news!".
		</cfif>
</cfoutput>
		<!---

		<cfdump var="#optionsInThisInvoice#"><cfabort>
 --->

		<div id="invoiceItems">
			<p>Registration Items Ordered:</p>
			<table>
				<tr>
					<th>&nbsp;</th>
					<th>Quantity</th>
					<th class="optionCost">Cost (Each)</th>
				<cfif !isPublic()>
					<th>&nbsp;</th>
				</cfif>
				</tr>
				<cfoutput query="optionsInThisInvoice" group="conferencepersonid">

					<tr class="invoiceRegName">
						<td colspan="3">
							<cfset sname = getspouse(conferencepersonid).fname>

							<cfif gotRights("office")>
								#linkto(text=fname, controller="conference.people", action="show", key=equip_peopleid, target="_new")#
							<cfelse>		
								#fname#
							</cfif>

						<cftry>
							<cfif len(sname) and fname NEQ sname>
							and #sname#
							</cfif>
						<cfcatch></cfcatch></cftry>
							#lname#
						</td>
		<cfif !isPublic()>
					<td>#linkTo(text="<i class='icon-plus'></i>",controller="conference.registrations", action="addnew", key=params.key, params="pid=#conferencepersonid#&iid=#params.key#", title="add a reg item to #fname#", class="popup")#</td>
		</cfif>
					</tr>
				<cfoutput>
					<tr class="optionItem">
						<td class="buttondescription">#buttondescription#</td>
						<cfif findNoCase("group",buttondescription) && quantity GT 0>
							<cfset containsGroupReg = true>
							<cfset groupRegId = id>
						</cfif>
						<td class="quantity">#quantity#</td>
						<td class="optionCost">#dollarformat(cost)#</td>
						<cfif !isPublic()>
							<td>
								#editTag(controller="conference.registrations", action="edit", key=ID)#
								#linkto(text="<i class='icon-trash'></i>", route="conferenceDeleteregistration", key=ID, onclick="return confirm('Are you sure?')")#
							</td>
						</cfif>
					</tr>
					<cfset totalCost= totalCost + (val(cost) * val(quantity))>

						<!---Add up totals--->
						<cftry>
						<cfif type is "meal">
							<cfset totalMeals = totalMeals + (val(quantity) * val(cost))>
						</cfif>
						<cfif type contains "Registration">
							<cfset totalReg = totalReg + (val(quantity) * val(cost))>
						</cfif>
						<cfif type is "PreConference">
							<cfset totalPreConf = totalPreConf + (val(quantity) * val(cost))>
						</cfif>
						<cfif type is "excursion">
							<cfset totalExcursion = totalExcursion + (val(quantity) * val(cost))>
						</cfif>
						<cfif type is "other">
							<cfset totalOther = totalOther + (val(quantity) * val(cost))>
						</cfif>
						<cfif type contains "GraceKids">
							<cfset totalChildCare = totalChildCare + (val(quantity) * val(cost))>
						</cfif>
						<cfif type is "discount">
							<cfset totalDiscount = totalDiscount + (val(quantity) * val(cost))>
						</cfif>
						<cfif type is "autodiscount" AND name contains "children">
							<cfset totalChildDiscount = totalChildDiscount + (val(quantity) * val(cost))>
						</cfif>
						<cfcatch><cfset errorInTotal = "NA"></cfcatch></cftry>

					</cfoutput>

				</cfoutput>
		<cfif !isPublic()>
			<cfoutput>
			<tr class="invoiceRegName">
					<td>#linkTo(text='<i class="icon-user"></i><i class="icon-plus"></i>', controller="conference.people", action="new", params="invoiceid=#optionsInThisInvoice.equip_invoicesid#", title="add a new person", class="popup")#</td>
					<td span="3">
			</tr>
			</cfoutput>
		</cfif>

				<tr><cfoutput>
				<cfif totalcost LT 0>
					<td colspan="3" id="totalCost">Total: #dollarformat(0)#</td>
				<cfelse>
					<td colspan="3" id="totalCost">Total: #dollarformat(totalCost)#
					</td>
				</cfif>
				</cfoutput></tr>
			</table>
			<div id="addregs">
				<cfoutput query="optionsInThisInvoice" group="conferencefamilyid">

					<cfif !findNoCase("group",buttondescription)>
						<cfset thisEmail = structNew()>
						<cfset thisEmail.subject = urlEncodedFormat("Your #getEventAsText()# Registration")> 
						<cfset thisEmail.body = "Greetings!%20%20%0D%0DThank%20you%20for%20registering%20for%20#getEventAsTExt()#.%0D%0DHere%20are%20a%20links%20to%20purchase%20meal%20tickets%20and%20signup%20for%20cohorts:%0D%0DAdd%20Options:%20http://charisfellowship.us/conference/register/addOptions/#conferencefamilyid#%0D%0DSign%20for%20cohorts:%20http://charisfellowship.us/selectCohorts/#simpleEncode(equip_peopleid,13)#?type=cohorts">						
						<div class="well">
							<p>#fname# #lname#  
							</p>
							<p>
								#linkTo(text="Add registrations or meals tickets for #fname# #lname# (or family)", controller="conference.register", action="startFamilyRegs", key=conferencefamilyid, onlyPath=false, class="btn btn-large")#
							</p>
							<cfif workshopsRegOpen()>
								<p>
									#linkTo(text="Use this button to view, add or edit COHORTS for #fname#", route="selectcohorts", personid=#simpleEncode(equip_peopleid,13)#, params="type=cohort", onlyPath=false, class="btn  btn-large btn-inverse")#
								</p>
								<cfset spouse = getSpouse(equip_peopleid)>
								<cfif val(spouse.id)>
									<p>
										#linkTo(text="Use this button to view, add or edit COHORTS for #spouse.fname#", route="selectcohorts", personid=#simpleEncode(spouse.id,13)#, params="type=cohort", onlyPath=false, class="btn  btn-large")#
									</p>
								</cfif>
								<cftry>
								<p>
									<a href="mailto:#email#?subject=#thisEmail.Subject#&body=#thisEmail.body#" title="Send Links to #fname#" class="text-center">Send These Links to #fname#
								</a>
								<cfcatch></cfcatch>
								</cftry>

								</p>
							</cfif>	
						</div>
						<p>&nbsp;</p>
					</cfif>	
				</cfoutput>

		<!---
						<cfoutput query="optionsInThisInvoice" group="conferencepersonid">
							<p>
								#linkTo(text="Use this button to view, add or edit WORKSHOPS for #fname#", route="conferenceselectworkshop", type="workshop", personid=#simpleEncode(conferencepersonid,13)#, onlyPath=false, class="btn btn-block")#
								<cfif hasThisPersonSelectedWorkshops(conferencepersonid)>
									#linkto(text="These workshops have already been selected for #fname#", controller="conference.courses", action="show-selected-workshops", params="personid=#conferencepersonid#&type=workshop")#
								</cfif>
							</p>
						</cfoutput>
		--->

			</div>

			<div id="officeUseOnly">
				<cfoutput>

					<cfif totalmeals>
						Total meals. = #dollarformat(totalMeals)#<br/>
						<cfset totalAll = totalAll + totalMeals>
					</cfif>

					<cfif totalreg>
						Total registrations = #dollarformat(totalReg)#<br/>
						<cfset totalAll = totalAll + totalReg>
					</cfif>

					<cfif totalPreConf>
						Total preconference = #dollarformat(totalPreConf)#<br/>
						<cfset totalAll = totalAll + totalPreConf>
					</cfif>

					<cfif totalExcursion>
						Total totalExcursion = #dollarformat(totalExcursion)#<br/>
						<cfset totalAll = totalAll + totalExcursion>
					</cfif>

					<cfif totalOther>
						Total totalOther = #dollarformat(totalOther)#<br/>
						<cfset totalAll = totalAll + totalOther>
					</cfif>

					<cfif totalChildCare>
						Total childcare = #dollarformat(totalChildCare+totalChildDiscount)#<br/>
						<cfset totalAll = totalAll + totalchildCare + totalChildDiscount>
					</cfif>

					<cfif totalDiscount>
						Total special code discounts = #dollarformat(totalDiscount)#<br/>
						<cfset totalAll = totalAll + totalDiscount>
					</cfif>
					<cfif len(errorInTotal)>
						Total #errorInTotal#
					</cfif>
					<cfif val(totalAll)>
						Total All =  #dollarFormat(totalAll)#
					</cfif>
					<cftry>
					<cfif !isPublic()>
						Posted: #thisinvoice.postedAt#
					</cfif>
					<cfcatch></cfcatch>
					</cftry>
				</cfoutput>
			</div>

		</div>
				<cfoutput>
					<div id="emailThisInvoice">
						<cfset emailSubject = "Your%20#trim(getEventAsUrlEncodedText())#%20Registration">
						<a href="mailto:#getEmailsForInvoice(thisinvoice.id)#?body=http://charisfellowship.us/invoice/#thisinvoice.id#&subject=#emailSubject#">Email a link to this invoice#getEventAsUrlEncodedText()#</a>
					</div>
				<cfif gotRights("superadmin,office")>
						<cfset payEmailSubject = "Pay%20Your%20#trim(getEventAsUrlEncodedText())#%20Registration">
						<a href="mailto:#thisinvoice.agent#?body=http://charisfellowship.us/conference/payinvoice/?ccorderid=#thisinvoice.ccorderid#&subject=#payEmailSubject#" class="btn">Email a link to pay for this invoice</a><br/>
					#linkToList(text="return to list", controller="conference.invoices", action="list")#
				</cfif>	

				<cfif containsGroupReg && convertGroupRegIsOpen()>
				
					<div class="well">
						<p>Use this form to convert one group reg to an individual registration</p>

						#startFormTag(controller="conference.register", action="GroupRegConvertToSingle")#
					
						#putFormTag()#		

							#textFieldTag(name="fname", placeholder="First Name")#

							#textFieldTag(name="lname", placeholder="Last Name")#

							#textFieldTag(name="email", placeholder="Email Address")#

							#textFieldTag(name="phone", placeholder="Cell Phone")#

							#selectTag(name="gender", placeholder="Gender", options="M,F")#

							#selectTag(name="age", placeholder="Cell Phone", options=ageRanges, valueField="id", textField="description")#

							#hiddenFieldTag(name="groupRegId", value=groupRegId)#

						#submitTag("Convert one group reg to an individual reg")#
							
						#endFormTag()#
					</div>	
				</cfif>

					<cfif containsGroupReg && gotRights("office")>
						#linkTo(text="Add extra regs to this group", controller="conference.register", action="selectoptions", params="group&useoptionscount")#
					</cfif>


	</cfoutput>

	</div>
