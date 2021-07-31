component extends="Model" output="false" {
	
	function config() {
		table("auth_users")
		hasMany(name="Usersgroup", model="Authusersgroup", foreignKey="auth_usersid")
		hasMany(name="Conferenceusers", model="Conferenceuser", foreignKey="userid")
		validatesUniquenessOf(property="username")
		validatesUniquenessOf(property="email")
		beforeSave("securePassword")
		property(
			name="selectName", 
			sql="CONCAT_WS(', ',lname,fname,username)"
			)
		property(
			name="fullName", 
			sql="CONCAT_WS(', ',lname,fname)"
			)
		property(
			name="lastLoginDate",
			sql="date_format(lastLoginAt,'%Y-%m-%d')"
			)
		dsn="fgbc_main_3"
	}

	<!---Call Backs--->
	function securePassword() {
		this.salt = createUUID()
		this.salt = replace(this.salt,"-","","all")
		this.encrypted_password = hash(this.salt&this.password,"SHA-256")
		this.password = "encrypted"
	}

	function getRights(userid) {
		var rights = new Query(
			datasource=dsn,
			sql="SELECT DISTINCT r.id, r.name, r.description
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
			ORDER BY r.name"
		)
		return rights.execute().getResult()
	}

	function recordLastLoginResults( required numeric userid, required numeric login_method, lastloginat = now() ) {
		var qry = new Query(
			datasource=dsn,
			sql="UPDATE auth_users
			SET login_method=#arguments.login_method#,
			lastloginat=#arguments.lastloginat#
			WHERE id=#arguments.userid#"
		)
		qry.execute()
		return true
	}

	function recordLastFailedLogin( required numeric userid, lastfailedloginat=now() ) {
		var failedLoginCount = getFailedLoginCount(arguments.userid)+1
		var qry = new Query(
			datasource = dsn,
			sql = "UPDATE auth_users
			SET lastfailedloginat = #arguments.lastfailedloginat#,
			failedlogins = #loc.failedLoginCount# 
			WHERE id = #arguments.userid#"
		).execute()
		return true
	}

	function getFailedLoginCount( required numeric userid ) {
		var failedlogins = findOne(where="id=#arguments.userid#").failedlogins
		if ( failedLogins is "" ) { failedLogins = 0 }
		return failedLogins 
	}

	function setToken( required numeric personid ) {
		var user = findByKey(arguments.personid)
		var token = replace( createUUID(),"-","","all" )
		var token_createdAt = now()
		if ( !len(user.token) ) {
			var qry = new Query(
				datasource=dsn,
				sql="UPDATE auth_users
				SET token = '#token#',
				token_createdAt = #token_createdAt#
				WHERE id = #arguments.personid#"
			).execute()
		}
		return true
	}

	function findDuplicatesByEmail( orderBy="lastLoginAt", direction="DESC" ) {
		var orderString = "#arguments.orderBy# #arguments.direction#"
		var users = findAll(order=orderString)
		var newQuery = queryNew(users.columnlist)
		var newUsers = ""
		for ( user in users ) {
			newUsers = findAll(where="email='#user.email#'")
			if ( newUsers.recordcount GTE 2 ) {
				for ( newUser in newUsers ) {
					newQuery = buildNewQuery( newQuery,newUser )
				}
			}
		}
		return newQuery
	}

}

