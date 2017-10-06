<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="index,edit,show,new,delete")>
		<cfset usesLayout("/layoutadmin")>
	</cffunction>

<!-------------------------------------->
<!---------------Basic CRUD------------->
<!-------------------------------------->

	<!--- -groups/index --->
	<cffunction name="index">
		<cfset groups = model("Authgroup").findAll(order="name")>
	</cffunction>
	
	<!--- -groups/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset group = model("Authgroup").findByKey(key=params.key)>
		<cfset rights = model("Authgroupsright").findAll(where="auth_groupsId = #params.key#", include="right", order="name")>
		<cfset allrights = model("Authright").findAll(order="name")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(group)>
	        <cfset flashInsert(error="Group #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- -groups/new --->
	<cffunction name="new">
		<cfset group = model("Authgroup").new()>
	</cffunction>
	
	<!--- -groups/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset group = model("Authgroup").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(group)>
	        <cfset flashInsert(error="Group #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- -groups/create --->
	<cffunction name="create">
		<cfset group = model("Authgroup").new(params.group)>
		
		<!--- Verify that the group creates successfully --->
		<cfif group.save()>
			<cfset flashInsert(success="The group was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the group.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- -groups/update --->
	<cffunction name="update">
		<cfset group = model("Authgroup").findByKey(params.key)>
		
		<!--- Verify that the group updates successfully --->
		<cfif group.update(params.group)>
			<cfset flashInsert(success="The group was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the group.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- -groups/delete/key --->
	<cffunction name="delete">
		<cfset group = model("Authgroup").findByKey(params.key)>
		
		<!--- Verify that the group deletes successfully --->
		<cfif group.delete()>
			<cfset flashInsert(success="The group was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the group.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!------------END of CRUD---------------->	
	
	<cffunction name="addARight">
	<cfargument name="rightId" default='#params.rightid#'>
	<cfargument name="groupId" default='#params.key#'>
		<cfset check = model("Authgroupsright").findAll(where="auth_rightsId = #arguments.rightID# AND auth_groupsId = #arguments.groupId#")>
		<cfif not check.recordcount>
			<cfset Groupsright = model("Authgroupsright").new()>
			<cfset Groupsright.auth_rightsid = arguments.rightid>
			<cfset Groupsright.auth_groupsid = arguments.groupid>
			<cfif Groupsright.save()>
				<cfset redirectTo(back=true)>
			</cfif>	
				<cfset redirectTo(back=true)>
		</cfif>	
				<cfset redirectTo(back=true)>
	</cffunction>

	<cffunction name="removeRight">
	<cfargument name="rightId" default='#params.rightid#'>
	<cfargument name="groupId" default='#params.groupid#'>

		<cfset user = model("Authgroupsright").deleteAll(where="auth_rightsid='#arguments.rightid#' AND auth_groupsid='#arguments.groupid#'")>

		<cfset redirectTo(back=true)>
	</cffunction>

</cfcomponent>
