<cffunction name="getState">
<cfargument name="stateid" required="false">
<cfset var loc=structNew()>
	<cfif isDefined("arguments.stateid")>
		<cfset loc.return = model("Handbookstate").findone(where="id=#val(arguments.stateid)#").state>
	<cfelse>
		<cfset loc.return = arguments.stateid>
	</cfif>		
<cfreturn loc.return>	
</cffunction>

<cffunction name="getOrganization">
<cfargument name="organizationId" required="false">
<cfset var loc=structNew()>
	<cfif isDefined("arguments.organizationId") and isNumeric(arguments.organizationId)>
		<cfset loc.organization = model("Handbookorganization").findone(where="id=#arguments.organizationId#", include="state")>
		<cfif isObject(loc.organization)>
			<cfset loc.return = loc.organization.name & ": " & loc.organization.org_city & "," & loc.organization.state.state_mail_abbrev>
		<cfelse>
			<cfset loc.return = "Not Found">
		</cfif>	
	<cfelse>
		<cfset loc.return = "NA">
	</cfif>		
<cfreturn loc.return>	
</cffunction>

<cfscript>

public function handbookLink(handbookid){
	if (isDefined("handbookid") AND !val(handbookId)){
		return "#linkto(
		text='Add to handbook',
		controller='handbook.organizations',
		action='new',
		target="_blank",
		params='name=#churchname#&address1=#churchaddress#&org_city=#churchcity#&email=#email#&phone=#phone#&stateid=#churchstateid#&zip=#churchzip#&statusid=2&newchurchuuid=#uuid#'
		)
		#";		
	}
	else {
		return '#linkto(Text="Handbook Page", controller="handbook.organizations", action="show", target="_blank", key=handbookid)#';
	}
}

</cfscript>