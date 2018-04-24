<!---cfdump var="#registrations#"><cfabort--->
<cfparam name="encodePersonId" default="true">
<cfset lastperson = "">
<cfset thisperson = "">

<cffunction name="convertPersonid">
<cfargument name="personid" type="numeric" required="true">
<cfset var loc = arguments>
	<cfif isDefined("params.encodePersonId") && params.encodePersonId is "false">
		<cfreturn loc.personid>	
	<cfelse>
		<cfreturn simpleEncode(loc.personid,13)>
	</cfif>
</cffunction>

<div id='xselectworkshops' class="container">
<cfoutput>
<cfif !isDefined("instructions")>
<h2 class="center">You must be registered for #geteventAsText()# in order to sign up for a cohort.</h2>
<cfelse>
<h2 class="center">#instructions#</h2>
</cfif>
<p class="text-right">
<a href="http://www.fgbc.org/conference" class="btn">Not registered yet? <br/>Register For #getEventAsText()# Now</a>
</p>
<h2 class="text-center">Please select your name from the list of folks registered for #geteventAsText()#</h2>
<div class="well text-center">

<!---
<form action='#formaction#' method="get" class="selectname">
--->

	#startFormTag(route="mycohorts", method="post")#

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

	#submitTag(value="My Cohorts", class="btn btn-block btn-primary")#
				
	#endFormTag()#

</div>
</cfoutput>
</div>