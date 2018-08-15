<!---cfdump var="#registrations#"><cfabort--->
<cfset lastperson = "">
<cfset thisperson = "">

<div id='selectworkshops' class="container">
<cfoutput>
<h2 class="center">You must be registered for #geteventAsText()# in order to sign up for a cohort.</h2>
<p class="text-right">
<a href="https://charisfellowship.us/conference" class="btn">Not registered yet? <br/>Register For #getEventAsText()# Now</a>
</p>
<h2 class="text-center">Please select your name from the list of folks registered for #geteventAsText()#</h2>
<div class="well text-center">
<!---
<form action='#formaction#' method="get" class="selectname">
--->

	#startFormTag(action=params.action, method="post")#

	#hiddenFieldTag(name="type", value=params.type)#

	<select name="personid" class="selectname input-large">
			<option value="">---Select your name---</option>
	<cfoutput query="registrations" group="fullNameLastFirstID">
		<cfset thisperson = '#lname#, #fname#'>
			<cfif thisperson NEQ lastperson>
				<option value=#id#>#thisperson#</option>
			</cfif>
		<cfset lastperson = '#lname#, #fname#'>
	</cfoutput>
	</select>

	#submitTag(value="Get My Cohorts", class="btn btn-block")#
				
	#endFormTag()#

</div>
</cfoutput>
</div>