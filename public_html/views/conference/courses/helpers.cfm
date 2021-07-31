<cffunction name="combineEmail">
	<cfargument name="ccemail">
	<cfargument name="familyemail">
	<cfargument name="email">
	<cfset var combinedEmail = "">
	<cfset var set = structNew()>
	<cfset var list = ccemail & "," & familyemail & "," & email>
<cfloop list="#list#" index="i">
	<cfif isValid("email",i)>
		<cfset set[i] = "">
	</cfif>
</cfloop>
<cfset combinedEmail = structKeyList(set)>
<cfset combinedEmail = ListChangeDelims(combinedEmail,";")>
<cfreturn combinedEmail>
</cffunction>

<cffunction name="getRecordingUrl">
<cfargument name="recordinglink" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc = arguments>
            <cfif loc.recordinglink contains "http">
                <cfset loc.recordinglink2 = loc.recordinglink>
            <cfelseif loc.recordinglink contains "request">
                <cfset loc.recordinglink2 = "/index.cfm/contactus">
                <cfset session.contactMessage="This recording is only available by request using this form.">
            <cfelse>
                <cfset loc.recordinglink2 = "http://www.fgbc.org/files/Audio/margins2016/#loc.recordinglink#">
            </cfif>
<cfreturn loc.recordinglink2>
</cffunction>

<cffunction name="getRecordingLink">
<cfargument name="orginalRecordingUrl" required="true" type="string">
<cfset var loc = structNew()>
<cfset loc = arguments>
<cfif !len(orginalRecordingUrl)>
    <cfreturn "">
</cfif>
<cfset loc.recordingUrl = getRecordingUrl(loc.orginalRecordingUrl)>
<cfset loc.link = "<a href='#loc.recordingurl#'>#loc.recordingurl#</a>">
            <cfreturn loc.link>
</cffunction>

<cfinclude template="../helpers.cfm">