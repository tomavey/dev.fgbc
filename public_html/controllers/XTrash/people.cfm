<!--- route="handbookPerson" pattern="handbook/person/[key]" handbookpeople/show/key --->
<cffunction name="show">

	<cftry>

   	<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate,Handbookprofile,Handbookpictures,Handbooknotes")>
		<cfset tags=model("Handbooktag").findMyTagsForId(params.key,"person")>

	<cfif gotrights("agbm,office,superadmin,agbmadmin")>
		<!---Set up new form for groups within the show report--->
			<cfset handbookGroup = model("Handbookgroup").new()>
			<cfset handbookGroup.personId = params.key>
			<cfset allgroups = model("Handbookgrouptype").findAll(order="title")>
			<cfset groups = model("Handbookgroup").findAll(where="personid=#params.key#", include="handbookGroupType")>
	</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookperson)>
	        <cfset flashInsert(error="Handbookperson #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfif isdefined("params.ajax")>
			<cfset renderPartial("show")>
		</cfif>

	<cfcatch>
		<cfset #sendPersonPageErrorNotice()#>
   	<cfset redirectTo(action="index", error="Oops! Something went wrong try to access this person.  We are working on a solution. You should be able to continue from this page.")>
	</cfcatch>
	</cftry>

	</cffunction>

	<cffunction name="view">
		<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="State,Handbookpositions,Handbookpictures")>
		<cfif handbookperson.private is "yes">
			<cfset redirectTo(action="index")>
		</cfif>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	

