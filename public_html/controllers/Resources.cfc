<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<!--- <cfset filters(through="logview", type="after")> --->
	</cffunction>

	<cffunction name="index">
	<cfif gotRights("basic,office")>
		<cfset resources = model("Mainresource").findAll(order="description")>
	<cfelse>
		<cfset resources = model("Mainresource").findAll(where="status='public'", order="description")>
	</cfif>
	</cffunction>

	<!--- resources/show/key --->
	<cffunction name="show">
		<cfif isdefined("params.key")>

			<!--- Find the record --->
	    	<cfset resource = model("Mainresource").findByKey(params.key)>

	    	<!--- Check if the record exists --->
		    <cfif NOT IsObject(resource)>
		        <cfset flashInsert(error="Resource #params.key# was not found")>
		        <cfset redirectTo(action="index")>
		    </cfif>

	    <cfelse>
	    	<cfset resource = model("Mainresource").findAll()>
	    </cfif>

	</cffunction>

</cfcomponent>
