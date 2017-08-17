<cfparam name="request.pdfForm" default="/files/FGBCStatCard2016-17.pdf">
<div class="span10 offset1">
<h1>Enter Statistics for <br/><cfoutput>#thisOrg.selectName#</cfoutput></h1>

<cfoutput>
<p>#linkTo(text="Download the PDF form with extra information.", href="http://www.fgbc.org/files/FGBCStatCard2016-17.pdf", class="btn")#</p>

			#errorMessagesFor("handbookstatistic")#

			#startFormTag(action="create")#

			#hiddenFieldTag(name="pay", value=1)#

			#hiddenFieldTag(name="handbookstatistic[enteredby]", value="temp")#

			#includePartial("form")#

			#submitTag("Submit")#

			#endFormTag()#

<cfif isBefore(getMemFeeDeadline())>
<div class="well"><p>The fellowship fee if paid online is #dollarformat(getOnlineMemFee())# per attender (weekly average).  The maximum fellowship fee for a church paying online is #dollarformat(getOnlineMemFeeMax())#.  After clicking "submit", you will be taken to the FGBC online payment center where you can pay the fellowship fee with Visa or Mastercard.  Questions? Email #mailto('sandy@fgbc.org')#.</p>
<cfelse>
<div class="well"><p>The fellowship fee after May 15 is #dollarformat(getLateMemFee())# per attender (weekly average).  The maximum fellowship fee for a church paying after May 15 is #dollarformat(getLateMemFeeMax())#.  After clicking "submit", you will be taken to the FGBC online payment center where you can pay the fellowship fee with Visa or Mastercard.  Questions? Email #mailto('sandy@fgbc.org')#.</p>
</cfif>
</div>
<cfif FileExists(ExpandPath(request.pdfForm))>
<div class="well text-center"><p>Alternate Method - <a href="#request.pdfForm#" target="_new" class="btn btn-block btn-info">Download the form as a PDF and submit by regular mail.</a></p>
</div>
</cfif>
</cfoutput>
</div>