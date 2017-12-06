<cfparam name="request.pdfForm" default="/files/FGBCStatCard2016-17.pdf">
<div class="span9 offset1 text-center">
<cfoutput>

<cfif flashKeyExists("error")>
  <p class="alert alert-error" style="font:2em bold">
    #flash("error")#
  </p>
</cfif>

	#startFormTag(action="submit", method="get")#

	#selectTag(name="churchid", options=churches, textField="selectNameCity", includeBlank="- Select Your Church From This List -", class="span5")#

	#submitTag(value="Enter Stats for this church.", class="btn btn-primary")#
				
	#endFormTag()#

<div class="well">
Use the drop-down list above to select your church then click the "Enter Stats for this church." button.  Statistics submitted before July will be included in the report to conference later in July.
</div>	

<cfif FileExists(ExpandPath(request.pdfForm))>
<div class="well text-center"><p>Alternate Method (with a discount for cash payment) - <a href="#request.pdfForm#" target="_new" class="btn btn-block btn-info">Download the form as a PDF and submit by regular mail.</a></p>
</div>
</cfif>
</cfoutput>
</div>