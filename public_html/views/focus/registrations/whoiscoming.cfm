<cfparam name="previousperson" default="">
<cfset count = 0>
<cfset emailall = "">
<h1><cfoutput>Who is coming to #whoiscoming.menuname#?</cfoutput></h1>
<ul>
<cfoutput query="whoiscoming" group="registrantid">
	<cfif fullNameLastFirst NEQ previousperson>
		<li>#fname# #lname# [#mailto(emailAddress=email, encode=true)#]</li>
		<cfset count = count + 1>
		<cfset emailall = emailall & ';' & email>
	</cfif>
	<cfset previousperson = fullNameLastFirst>
</cfoutput>

<cfset emailall = replace(emailall,';','','one')>

<cfoutput>Count = #count#
<cfif isOffice() or isDefined("params.showemailall")>
<p>#linkTo(text="Email Everyone", href="mailto:#emailall#")#</p>
</cfif>
</cfoutput>
</ul>