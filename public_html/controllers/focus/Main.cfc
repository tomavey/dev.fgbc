<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset useslayout(template='/focus/layout', only="welcome")>
		<cfset useslayout(template='/focus/layout2', only="retreat,about")>
		<cfset filters(through="getRetreats")>
		<cfset filters(through="getRetreatRegions")>
	</cffunction>

<!----Filters---->

	<cffunction name="getRetreats">
		<cfset retreats = model("Focusretreat").findAll(where="active='yes' and endAt > now()", order="startAt")>
	</cffunction>

<!-------------------------------->
<!---------VIEW CONTROLLERS------->
<!-------------------------------->

	<cffunction name="welcome">
		<cfset content = getFocusContent("introContent")>
		<cfif application.wheels.focusisopen>
		<cfset title="Welcome">
		<cfelse>
		<cfset rendertext="Focus Retreat Web site is being updated.  Check back soon.">
		</cfif>
		<cfset renderPage(layout="/focus/layout")>
	</cffunction>

	<cffunction name="retreat">

		<cfif val(params.key)>
			<cfset whereString = "id='#params.key#'">
		<cfelse>
			<cfset whereString = "regid='#$getRegIdFromName(params.key)#'">
		</cfif>

		<cfset retreat = model("Focusretreat").findOne(where=whereString)>

		<cfif !len(retreat.notopenmessage)>
			<cfset retreat.notopenmessage = "Registration for this retreat is closed.">
		</cfif>

		<cfif isobject(retreat)>
			<cfset options = model("Focusitem").findall(where="retreatId='#retreat.id#' AND (expiresAt IS NULL OR expiresAt > now()) AND category = 'public'", order="price DESC")>
		<cfelse>
			<cfset redirectTo(action="welcome")>
		</cfif>

	</cffunction>

	<cffunction name="$getRegIdFromName" access="private" hint="used to pick the lates retreat based on name">
	<cfargument name="name" required="true" type="string">
	<cfset var loc = arguments>
		<cfset loc.retreat = model("Focusretreat").findAll(where="regid like '#loc.name#%'", order="createdAt DESC")>
		<cfreturn loc.retreat.regid>
	</cffunction>

	<cffunction name="showRegistration" hint="used in the view to control displaying link and info to registration page">
		<cfif (now()-1 LTE retreat.deadline and retreat.regisopen) or isDefined("params.open") or gotrights("office")>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="logout">
		<cfset structdelete(session,"auth")>
		<cfset redirectTo(action="welcome")>
	</cffunction>

	<cffunction name="about">
	</cffunction>

</cfcomponent>