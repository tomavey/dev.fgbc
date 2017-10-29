<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="getCurrentMembershipYear")>
		<cfset usesLayout(template="/handbook/layout_agbm")>
	</cffunction>

	<!--- handbookagbmregions/index --->
	<cffunction name="index">
		<cfset handbookagbmregions = model("Handbookagbmregion").findAll(include="agbmrep(Handbookstate)")>
	</cffunction>

	<cffunction name="getCurrentMembershipYear">
		<cfset currentmembershipyear = model("Handbookperson").currentMembershipYear(params)>
	</cffunction>

	<!--- handbookagbmregions/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset handbookagbmregion = model("Handbookagbmregion").findOne(where="id=#params.key#")>
    	<cfset agbmrep = model("Handbookperson").findOne(where="id=#handbookagbmregion.agbmrepid#", include="Handbookstate")>


    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookagbmregion)>
	        <cfset flashInsert(error="Agbm region #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbookagbmregions/new --->
	<cffunction name="new">
		<cfset handbookagbmregion = model("Handbookagbmregion").new()>
		<cfset handbookpeople = model("Handbookperson").findAll(where="p_sortorder <= 500", include="Handbookpositions,Handbookstate", order="Selectname")>
	</cffunction>

	<!--- handbookagbmregions/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbookagbmregion = model("Handbookagbmregion").findByKey(params.key)>
		<cfset handbookpeople = model("Handbookperson").findAll(where="p_sortorder <= 500", include="Handbookpositions,Handbookstate", order="Selectname")>


    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookagbmregion)>
	        <cfset flashInsert(error="AGBM region #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbookagbmregions/create --->
	<cffunction name="create">
		<cfset handbookagbmregion = model("Handbookagbmregion").new(params.handbookagbmregion)>

		<!--- Verify that the handbookagbmregion creates successfully --->
		<cfif handbookagbmregion.save()>
			<cfset flashInsert(success="The AGBM Region was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookagbmregion.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- handbookagbmregions/update --->
	<cffunction name="update">
		<cfset handbookagbmregion = model("Handbookagbmregion").findByKey(params.key)>

		<!--- Verify that the handbookagbmregion updates successfully --->
		<cfif handbookagbmregion.update(params.handbookagbmregion)>
			<cfset flashInsert(success="The AGBM region was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the AGBM region.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbookagbmregions/delete/key --->
	<cffunction name="delete">
		<cfset handbookagbmregion = model("Handbookagbmregion").findByKey(params.key)>

		<!--- Verify that the handbookagbmregion deletes successfully --->
		<cfif handbookagbmregion.delete()>
			<cfset flashInsert(success="The AGBM region was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookagbmregion.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="agbmregionsasjson">
		<cfset data = model("Handbookagbmregion").agbmregionsasjson()>
		<cfset renderPage(layout="/layout_json", template="/json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="agbmregionasjson">
		<cfset data = model("Handbookagbmregion").agbmregionasjson(params.key)>
		<cfset renderPage(layout="/layout_json", template="/json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="agbmrep">
		<cfset data = model("Handbookagbmregion").getrep(params.key)>
		<cfset renderPage(layout="/layout_json", template="/json", hideDebugInformation=true)>
	</cffunction>

</cfcomponent>
