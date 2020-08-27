<cfcomponent>

<cfset dsn = "fgbc_main_3">

  <cffunction name="get_retreat">
  <cfargument name="id" type="numeric">
  <cfargument name="regid" type="string">
  <cfargument name="menuname" type="string">
    <cfquery datasource="=#dsn#" name="data">
      SELECT *
      FROM focus_retreats
      WHERE 0 = 0
      <cfif isDefined("arguments.id")>
        AND id = #arguments.id#
      </cfif>
      <cfif isDefined("arguments.id")>
        AND regid = "#arguments.regid#"
      </cfif>
      <cfif isDefined("arguments.menuname")>
        AND menuname = "#arguments.menuname#"
        ORDER BY createdAt DESC
        LIMIT 1
      </cfif>
    </cfquery>

  <cfreturn data>
  </cffunction>

</cfcomponent>
