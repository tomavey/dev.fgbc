<cffunction name="getStatus">
<cfargument name="statusid" required="true" type="numeric">
<cfset status = model("Handbookstatus").findOne(where="id=#arguments.statusid#").status>
<cfreturn status>
</cffunction>

<cffunction name="getThisStatYear">
<cfset var statYear = year(now())-1>
    <cfif isBefore("February 1, #year(now())#")>
        <cfset statYear = statYear - 1>
    </cfif>
<cfreturn statYear>	
</cffunction>

<cffunction name="getThisMemYear">
<cfset var memYear = getThisStatYear()>
        <cfset memYear = memYear + 1>
<cfreturn memYear>	
</cffunction>
