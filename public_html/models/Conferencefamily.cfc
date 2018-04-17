<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_families")>
		<cfset hasMany(name="person", modelName="Conferenceperson",foreignKey="equip_familiesID")>
		<cfset hasMany(name="spouse", modelName="Conferenceperson", foreignKey="equip_familiesID", shortcut="test")>
		<cfset belongsTo(name="state", modelName="Handbookstate",foreignKey="handbook_statesID", jointype="outer")>
		<cfset validatesLengthOf(properties="lname", maximum=50)>
		<cfset
			property(
				name="lnameId",
				sql="Concat(lname,equip_families.ID)"
					)
		>
		<cfset
			property(
				name="lnameIdDate",
				sql="Concat(lname,': ID',equip_families.ID,';yr',year(equip_families.createdAt))"
					)
		>
		<cfset hasMany(name="user", modelName="Conferenceuser", foreignKey="familyid")>
		<cfset afterSave("saveUser_Family")>

	</cffunction>
	
	<cffunction name="backup">
	<cfset var fileid = "">	
	<cfset fileid = year(now())&month(now())&day(now())&second(now())>
		<cfquery datasource="fgbc_main_3" result="results">
			SELECT *
			FROM equip_families
			INTO OUTFILE 'backup_equip_families#fileid#.xls'
		</cfquery>	
	<cfreturn results>	
	</cffunction>	

	<cffunction name="saveUser_Family">
	<cfargument name="familyid" default="#this.id#">
	<cfset var loc=structNew()>
	<cfset loc = arguments>
		<cfif isDefined("session.auth.userid") and session.auth.userid>
			<cfset loc.userid = session.auth.userid>
			<cfset model("Conferenceuser").create(loc)>	
			<cfset structDelete(loc,"userid")>
		</cfif>
		<cfif isDefined("session.auth.fbid") and val(session.auth.fbid)>
			<cfset loc.fbid = val(session.auth.fbid)>
			<cfset model("Conferenceuser").create(loc)>	
		</cfif>
	<cfreturn true>		
	</cffunction>

	<cffunction name="getFamilies">
	<cfargument name="event" default=getEvent()>
	<cfset var loc = structNew()>
	<cfset loc= arguments>
		<cfset loc.families = findAll(where="event = '#loc.event#'", include="state,person(registration(option))", order="lname,id")>
		<cfset loc.families = groupQuery(loc.families,"id")>
		<cfset loc.families = orderQuery(loc.families,"fullNameLastFirstID")>
		<cfreturn loc.families>
	</cffunction>

</cfcomponent>
