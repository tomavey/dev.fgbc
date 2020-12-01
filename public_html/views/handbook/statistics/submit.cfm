<cfparam name="request.pdfForm" default="/files/#getSetting('StatForm')#">
<cfparam name="deadline" default=#dateAdd('d',0,getSetting('memFeeDeadline'))#>

<div class="span10 offset1">
	<h1>Enter Statistics for <br/><cfoutput>#thisOrg.selectName#</cfoutput></h1>

	<cfoutput>
	<cfif FileExists(ExpandPath(request.pdfForm))>
		<p>#linkTo(text="Download the PDF form with extra information.", href="#request.pdfForm#", class="btn")#</p>
	</cfif>

				#errorMessagesFor("handbookstatistic")#

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