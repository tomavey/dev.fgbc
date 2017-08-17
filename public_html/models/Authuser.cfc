<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("auth_users")>
		<cfset hasMany(name="Usersgroup", model="Authusersgroup", foreignKey="auth_usersid")>
		<cfset hasMany(name="Conferenceusers", model="Conferenceuser", foreignKey="userid")>
		<cfset validatesUniquenessOf(property="username")>
		<cfset beforeSave("securePassword")>
		<cfset property(
			name="selectName", 
			sql="CONCAT_WS(', ',lname,fname,username)"
			)>

	</cffunction>

	<!---Call Backs--->
	<cffunction name="securePassword">
		<cfset this.salt = createUUID()>
		<cfset this.salt = replace(this.salt,"-","","all")>
		<cfset this.encrypted_password = hash(this.salt&this.password,"SHA-256")>
		<cfset this.password = "encrypted">
	</cffunction>
	
	<cffunction name="getRights">
	<cfargument name="userid" required="true" type="numeric">
	<cfset var loc=structNew()>
	<cfquery datasource="fgbc_main_3" name="loc.rights">
		SELECT DISTINCT r.id, r.name, r.description
		FROM auth_rights r
			JOIN auth_groupsrights gr
				ON gr.auth_rightsid = r.id
			JOIN auth_usersgroups ug
				ON gr.auth_groupsid = ug.auth_groupsid
			JOIN auth_users u
				ON ug.auth_usersid = u.id	
		WHERE gr.deletedAt IS NULL 	
		AND ug.deletedAt IS NULL
		AND ug.auth_usersid = #arguments.userid#
		ORDER BY r.name
	</cfquery>	
	<cfreturn loc.rights>
	</cffunction>

	<cffunction name="recordLastLoginResults">
	<cfargument name="userid" required="true" type="numeric">	
	<cfargument name="login_method" required="true" type="numeric">
	<cfargument name="lastloginat" default="#now()#">
		<cfquery datasource="#application.wheels.datasourcename#">
			UPDATE auth_users
			SET login_method = #arguments.login_method#,
			lastloginat = #arguments.lastloginat#
			WHERE id = #arguments.userid#
		</cfquery>
		<cfreturn true>
	</cffunction>

	<cffunction name="recordLastFailedLogin">
	<cfargument name="userid" required="true" type="numeric">	
	<cfargument name="lastfailedloginat" default="#now()#">
	<cfset var loc=structNew()> 
	<cfset loc.failedLoginCount = getFailedLoginCount(arguments.userid)+1>
		<cfquery datasource="#application.wheels.datasourcename#">
			UPDATE auth_users
			SET lastfailedloginat = #arguments.lastfailedloginat#,
			failedlogins = #loc.failedLoginCount# 
			WHERE id = #arguments.userid#
		</cfquery>
		<cfreturn true>
	</cffunction>

	<cffunction name="getFailedLoginCount">
	<cfargument name="userid" type="numeric" required="true">
	<cfset failedlogins = findOne(where="id=#arguments.userid#").failedlogins>
	<cfif failedlogins is "">
		<cfset failedlogins = 0>
	</cfif>
	<cfreturn failedlogins>
	</cffunction>

	<cffunction name="setToken">
	<cfargument name="personid" required="true"	type="numeric">
	<cfset user = findByKey(arguments.personid)>
	<cfset var loc = structNew()>
		<cfset loc.token = createUUID()>
		<cfset loc.token = replace(loc.token,"-","","all")>
		<cfset loc.token_createdAt = now()>
		<cfif not len(user.token) or (dayOfYear(now()) NEQ dayOfYear(user.token_createdAt))>
			<cfquery datasource="#application.wheels.datasourcename#">
				UPDATE auth_users
				SET token = '#loc.token#',
				token_createdAt = #loc.token_createdAt#
				WHERE id = #arguments.personid#
			</cfquery>
		</cfif>	
	</cffunction>

	<cffunction name="findDuplicatesByEmail">
	<cfargument name="orderby" default="lastLoginAt DESC">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.count = 0>
		<cfset loc.users = findAll(order=loc.orderby)>
		<cfset loc.newquery = querynew('#loc.users.columnlist#')>
		<cfloop query="loc.users">
			<cfset loc.check = findAll(where="email='#email#'")>
				<cfif loc.check.recordcount GTE 2>
 					<cfset loc.temp = buildNewQuery(loc.users,loc.newquery)>
				</cfif>
		</cfloop>
		<cfreturn loc.newquery>
	</cffunction>

	<cffunction name="handylogin">
	<cfargument name="email" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset loc.user = model("Handbookperson").findAll(select="id,email,id as userid,concat(lname,fname)as username", where="email='#loc.email#'")>
		<cfif loc.user.recordcount>
			<cfset loc.user = queryToJson(loc.user)>
		<cfelse>
			<cfset loc.user = "none">
		</cfif>
		<cfreturn loc.user>
	</cffunction>

	<cffunction name="handysessionauth">
	<cfargument name="sessionauth" required="true" type="struct">	
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.sessionauth.passedstring = "">
		<cfset loc.return = structToJson(loc.sessionauth)>
	<cfreturn loc.return>	
	</cffunction>

	<cffunction name="handyAuthenticate">
	<cfargument name="email" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset loc.user = model("Handbookperson").findAll(select="id,email,id as userid,concat(lname,fname)as username", where="email='#loc.email#'")>
		<cfif isObject(loc.user)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>	
	</cffunction>

</cfcomponent>
