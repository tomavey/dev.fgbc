 //TODO - Convert to cfscript
<cfcomponent output="false" extends="Model">

	<cffunction name='config'>
		<cfset table("equip_people")>
		<cfset hasMany(name='registration', modelName='Conferenceregistration',foreignKey="equip_peopleID")>
		<cfset belongsTo(name="family", modelName="Conferencefamily", foreignKey="equip_familiesID")>
		<cfset belongsTo(name='prayer_triplet', modelName='Conferenceprayer_triplet',foreignKey="equip_prayer_tripletsID", joinType="outer")>
		<cfset belongsTo(name="age_ranges", modelName="Conferenceage_range", foreignKey="age", joinType="outer")>
		<cfset
			property(
			name="fullName",
			sql="Concat(fname, ' ' , lname)"
			)
		>
		<cfset
			property(
			name="fullNameLastFirst",
			sql="Concat(lname, ', ' , fname)"
			)
		>
		<cfset
			property(
			name="fullNameLastFirstID",
			sql="Concat(lname, ', ' , fname, ' (',equip_people.id,')')"
			)
		>
		<cfset beforeSave("htmlEdit")>
	</cffunction>

	<cffunction name="deletePeopleByFamilyId">
	<cfargument name="familyid" required="yes" type="numeric">
		<cfquery datasource="fgbc_main_3">
			DELETE from equip_people
			WHERE equip_familiesid = #arguments.familyid#
		</cfquery>
	</cffunction>

	<cffunction name="findAllHandbookPeople">
	<cfargument name="maxrows" required="false" type="numeric">
			<cfquery datasource="fgbc_main_3" name="handbookpeople">
				SELECT email, concat(fname,' ',lname) as name, address1 as address, city, state_mail_abbrev, zip
				FROM handbookpeople p
				JOIN handbookstates s
				ON p.stateid = s.id
				JOIN handbookpositions po
				ON p.id = po.personid
				WHERE p_sortorder < 501
				AND p.deletedAt IS NULL
			</cfquery>
	<cfreturn handbookpeople>
	</cffunction>

	<cffunction name="findAllChurches">
	<cfargument name="maxrows" required="false" type="numeric">
			<cfquery datasource="fgbc_main_3" name="churches">
				SELECT email, name, address1 as address, org_city as city, state_mail_abbrev, zip
				FROM handbookorganizations o
				JOIN handbookstates s
				ON o.stateid = s.id
				WHERE o.deletedAt IS NULL
				AND statusid in (1,3,4,2,8,9,10,11)
			</cfquery>
		<cfreturn churches>
	</cffunction>

	<cffunction name="findMailList">

		<!---Get every person in the handbook--->
		<cfset handbookpeople = findAllHandbookPeople()>

		<!---Get Every church in the handbook--->
		<cfset churches = findAllChurches()>

		<!---Get every person in the conference reg database--->
		<cfset conference = findAll(include="Family(state)", select="equip_people.email as email, concat(fname,' ',lname) as name, address, city, state_mail_abbrev")>

		<!---Merge all three lists--->
		<cfquery dbtype="query" name="allemail">
			SELECT * FROM handbookpeople
			UNION
			SELECT * FROM churches
			UNION
			SELECT * FROM conference
		</cfquery>

		<!---Remove duplicates--->
		<cfquery dbtype="query" name="distinctemail">
			SELECT DISTINCT *
			FROM allemail
			WHERE 0 = 0
			ORDER BY name
		</cfquery>

		<cfreturn distinctemail>

	</cffunction>

	<cffunction name="emailNotList">
		<cfreturn getSetting("emailNotList")>
	</cffunction>

	<cffunction name="findEmailList">
	<cfset var loc=structNew()>
		<cfset loc.list = findMailList()>
		<cfquery dbtype="query" name="loc.emailList">
			SELECT name,email
			FROM loc.list
			WHERE email <> '' AND email <> 'parent'
		</cfquery>
		<cfquery dbType="query" name="loc.emailDistinctList">
			SELECT DISTINCT *
			FROM loc.emailList
			ORDER BY name
		</cfquery>

		<cfreturn loc.emailDistinctList>

	</cffunction>



	<cffunction name="findMailListRegsOnly">
		<!---Get every person in the conference reg database--->
		<cfset allemail = findAll(where="type='adult'", include="Family(state)", select="equip_families.email, concat(fname,' ',lname) as name, fname, lname, address, city, state_mail_abbrev, zip, type")>

		<!---Remove duplicates--->


		<cfquery dbtype="query" name="distinctemail">
			SELECT DISTINCT *
			FROM allemail
			WHERE 0 = 0
			ORDER BY name
		</cfquery>

		<cfreturn distinctemail>

	</cffunction>

	<cffunction name="findAllPeopleRegistered">
	<cfset var loc=structNew()>
	<cfset loc.selectString = "id,fullname,email,fname,lname,fullNameLastFirstID">

		<cfset loc.people = findAll(select=loc.selectString, where="(equip_options.type IN '#getTypeOfRegOptions()#' OR name LIKE '%staff' OR name = 'OneDayReg') AND event='#getEvent()#'", include="family,registration(option,invoice)")>

		<cfset loc.return = duplicate(loc.people)>

		<cfloop query="loc.people">

			<cfif val(id) and isThisPersonsSpouseRegistered(id)>

				<cfset loc.spouse = findAll(select=loc.selectString, where="id=#isThisPersonsSpouseRegistered(id)#", include="Family")>
				<cfset queryAddRow(loc.return)>

				<cfloop list="#loc.selectString#" index="loc.i">
					<cfset querySetCell(loc.return,loc.i,loc.spouse[loc.i])>
				</cfloop>

					<cfset querySetCell(loc.return,"email",loc.people.email)>

			</cfif>
		</cfloop>

		<cfquery dbtype="query" name="loc.return">
			SELECT DISTINCT #loc.selectString#
			FROM loc.return
			ORDER BY lname,fname
		</cfquery>

		<cfreturn loc.return>
	</cffunction>

	<cffunction name="isThisPersonsSpouseRegistered">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc=structNew()>
		<cfset loc.person.familyid = findOne(select="fname,id,fullname,equip_familiesid", where="id=#arguments.personid#", include="Family").equip_familiesid>
		<cfset loc.spouse = findOne(select="fname,id,fullname,equip_familiesid", where="equip_familiesid = #loc.person.familyid# AND type='Spouse'", include="Family")>
		<cfif isObject(loc.spouse)>
			<cfreturn loc.spouse.id>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

</cfcomponent>