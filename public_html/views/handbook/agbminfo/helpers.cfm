<cffunction name="getTitle">
<cfargument name="paction" default="#session.params.key#">
<cfset var loc=structNew()>
<cfswitch expression="#arguments.paction#">
	<cfcase value="members">
		<cfset loc.return = "AGBM Members...">		
	</cfcase>
	<cfcase value="mail">
		<cfset loc.return = "AGBM Mail list...">		
	</cfcase>
	<cfcase value="handbook">
		<cfset loc.return = "FGBC Handbook...">		
	</cfcase>
	<cfdefaultcase>
		<cfset loc.return = "Everyone in the database!...">		
	</cfdefaultcase>
</cfswitch>
<cfreturn loc.return>
</cffunction>

<cffunction name="showPagination">
<cfset var loc=structNew()>
<cfset loc.return = false>
<cfif isDefined("params.showPagination") and params.showpagination>
	  <cfset loc.return = true>
</cfif>
<cfreturn loc.return>	  	 	 
</cffunction>

<cffunction name="isAGBMMember">
<cfargument name="personid" required="true" type="numeric">
<cfargument name="params" required="true" type="struct">
<cfset var loc = structNew()>
<cfset loc.return = model("Handbookperson").isAGBMMember(arguments.personid,params)>
<cfreturn loc.return>
</cffunction>

<cffunction name="showThisPerson">
<cfargument name="personid" required="true" type="numeric">
<cfargument name="params" required="true" type="struct">

<cfset var loc = structNew()>
<cfset loc.return = true>
<cfif isDefined("session.params.key") and session.params.key is "mail" and isAGBMmember(arguments.personid,params)>
	  <cfset loc.return = false>
</cfif>
<cfreturn loc.return>
</cffunction>

<cffunction name="credential">
<cfargument name="isLicensed" required="true" type="numeric">
<cfargument name="isOrdained" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset loc.return = "">
<cfif arguments.isLicensed>
	  <cfset loc.return = "Licensed">
</cfif>	  
<cfif arguments.isOrdained>	  
	  <cfset loc.return = "Ordained">
</cfif>
<cfreturn loc.return>
</cffunction>

<cffunction name="makeDownloadParamsList">
<cfargument name="paramslist" default="#params#">
<cfset var loc = {}>
	<cfset loc.downloadParamsList = "download=true">
	<cfif isDefined("params.district")>
		<cfset loc.downloadParamsList = loc.downloadParamsList & "&district=#params.district#">
	<cfelseif isDefined("params.alpha")>	
		<cfset loc.downloadParamsList = loc.downloadParamsList & "&alpha=#params.alpha#">
	</cfif>

	<cfif isDefined("params.type")>
		<cfset loc.downloadParamsList = loc.downloadParamsList & "&type=#params.type#">
	</cfif>

	<cfif isDefined("params.byage")>
		<cfset loc.downloadParamsList = loc.downloadParamsList & "&byage=#params.byage#">
	</cfif>

	<cfif isDefined("params.excel")>
		<cfset loc.downloadParamsList = loc.downloadParamsList & "&excel=true">
	</cfif>

<cfreturn loc.downloadParamsList>
</cffunction>

<cfscript>
	public function inspireId(personId,lname){
		var id = personid & lname;
		id = replace(id," ","");
		id = replace(id,"'","");
		return id;
	}
</cfscript>

