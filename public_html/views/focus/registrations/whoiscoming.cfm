<cfparam name="previousperson" default="">
<cfset count = 0>
<cfset emailall = "">
<h1><cfoutput>Who is coming to #whoiscoming.title#?</cfoutput></h1>
<ul>
<cfoutput query="whoiscoming" group="registrantid">
	<cfif fullNameLastFirst NEQ previousperson>
		<li>#fname# #lname# 
			<cfif gotRights('basic') || isDefined("params.showemailall")>
				[#mailto(emailAddress=email, encode=true)#]
			</cfif>
		</li>
		<cfset count = count + 1>
		<cfset emailall = emailall & ';' & email>
	</cfif>
	<cfset previousperson = fullNameLastFirst>
</cfoutput>

<cfset emailall = replace(emailall,';','','one')>

<cfoutput>Count = #count# #linkto(text="*", controller="focus.registrations", action="whoiscoming", key=key, params="showemailall=1")#
<cfif isOffice() or isDefined("params.showemailall")>
<p>#linkTo(text="Email Everyone", href="mailto:#emailall#")#</p>
<p>Show email all link: #linkto(controller="focus.registrations", action="whoiscoming", key=key, params="showemailall=1", onlyPath='false')#</p>
</cfif>
</cfoutput>
</ul>