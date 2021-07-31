//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("fgbcmembershipapplications")>
    	<cfset automaticValidations(false)>
        <cfset beforeSave("fixquotes")>
		<cfset property(
			name="selectName",
			sql="CONCAT_WS(', ',name_of_church,city,principle_leader)"
			)>
    </cffunction>

    <cffunction name="fixQuotes">
        <cfloop collection="#this.properties()#" item="prop">
            <cfset this[prop] = replace(this[prop], '"', '&quot;', 'all')>
        </cfloop>
    </cffunction>

    <cffunction name="findApp">
    <cfargument name="key" required="true"> 
   		<cftry>
			<cfset membershipapplication = findOne(where="id=#arguments.key#")>
		<cfcatch>
			<cfset membershipapplication = findOne(where="uuid='#arguments.key#'")>
		</cfcatch>
		</cftry>
	
	<cfreturn membershipapplication>		

    </cffunction>


    <cffunction name="findApps">
    <cfargument name="search" required="true" type="string">
    <cfset var loc=structNew()>
    	<cfset state = model("Handbookstate").findOne(where="state='#arguments.search#'")>
    	<cfif isObject(state)>
    		<cfset arguments.search = state.id>
    	</cfif>	
	    <cfset loc.wherestring = "useremail = '#arguments.search#' OR name_of_church like '%#arguments.search#%' OR city like '%#arguments.search#%' OR principle_leader like '%#arguments.search#%' OR stateid = #arguments.search#">
    	<cfset loc.apps = findAll(where=loc.wherestring)>
    <cfreturn loc.apps>	
    </cffunction>

</cfcomponent>
