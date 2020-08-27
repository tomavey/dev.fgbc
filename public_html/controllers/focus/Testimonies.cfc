<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset useslayout(template='/focus/layout2')>
		<cfset filters('getRetreats,getRetreatRegions')>
		<cfset filters(through="setReturn", only="index,show")>
	</cffunction>

	<cffunction name="index">
		<cfset testimonies = model("Focustestimony").findAll(include="retreat", order="createdAt")>
		<cfset renderPage(layout="/layoutadmin")>
	</cffunction>

	<cffunction name="list">
		<cfset whereString = "approved = 'yes'">
		<cfif isDefined("params.key")>
			<cfset whereString = whereString & " AND id=#params.key#">
		</cfif>
		<cfset testimonies = model("Focustestimony").findAll(where=whereString, include="retreat", order="createdAt")>
	</cffunction>

	<cffunction name="show">
		<cfset testimony = model("Focustestimony").findByKey(include="retreat", key=params.key)>
	</cffunction>
	
	<cffunction name="edit">
		<cfset testimony = model("Focustestimony").findByKey(params.key)>
	</cffunction>

	<cffunction name="new">
		<cfset testimony = model("Focustestimony").new()>
	</cffunction>
	
	<cffunction name="create">
		<cfset testimony = model("Focustestimony").new(params.testimony)>
		
		<cfif testimony.save()>
			<cfset sendEmail(from="tomavey@comcast.net", to="tomavey@fgbc.org", subject="A new Focus Story", template="email", layout="/focus/emaillayout")>
			<cfset flashInsert(success="The testimony was created successfully.")>
            <cfset redirectTo(action="show", key=testimony.id)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the testimony.")>
			<cfset renderPage(action="new")>
		</cfif>

	</cffunction>
	
	<cffunction name="update">

		<cfset testimony = model("Focustestimony").findByKey(params.testimony.id)>
		
		<cfif testimony.update(params.testimony)>
			  <cfset flashInsert(success = "Testimony updated")>
			  <cfset redirectTo(action="show", key=params.testimony.id)>
		<cfelse>
			  <cfset flashInsert(success = "Testimony NOT updated")>
			  <cfset renderPage(action="edit")>
		</cfif>

	</cffunction>

	<!--- -testimonied/delete/key --->
	<cffunction name="delete">
		<cfif isDefined("params.code") AND params.code is "charis">
			<cfset story = model("Focustestimony").findByKey(params.key)>

			<!--- Verify that the retreat deletes successfully --->
			<cfif story.delete()>
				<cfset flashInsert(success="The story was deleted successfully.")>	
	            <cfset redirectTo(action="index")>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(error="There was an error deleting the story.")>
				<cfset redirectTo(action="index")>
			</cfif>
		<cfelse>
			<cfset renderText("You do not have permission to access this page")>
		</cfif>
	</cffunction>
	
	<cffunction name="approve">
		<cfif isDefined("params.code") AND params.code is "charis">
			<cfset story = model("Focustestimony").findByKey(params.key)>
			<cfset story.approved = "yes">
			<cfset story.update()>
			<cfset returnBack()>
		<cfelse>
			<cfset renderText("You do not have permission to access this page")>
		</cfif>
	</cffunction>
	
</cfcomponent>