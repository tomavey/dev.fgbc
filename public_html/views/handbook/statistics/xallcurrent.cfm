<cfset countNotPaid = 0>
<cfset countPaid = 0>
<cfset totalPaid = 0>
<cfset emailall = "">
<cfparam name="isDownload" default=false>
<cfparam name="params.type" default="">

<cfoutput>
<cfif isdefined("params.type") and params.type is "notpaid">
	<h1>Churches who have not paid in #getThisYear()#</h1>
</cfif>
<cfif isdefined("params.type") and params.type is "paid">
	<h1>Churches who have paid in #getThisYear()#</h1>
</cfif>

<cfif not isDownload>
	#linkto(text="<i class='icon-download-alt'></i>", action=params.action, params="type=#params.type#&download=1", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
</cfif>
	#linkTo(text="Send Notifications To This List", action="emailAllCurrentNotPaid", params="test=1", class="btn")#
</cfoutput>

<table class="table table-striped">
<cfoutput query="churches">

	<cfset thismemfee = getFeePaid(id)>

	<cfset showThisChurch = false>
	<cfif isdefined("params.type") and params.type is "notpaid" and thismemfee is "NONE">
		<cfset showThisChurch = true>
	</cfif>
	<cfif isdefined("params.type") and params.type is "paid" and val(thismemfee)>
		<cfset showThisChurch = true>
	</cfif>
	<cfif NOT isdefined("params.type")>
		<cfset showThisChurch = true>
	</cfif>

	<cfif showThisChurch>
		<tr>
			<cfif isDownload>
				<td>#name#</td>
			<cfelse>
				<td>#linkTo(text=name, controller="handbook.organizations", action="show", key=id)#</td>
			</cfif>

			<cfif isDownload>
				<td>#address1#</td>
				<td>#address2#</td>
			</cfif>

			<td>#org_city#</td>
			<td>#state_mail_abbrev#</td>

			<cfif isDownload>
				<td>#zip#</td>
				<td>#email#</td>
				<td>https://charisfellowship.us/sendstats/#id#</td>
			</cfif>

			<cfif not isDownload>
				<td><a href="callto://+1#phone#">#phone#</a></td>
				<td>
					<cfif val(thisMemFee)>
						#dollarformat(thismemfee)#
					<cfelse>
						#thismemfee#
					</cfif>
				</td>
				<cfif gotRights("superadmin,office")>
					<cfif isDefined("name")>
						<cfset subject = "Charis%20Fellowship%20Statistical%20Report%20for%20#name#">
					<cfelse>
						<cfset subject = "Charis%20Fellowship%20Statistical%20Report%20">
					</cfif>

					<cfif isOnDate(getSetting('memFeeDeadline'))>
						<cfset body = "Just a friendly reminder! %0D%0A%0D%0AToday is the deadline for submitting the annual stat report and fellowship fee.%0D%0A%0D%0AYou can submit stats for #getThisStatYear()# and pay the fellowship fee for #getThisMemYear()# at https://charisfellowship.us/sendstats/#id#%0D%0A%0D%0AIf you need help, you can call 574-269-1269">
					<cfelse>	
						<cfset body = "Reminder! %0D%0A%0D%0AThe deadline for submitting the annual stat report and fellowship fee is May 15. %0D%0A%0D%0AYou can download the form at https://charisfellowship.us/files/#getSetting('StatForm')# if needed. %0D%0A%0D%0AOr you can submit stats for #getThisStatYear()# and pay the fellowship fee for #getThisMemYear()# at https://charisfellowship.us/sendstats/#id#">
					</cfif>
					<td>
						<cfif NOT val(thisMemFee)>
							#mailTo(emailaddress="#getOrgEmails(id)#?subject=#subject#&body=#body#" , name="Send Link Before Deadline")#
						<cfelse>
							&nbsp;
						</cfif>
					</td>
					<cfif isBefore("August 1, #year(now())#") && isAfter("February 1, #year(now())#")>
						<cfset body = "Greetings! %0D%0A%0D%0AWe are working on the membership and stat report for the Charis Fellowship and would like to complete it as soon as possible. %0D%0A%0D%0APlease take a moment and use this link to submit the stat and payment for the fellowship fee https://charisfellowship.us/sendstats/#id#. %0D%0A%0D%0AIf you are not able to make the payment, please contact our office as we do not want this to be a hardship for any church during these financially challenging times.  If you believe this to be an error, please contact our office so we can keep our information up to date.  %0D%0A%0D%0ASharmion Bowell%0D%0A574-269-1269">
					<cfelse>
						
						<cfset body = "Greetings! %0D%0A%0D%0AI am working on the Charis Fellowship membership report for the upcoming Fellowship Council meeting. According to our records, it appears that your church has not sent in stats for #getThisStatYear()# nor fellowship fees for #getThisMemYear()#. %0D%0A%0D%0APlease use this link to complete the brief statistical report for #getThisStatYear()# and pay your church's fellowship fee for #getThisMemYear()#: https://charisfellowship.us/sendstats/#id#?year=#getThisStatYear()# .%0D%0A%0D%0A If you believe this has already been cared for, have questions, or circumstances make this difficult let me know by email or phone. %0D%0A%0D%0ASharmion Bowell%0D%0A574-269-1269">
					</cfif>
					<td>
						<cfif NOT val(thisMemFee)>
							#mailTo(emailaddress="#getOrgEmails(id)#?subject=#subject#&body=#body#" , name="Send Link After Deadline")#
						<cfelse>
							&nbsp;
						</cfif>
					</td>
				</cfif>
				<td>#linkTo(text="Stats", action="show", key=id)#</td>

				<cfif isdefined("params.type") AND params.type is "notpaid">
					<td>#linkTo(text="Add Stats", action="new", key=id)#</td>
				</cfif>

			</cfif>

		</tr>
		<cfif val(thismemfee)>
			<cfset countPaid = countPaid +1>
			<cfset totalPaid = totalPaid + val(thismemfee)>
		<cfelse>
			<cfset countNotPaid = countNotPaid +1>
		</cfif>
		<cfif len(getorgemails(id))>
			<cfset emailall = emailall & ";" & getorgemails(id)>
		</cfif>
	</cfif>
</cfoutput>
</table>
<cfset emailall = removeDuplicatesFromList(emailAll,"; ")>
<cfset emailall = replace(emailall,"; ","","one")>
<p>&nbsp;</p>
<p>
<cfif not isDownload>
<cfoutput>
<p class="pull-right">
<cfif !isDefined("params.year")>
	#linkto(text="Use #getthisyear()-1# stats", action="allCurrent", params="type=#params.type#", params="year=#getthisyear()-1#", class="btn")#
<cfelse>	
	#linkto(text="Use #getthisyear()# stats", action="allCurrent", params="type=#params.type#", params="year=#getthisyear()#", class="btn")#
</cfif>
</p>
	Count Not Paid: #countNotPaid#</br>
	Count Paid: #countPaid#</br>
	Total Paid: #dollarformat(totalPaid)#<br/>
	#mailto(name="Email All", emailaddress=emailall, class="btn")#</br>
	Paid one year ago: #dollarformat(yearago.summemfee)# from #yearago.countmemfee# churches.<br/>
	Paid two years ago: #dollarformat(twoyearsago.summemfee)# from #twoyearsago.countmemfee# churches.<br/>
	<p>
		#emailall# - #listLen(emailall,"; ")#
	</p>
</cfoutput>
</cfif>
</p>