<cfparam name="request.pdfForm" default="/files/#getSetting('StatForm')#">
<cfparam name="deadline" default=#dateAdd('d',0,getSetting('memFeeDeadline'))#>

<div class="span10 offset1">
	<h1>Enter Statistics for <br/><cfoutput>#thisOrg.selectName#</cfoutput></h1>

	<cfoutput>
	<cfif FileExists(ExpandPath(request.pdfForm))>
		<p>#linkTo(text="Download the PDF form with extra information.", href="#request.pdfForm#", class="btn")#</p>
	</cfif>
	<cfif flashKeyExists("error")>
		<p class="alert alert-error">
				#flash("error")#
		</p>
	</cfif>
<p>
		<span class="text-error lead">Special COVID instructions:</span> Due to the challenges of recording average attendance during 2020, Charis Fellowship delegates made the decision last July to use the average weekly attendance details for 2019 to determine this year's Fellowship Fee.
		<cftry>
			<cfif handbookstatistic.attyear LT 2019 && handbookstatistic.attyear GTE 2017>
				<span>However, according to our records your church did not send statistics last year for 2019. The last attendance stats we have for your church was #handbookstatistic.att# for #handbookstatistic.attyear#. If you have updated average attendance figures (or even estimates) for 2019 please edit the attendance number provided below.</span>
			</cfif>
			<cfif handbookstatistic.attyear LT 2017>
				<span>However, according to our records your church did not send statistics last year for 2019. If you have updated average attendance figures (or even estimates) for 2019 please edit the attendance number provided below.</span>
			</cfif>
			<cfcatch></cfcatch>
		</cftry>
	</p>
			<cftry>
				#errorMessagesFor("handbookstatistic")#
				<cfcatch></cfcatch>
			</cftry>

				#startFormTag(action="create")#

				#hiddenFieldTag(name="pay", value=1)#

				#hiddenFieldTag(name="handbookstatistic[enteredby]", value="temp")#

				#includePartial(partial="form")#

				#submitTag("Submit")#

				#endFormTag()#

	<div class="statsInfo">
		<cfif !isAfter(deadline)>
			<p>The fellowship fee if paid online is #dollarformat(getOnlineMemFee())# per attender (weekly average).  The maximum fellowship fee for a church paying online is #dollarformat(getOnlineMemFeeMax())#.  After clicking "submit", you will be taken to the FGBC online payment center where you can pay the fellowship fee with Visa or Mastercard.  Questions? Email #mailto('Sharmion@charisfellowship.us')#.</p>
		<cfelse>
			<p>The fellowship fee after #dateFormat(deadline, "mmmm dd")# is #dollarformat(getLateMemFee())# per attender (weekly average).  The maximum fellowship fee for a church paying after #dateFormat(deadline, "mmmm dd")# is #dollarformat(getLateMemFeeMax())#.  After clicking "submit", you will be taken to the FGBC online payment center where you can pay the fellowship fee with Visa or Mastercard.  Questions? Email #mailto('Sharmion@charisfellowship.us')#.</p>
		</cfif>
		<cfif FileExists(ExpandPath(request.pdfForm))>
			<p>Alternate Method - <a href="#request.pdfForm#" target="_new" class="btn btn-info">Download the form.</a></p>
		</cfif>
	</div>
	</cfoutput>
</div>