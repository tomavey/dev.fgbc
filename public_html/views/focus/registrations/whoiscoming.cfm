<cfparam name="previousperson" default="">
<!--- <cfdump var="#whoiscoming#"><cfabort> --->
<cfset count = 0>
<cfset regcountTotal = 0>

<cfset emailall = "">
<h1><cfoutput>Who is coming to #whoiscoming.title#?</cfoutput></h1>
<ul>
<cfoutput query="whoiscoming" group="registrantid">
	<cfif fullNameLastFirst NEQ previousperson>
		<li>#fname# #lname#
			<cfif gotRights('basic') || isDefined("params.showemailall")>
				[#mailto(emailAddress=email, encode=true)#]
			</cfif>
			<cfif !isValid('email',email) && gotRights('office')>
				<span style="color:red">EMAIL MAY BE INVALID!</span>
			</cfif>
		</li>
		<cfset count = count + 1>
		<cfset regcountTotal = regcountTotal + regcount>
		<cfif isValid("email",email)>
			<cfset emailall = emailall & ';' & email>
		</cfif>
	</cfif>
	<cfset previousperson = fullNameLastFirst>
</cfoutput>

<cfset emailall = replace(emailall,';','','one')>

<cfoutput>
Count = #regcountTotal# #linkto(text="*", controller="focus.registrations", action="whoiscoming", key=key, params="showemailall=1")#
<cfif isOffice() or isDefined("params.showemailall")>
<p>#linkTo(text="Email Everyone", href="mailto:#emailall#")#</p>
<p>Show email all link: #linkto(controller="focus.registrations", action="whoiscoming", key=key, params="showemailall=1", onlyPath='false')#</p>
</cfif>
</cfoutput>
</ul>