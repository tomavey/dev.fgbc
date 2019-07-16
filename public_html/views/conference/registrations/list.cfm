<cfparam name="registrations" type="query">
<cfparam name="totalThisQuantity" default="0">
<cfparam name="totalAllQuantity" default="0">
<cfparam name="totalAllCount" default="0">
<cfparam name="totalThisCost" default="0">
<cfparam name="totalAllCost" default="0">
<cfparam name="totalage" default="0">
<cfparam name="request.emailall" default="">
<cfparam name="request.emailallall" default="">
<cfparam name="message" default="">
<cfset accumulatedEmailList = "">
<cfif isDefined("params.byage") and params.byage is "true">
	<cfset groupby = "age">
<cfelseif isDefined("params.bylname") and params.bylname is "true">
	<cfset groupby = "lname">
<cfelse>
	<cfset groupby = "equip_optionsid">
</cfif>

<cfif isDefined("params.type") AND params.type is "registration">
	<cfoutput>
	<hr/>
		Filter age ranges:

		<cfloop list="16-24,25-30,30-40,40-50,50-60,60+" index="i">
			#linkTo(text=i, action="list", params="type=registration&agerange=#i#")#
		</cfloop>
			#linkTo(text="All", action="list", params="type=registration")#
	<p>
		<cfif !isDefined("params.showonlypaid")>
			#linkto(text="Show only paid", action="list", params="type=#params.type#&showonlypaid=")#
		<cfelse>
			#linkto(text="Show all status", action="list", params="type=#params.type#")#
		</cfif>
		<cfif !gotRightsForEmailLinks()>
			<p>You must be logged into this site to see email addresses.</p>
		</cfif>
	</p>
	<hr/>
	</cfoutput>
</cfif>

<cfoutput query="registrations" group="#groupby#">
<cfset grouprowcount = 0>
<cfset groupagetotal = 0>

<div class="eachItemShown" id="list">

<cfif isDefined("params.byage") and params.byage is "true">
	<h1>#age#</h1>
<cfelse>
	<h1>#ButtonDescription#</h1>
</cfif>
		<table class="reglist">
			<th>&nbsp;</th><th>Name</th><th>Quantity</th>
			<cfif gotRightsForEmailLinks()>
				<th>Email</th><th>Phone</th>
			</cfif>
			<th>Age Range</th>
			<cfif gotRights("superadmin,office")>
				<th>&nbsp;</th>
				<cfif find(cgi.path_info,"?")>
					<th>#linkto(text="Created At", href="/rewrite.cfm#cgi.path_info#&sortorder=createdAt")#</th>
				<cfelse>
					<th>#linkto(text="Created At", href="/rewrite.cfm#cgi.path_info#?sortorder=createdAt")#</th>
				</cfif>
				<th>CCStatus</th>
			</cfif>
		<cfset totalThisQuantity = 0>
	<cfoutput>
	<cfif quantity NEQ 0 || isDefined("params.showallquantity")>
			<cfif payStatus(ccstatus) NEQ "Paid" && isDefined("params.showonlypaid")>
				<cfset showthisrow = false>
			<cfelse>
				<cfset showthisrow = true>
			</cfif>	
		<cfif showthisrow> <!---will filter out not paid if params.showonlypaid--->
			<cfset grouprowcount = grouprowcount +1>
			<cfset groupagetotal = groupagetotal + val(agevalue)>
			<cfset totalThisCost = 0>
					<tr>
						<td>#grouprowcount#</td>
						<td>
							#cleanname(lname)#, #cleanname(fname)#
						</td>
						<td>
							#quantity#
							<cftry>
							<cfif gotrights("office")>
								@ #numberformat(cost,"$____")#
							</cfif>
							<cfset totalthiscost = cost * quantity>
							<cfcatch></cfcatch>
							</cftry>
						</td>
						<cfif gotRightsForEmailLinks()>
							<td>
								#mailto(email)#
							</td>
							<td>
								#phone#
							</td>
						</cfif>
					<td>
							#description#
						</td>
					<cfif gotRights("superadmin,office")>
						<td>
							#showTag()#
							<cfif buttondescription contains "prereg">
								<cfset message = "Greetings!%20%20%0D%0DThank%20you%20for%20registering%20for%20#getEventAsTExt()#.%20Here%20is%20a%20link%20to%20your%20#getEventAsText()#%20pre-registration.%0D%0DUse%20these%20links%20to%20purchase%20meal%20tickets%20of%20or%20to%20sign%20up%20for%20cohorts:%0D">	
							</cfif>
							#linkTo(text="<i class='icon-envelope'></i>", href="mailto:#email#&body=#message#http://www.fgbc.org/invoice/#equip_invoicesid#&subject=Your%20#getEventAsText()#%20Registration", title="Email this invoice", class="tooltipside")#
							#linkTo(text="<i class='icon-list-alt'></i>", controller="conference.invoices", action="show", key=EQUIP_INVOICESID, title="View this invoice", class="tooltipside" )#
						</td>
						<td>
							#dateFormat(createdAt)#
						</td>
						<td>#payStatus(ccstatus)#</td>
					</cfif>
					</tr>
				<cfset totalThisQuantity = totalThisQuantity + val(quantity)>
				<cfset emailEveryone(email)>
				<cfset emailEveryoneAll(email)>
				<cfset totalAllCost = totalAllCost + totalThisCost>
			</cfif>
	</cfif>	
	</cfoutput>
		</table>
		Total #buttondescription#: #totalThisQuantity#<br/>
		<cftry>
		Avg age = #round(groupagetotal/grouprowcount)#
		<cfcatch></cfcatch></cftry>
		<cfif len(maxtosell) AND val(maxtosell)>
			<p>Maximum = #maxtosell#</p>
			<cfif totalThisQuantity GTE maxtosell>
				<p style="color:red;font-size:1.5em;font-weight:bold">****FULL****</p>
			</cfif>
			<cfif maxtosell-totalThisQuantity is 1>
				<p style="color:red;font-size:1.5em;font-weight:bold">****ONLY ONE LEFT****</p>
			</cfif>
			<cfif maxtosell-totalThisQuantity is 2>
				<p style="color:red;font-size:1.5em;font-weight:bold">****ONLY TWO LEFT****</p>
			</cfif>
		</cfif>

		<p>Link: #linkTo(controller="conference.registrations", action="list", key="#equip_optionsid#", onlyPath=false, params="token=#params.token#")#</p>
		<cfif gotRightsForEmailLinks()>
			<p>Email All: #emailEveryone()#</p>
		</cfif>
</div>

<cfset totalAllQuantity = totalAllQuantity + totalThisQuantity>
<cfset totalAllCount = totalAllCount + grouprowcount>


</cfoutput>
<cfoutput>
Total all = #totalAllQuantity#<br/>
Total Count = #totalAllCount#<br/>
<cfif gotrights("office")>
	Total All Cost #dollarformat(totalAllCost)#<br/>
</cfif>
<cfif gotRightsForEmailLinks()>
	Email All = #emailEveryoneAll()#<br/>
	Email All Count = #listLen(emailEveryoneAll(),';')#<br/>
</cfif>
</cfoutput>


<hr/>
<cfoutput>
	<cfif gotRightsForEmailLinks()>
		<table>
			<cfloop list="#emailEveryoneAll()#" delimiters=";" index="i">
				<tr>
					<td>
						#i#
					</td>
				</tr>
			</cfloop>
		</table>
	</cfif>

</cfoutput>