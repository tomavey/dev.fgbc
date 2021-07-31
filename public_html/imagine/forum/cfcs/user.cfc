<!---
	Name         : user.cfc
	Author       : Raymond Camden 
	Created      : January 25, 2005
	Last Updated : November 21, 2007
	History      : Reset for V2
				 : Hash the password on user save (rkc 11/21/07)
	Purpose		 : 
--->
<cfcomponent displayName="User" hint="Handles all user/security issues for the application.">

	<cfset variables.dsn = "">
	<cfset variables.dbtype = "">
	<cfset variables.tableprefix = "">
	<cfset variables.requireconfirmation = 0>
	<cfset variables.title = "">
	<cfset variables.encryptpasswords = false>
	

	<cffunction name="init" access="public" returnType="user" output="false"
				hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfreturn this>
		
	</cffunction>

	<cffunction name="addGroup" access="public" returnType="void" output="false"
				hint="Attempts to create a new group.">
		<cfargument name="group" type="string" required="true">	
		<cfset var checkgroup = "">
		<cfset var newid = createUUID()>
		
		<cflock name="user.cfc" type="exclusive" timeout="30">
			<cfquery name="checkgroup" datasource="#variables.dsn#">
				select	id
				from	#variables.tableprefix#groups
				where	 
				<cfswitch expression="#lCase(variables.dbtype)#">
                	<cfcase value="mysql">
                    	#variables.tableprefix#groups.`group`
                    </cfcase>
                    <cfcase value="oracle">
                    	#variables.tableprefix#groups."GROUP"
                    </cfcase>
                    <cfdefaultcase>
                    	#variables.tableprefix#groups.[group]
                    </cfdefaultcase>
                </cfswitch>  =
				
				<cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">
			</cfquery>
			
			<cfif checkgroup.recordCount>
				<cfset variables.utils.throw("User CFC","Group already exists")>
			<cfelse>				
				<cfquery datasource="#variables.dsn#">
				insert into #variables.tableprefix#groups(id,<cfif variables.dbtype is not "mysql">[group]<cfelse>`group`</cfif>)
				values(<cfqueryparam value="#newid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">,
				<cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">
				)
				</cfquery>
			</cfif>			
		</cflock>
		
	</cffunction>
	
	<cffunction name="addUser" access="public" returnType="void" output="false"
				hint="Attempts to create a new user.">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="groups" type="string" required="false">
		<cfargument name="confirmed" type="boolean" required="false" default="false">
		<cfargument name="signature" type="string" required="false">
		<cfargument name="avatar" type="string" required="false">
		
		<cfset var checkuser = "">
		<cfset var insuser = "">
		<cfset var newid = createUUID()>
		
		<cflock name="user.cfc" type="exclusive" timeout="30">
			<cfquery name="checkuser" datasource="#variables.dsn#">
				select	id
				from	#variables.tableprefix#users
				where	username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
			</cfquery>
			
			<cfif checkuser.recordCount>
				<cfset variables.utils.throw("User CFC","User already exists")>
			<cfelse>
				<!--- If system requires confirmation, set it to 0. --->
				<cfif variables.requireconfirmation and not arguments.confirmed>
					<cfmail to="#arguments.emailaddress#" from="#application.settings.fromAddress#" subject="#variables.title# Confirmation Required">
To complete your registration at #variables.title#, please click on the link below.

#variables.rooturl#<cfif not right(variables.rooturl,1) is "/">/</cfif>confirm.cfm?u=#newid#
					</cfmail>
				</cfif>
				
				<!--- hash password --->
				<cfif variables.encryptpasswords>
					<cfset arguments.password = hash(arguments.password)>
				</cfif>
				<cfif not variables.requireconfirmation>
					<cfset arguments.confirmed = 1>
				</cfif>
				
				<cfquery name="insuser" datasource="#variables.dsn#">
				insert into #variables.tableprefix#users(id,username,password,emailaddress,datecreated,confirmed,signature,avatar)
				values(<cfqueryparam value="#newid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">,
				<cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
				<cfqueryparam value="#arguments.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
				<cfqueryparam value="#arguments.emailaddress#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,
				<cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP">,
			    <cfqueryparam value="#arguments.confirmed#" cfsqltype="CF_SQL_BIT">,
				<cfif structKeyExists(arguments, "signature")>
			    <cfqueryparam value="#left(htmlEditFormat(arguments.signature),1000)#" cfsqltype="cf_sql_varchar">,
			    <cfelse>
			    '',
			    </cfif>
				<cfif structKeyExists(arguments, "avatar")>
				<cfqueryparam value="#arguments.avatar#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">
				<cfelse>
				''
				</cfif>
				)
				</cfquery>
				<cfif isDefined("arguments.groups") and len(arguments.groups)>
					<cfset assignGroups(arguments.username,arguments.groups)>
				</cfif>
			</cfif>
			
		</cflock>
	</cffunction>

	<cffunction name="assignGroups" access="private" returnType="void" output="false"
				hint="Assigns a user to groups.">
		<cfargument name="username" type="string" required="true">
		<cfargument name="groups" type="string" required="true">
		<cfset var uid = getUserId(arguments.username)>
		<cfset var gid = "">
		<cfset var group = "">
				
		<cfloop index="group" list="#arguments.groups#">
			<cfset gid = getGroupID(group)>
			<cfquery datasource="#variables.dsn#">
				insert into #variables.tableprefix#users_groups(useridfk,groupidfk)
				values(<cfqueryparam value="#uid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">,<cfqueryparam value="#gid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">)
			</cfquery>
		</cfloop>
		
	</cffunction>
		
	<cffunction name="authenticate" access="public" returnType="boolean" output="false"
				hint="Returns true or false if the user authenticates.">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfset var qAuth = "">
		
		<cfif variables.encryptpasswords>
			<cfset arguments.password = hash(arguments.password)>
		</cfif>
				
		<cfquery name="qAuth" datasource="#variables.dsn#">
			select	id
			from	#variables.tableprefix#users
			where	username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
			and		password = <cfqueryparam value="#arguments.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
			and		confirmed = 1
		</cfquery>
		
		<cfreturn qAuth.recordCount gt 0>
			
	</cffunction>

	<cffunction name="confirm" access="public" returnType="boolean" output="false"
				hint="Confirms a user.">
		<cfargument name="id" type="uuid" required="true">
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
		select	id
		from	#variables.tableprefix#users
		where	id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" maxlength="35">
		</cfquery>
		
		<cfif q.recordCount is 1>
			<cfquery datasource="#variables.dsn#">
			update	#variables.tableprefix#users
			set		confirmed = 1
			where	id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" maxlength="35">
			</cfquery>
		</cfif>
		
		<cfreturn q.recordCount is 1>
		
	</cffunction>

	<cffunction name="deleteGroup" access="public" returnType="void" output="false"
				hint="Deletes a group.">
		<cfargument name="group" type="uuid" required="true">	
		
		<cfquery datasource="#variables.dsn#">
			delete from #variables.tableprefix#groups
			where  id = <cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>
			
		<cfquery datasource="#variables.dsn#">
			delete from #variables.tableprefix#users_groups
			where  groupidfk = <cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>
		
	</cffunction>
	
	<cffunction name="deleteUser" access="public" returnType="void" output="false"
				hint="Deletes a user.">
		<cfargument name="username" type="string" required="true">
		<cfset var uid = getUserId(arguments.username)>

		<cflock name="user.cfc" type="exclusive" timeout="30">

		<cfquery datasource="#variables.dsn#">
			delete	from #variables.tableprefix#users_groups
			where	useridfk = <cfqueryparam value="#uid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>
			
		<cfquery datasource="#variables.dsn#">
			delete	from #variables.tableprefix#users
			where	id = <cfqueryparam value="#uid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>

		<cfquery datasource="#variables.dsn#">
			delete	from #variables.tableprefix#subscriptions
			where	useridfk = <cfqueryparam value="#uid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>

		</cflock>
						
	</cffunction>

	<cffunction name="getGroup" access="public" returnType="struct" output="false"
				hint="Returns a group.">
		<cfargument name="id" type="uuid" required="true">
		<cfset var qGetGroup = "">
		<cfset var s = structNew()>
		
		<cfquery name="qGetGroup" datasource="#variables.dsn#">
			select	id, 
			<cfswitch expression="#lCase(variables.dbtype)#" >
                <cfcase value="mysql">
                    `group`
                </cfcase>
                <cfcase value="oracle">
                    "GROUP"
                </cfcase>
                <cfdefaultcase>
                    [group]
                </cfdefaultcase>
            </cfswitch>
			from	#variables.tableprefix#groups
			where	id
			 = <cfqueryparam value="#arguments.id#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>
		
		<cfif qGetGroup.recordCount>
			<cfset s.id = qGetGroup.id>
			<cfset s.group = qGetGroup.group>
			<cfreturn s>
		<cfelse>
			<cfset variables.utils.throw("UserCFC","Invalid Group [#arguments.id#]")>
		</cfif>
				
	</cffunction>
	
	<cffunction name="getGroupID" access="public" returnType="uuid" output="false"
				hint="Returns a group id.">
		<cfargument name="group" type="string" required="true">
		<cfset var qGetGroup = "">
		
		<cfquery name="qGetGroup" datasource="#variables.dsn#">
			select	id
			from	#variables.tableprefix#groups
			where
			<cfswitch expression="#lCase(variables.dbtype)#">
                <cfcase value="mysql">
                    #variables.tableprefix#groups.`group`
                </cfcase>
                <cfcase value="oracle">
                    #variables.tableprefix#groups."GROUP"
                </cfcase>
                <cfdefaultcase>
                    #variables.tableprefix#groups.[group]
                </cfdefaultcase>
            </cfswitch> 
			 = <cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">
		</cfquery>
		
		<cfif qGetGroup.recordCount>
			<cfreturn qGetGroup.id>
		<cfelse>
			<cfset variables.utils.throw("UserCFC","Invalid Group [#arguments.group#]")>
		</cfif>
				
	</cffunction>

	<cffunction name="getGroups" access="public" returnType="query" output="false"
				hint="Returns a query of all the known groups.">
		<cfset var qGetGroups = "">

		<cfquery name="qGetGroups" datasource="#variables.dsn#">
			select	id, 
			<cfswitch expression="#lCase(variables.dbtype)#">
                <cfcase value="mysql">
                    `group`
                </cfcase>
                <cfcase value="oracle">
                    "GROUP"
                </cfcase>
                <cfdefaultcase>
                    [group]
                </cfdefaultcase>
            </cfswitch> 
			from	#variables.tableprefix#groups
		</cfquery>
		
		<cfreturn qGetGroups>
		
	</cffunction>
	
	<cffunction name="getGroupsForUser" access="public" returnType="string" output="false"
				hint="Returns a list of groups for a user.">
		<cfargument name="username" type="string" required="true">
		<cfset var qGetGroups = "">
		
		<cfquery name="qGetGroups" datasource="#variables.dsn#">
        	select
			<cfswitch expression="#lCase(variables.dbtype)#">
                	<cfcase value="mysql">
                    	#variables.tableprefix#groups.`group`
                    </cfcase>
                    <cfcase value="oracle">
                    	#variables.tableprefix#groups."GROUP"
                    </cfcase>
                    <cfdefaultcase>
                    	#variables.tableprefix#groups.[group]
                    </cfdefaultcase>
                </cfswitch> 
			from	#variables.tableprefix#users, #variables.tableprefix#groups, #variables.tableprefix#users_groups
			where	#variables.tableprefix#users_groups.useridfk = #variables.tableprefix#users.id
			and		#variables.tableprefix#users_groups.groupidfk = #variables.tableprefix#groups.id
			and		#variables.tableprefix#users.username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
		
		<cfreturn valueList(qGetGroups.group)>
			
	</cffunction>


	<cffunction name="getSubscriptions" access="public" returnType="query" output="false"
				hint="Gets subscriptions for a user.">
		<cfargument name="username" type="string" required="true">
		<cfset var uid = getUserId(arguments.username)>
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			select	id, threadidfk, forumidfk, conferenceidfk
			from	#variables.tableprefix#subscriptions
			where	useridfk = <cfqueryparam value="#uid#" cfsqltype="cf_sql_varchar" maxlength="35">
		</cfquery>
		
		<cfreturn q>
	</cffunction>
	
	<cffunction name="getUser" access="public" returnType="struct" output="false"
				hint="Returns a user.">
		<cfargument name="username" type="string" required="true">
		<cfset var qGetUser = "">
		<cfset var user = structNew()>
		<cfset var g = "">
		<cfset var qGetPostCount = "">
		
		<!---
		<cfquery name="qGetUser" datasource="#variables.dsn#">		
		select #variables.tableprefix#users.id, #variables.tableprefix#users.username, #variables.tableprefix#users.password, 
		#variables.tableprefix#users.emailaddress, #variables.tableprefix#users.datecreated, count(#variables.tableprefix#messages.id) as postcount, 
		#variables.tableprefix#users.confirmed, #variables.tableprefix#users.signature
		from #variables.tableprefix#users
		left join  #variables.tableprefix#messages
		on  #variables.tableprefix#users.id = #variables.tableprefix#messages.useridfk
		where username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		group by #variables.tableprefix#users.id, #variables.tableprefix#users.username, #variables.tableprefix#users.password, #variables.tableprefix#users.emailaddress, #variables.tableprefix#users.datecreated, #variables.tableprefix#users.confirmed
		</cfquery>
		Decided to switch to 2 queries since I can't get the signature w/o group by and it's going to be a longvarchar in access
		--->
		
		<cfquery name="qGetUser" datasource="#variables.dsn#">		
		select #variables.tableprefix#users.id, #variables.tableprefix#users.username, #variables.tableprefix#users.password, 
		#variables.tableprefix#users.emailaddress, #variables.tableprefix#users.datecreated,
		#variables.tableprefix#users.confirmed, #variables.tableprefix#users.signature, #variables.tableprefix#users.avatar
		from #variables.tableprefix#users
		where #variables.tableprefix#users.username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>

		<cfquery name="qGetPostCount" datasource="#variables.dsn#">
		select	count(id) as postcount
		from	#variables.tableprefix#messages
		where	useridfk = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qGetUser.id#" maxlength="35">
		</cfquery>
				
		<cfset user = variables.utils.queryToStruct(qGetUser)>
		<cfif qGetPostCount.postcount neq "">
			<cfset user.postcount = qGetPostCount.postcount>
		<cfelse>
			<cfset user.postcount = 0>
		</cfif>
		<cfset user.groups = getGroupsForUser(arguments.username)>
		
		<cfset user.groupids = "">
		<cfloop index="g" list="#user.groups#">
			<cfset user.groupids = listAppend(user.groupids, getGroupId(g))>
		</cfloop>
		
		<cfreturn user>
			
	</cffunction>

	<cffunction name="getUserID" access="public" returnType="uuid" output="false"
				hint="Returns a user id.">
		<cfargument name="username" type="string" required="true">
		<cfset var qGetUser = "">
		
		<cfquery name="qGetUser" datasource="#variables.dsn#">
			select	id
			from	#variables.tableprefix#users
			where	username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
		
		<cfif qGetUser.recordCount>
			<cfreturn qGetUser.id>
		<cfelse>
			<cfset variables.utils.throw("UserCFC","Invalid Username")>
		</cfif>
				
	</cffunction>

	<cffunction name="getUsernameFromID" access="public" returnType="string" output="false" 
				hint="Returns a username from a user id.">
		<cfargument name="userid" type="string" required="true">
		<cfset var qGetUser = "">
		
		<cfquery name="qGetUser" datasource="#variables.dsn#">
			select	username
			from	#variables.tableprefix#users
			where	id = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_varchar" maxlength="35">
		</cfquery>
		
		<cfreturn qGetUser.username>
	</cffunction>
	
	<cffunction name="getUsers" access="public" returnType="query" output="false"
				hint="Returns all the users.">
		<cfset var qGetUsers = "">
		
		<cfquery name="qGetUsers" datasource="#variables.dsn#">
		select #variables.tableprefix#users.id, #variables.tableprefix#users.username, #variables.tableprefix#users.password, #variables.tableprefix#users.emailaddress, #variables.tableprefix#users.datecreated, count(#variables.tableprefix#messages.id) as postcount, #variables.tableprefix#users.confirmed
		from #variables.tableprefix#users
		left join  #variables.tableprefix#messages
		on  #variables.tableprefix#users.id = #variables.tableprefix#messages.useridfk
		group by #variables.tableprefix#users.id, #variables.tableprefix#users.username, #variables.tableprefix#users.password, #variables.tableprefix#users.emailaddress, #variables.tableprefix#users.datecreated, #variables.tableprefix#users.confirmed
		order by #variables.tableprefix#users.username
		</cfquery>
		
		<cfreturn qGetUsers>
			
	</cffunction>

	<cffunction name="removeGroups" access="private" returnType="void" output="false"
				hint="Removes all groups from a user.">
		<cfargument name="username" type="string" required="true">
		
		<cfset var uid = getUserId(arguments.username)>
				
		<cfquery datasource="#variables.dsn#">
			delete from #variables.tableprefix#users_groups
			where useridfk = <cfqueryparam value="#uid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
		</cfquery>
		
	</cffunction>

	<cffunction name="saveGroup" access="public" returnType="void" output="false"
				hint="Attempts to save a group.">
		<cfargument name="id" type="uuid" required="true">
		<cfargument name="group" type="string" required="true">
		<cfset var checkgroup = "">
		
		<cflock name="user.cfc" type="exclusive" timeout="30">
			<cfquery name="checkgroup" datasource="#variables.dsn#">
				select	id
				from	#variables.tableprefix#groups
				where
					<cfswitch expression="#lCase(variables.dbtype)#">
                	<cfcase value="mysql">
                    	#variables.tableprefix#groups.`group`
                    </cfcase>
                    <cfcase value="oracle">
                    	#variables.tableprefix#groups."GROUP"
                    </cfcase>
                    <cfdefaultcase>
                    	#variables.tableprefix#groups.[group]
                    </cfdefaultcase>
                </cfswitch> 
					  = <cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">
				and		id != <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" maxlength="35">
			</cfquery>

			<cfif checkgroup.recordCount>
				<cfset variables.utils.throw("User CFC","Another group has that name")>
			<cfelse>		
				<cfquery datasource="#variables.dsn#">
				update	#variables.tableprefix#groups
				set
				<cfswitch expression="#lCase(variables.dbtype)#">
                	<cfcase value="mysql">
                    	#variables.tableprefix#groups.`group`
                    </cfcase>
                    <cfcase value="oracle">
                    	#variables.tableprefix#groups."GROUP"
                    </cfcase>
                    <cfdefaultcase>
                    	#variables.tableprefix#groups.[group]
                    </cfdefaultcase>
                </cfswitch> = <cfqueryparam value="#arguments.group#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">
				where	id = <cfqueryparam value="#arguments.id#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
				</cfquery>
			</cfif>
		</cflock>	
				
	</cffunction>
	
	<cffunction name="saveUser" access="public" returnType="void" output="false"
				hint="Attempts to save a user.">
		<cfargument name="username" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="datecreated" type="date" required="true">
		<cfargument name="groups" type="string" required="false">
		<cfargument name="confirmed" type="boolean" required="false" default="false">
		<cfargument name="signature" type="string" required="false">
		<cfargument name="avatar" type="string" required="false">
		<cfargument name="password" type="string" required="false">
		
		<cfset var uid = getUserId(arguments.username)>

		<!--- hash password --->
		<cfif variables.encryptpasswords and structKeyExists(arguments, "password")>
			<cfset arguments.password = hash(arguments.password)>
		</cfif>

		<cfquery datasource="#variables.dsn#">
			update	#variables.tableprefix#users
			set		emailaddress = <cfqueryparam value="#arguments.emailaddress#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,
					<cfif structKeyExists(arguments, "password")>
					password = <cfqueryparam value="#arguments.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
					</cfif>
					datecreated = <cfqueryparam value="#arguments.datecreated#" cfsqltype="CF_SQL_TIMESTAMP">,
					confirmed = <cfqueryparam value="#arguments.confirmed#" cfsqltype="CF_SQL_BIT">
					<cfif structKeyExists(arguments, "signature")>
					,
					signature = <cfqueryparam value="#left(htmleditFormat(arguments.signature),1000)#" cfsqltype="cf_sql_varchar">,
					avatar = <cfqueryparam value="#arguments.avatar#" cfsqltype="cf_sql_varchar" maxlength="255">
					</cfif>
			where	username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
			
		<!--- remove groups --->
		<cfset removeGroups(arguments.username)>
		
		<!--- assign groups --->
		<cfset assignGroups(arguments.username,arguments.groups)>
		
	</cffunction>

	<cffunction name="subscribe" access="public" returnType="void" output="false"
				hint="Subscribes a user to Galleon.">
		<cfargument name="username" type="string" required="true">
		<cfargument name="mode" type="string" required="true">
		<cfargument name="id" type="uuid" required="true">
		<cfset var uid = getUserId(arguments.username)>
		<cfset var check = "">
		
		<cfif not listFindNoCase("conference,forum,thread", arguments.mode)>
			<cfset variables.utils.throw("UserCFC","Invalid Mode")>
		</cfif>
		
		<cfquery name="check" datasource="#variables.dsn#">
		select	useridfk
		from	#variables.tableprefix#subscriptions
		where	
				<cfif arguments.mode is "conference">
				conferenceidfk = 
				<cfelseif arguments.mode is "forum">
				forumidfk = 
				<cfelseif arguments.mode is "thread">
				threadidfk = 
				</cfif>
				<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" maxlength="35">
		and		useridfk = <cfqueryparam value="#uid#" cfsqltype="cf_sql_varchar" maxlength="35">				
		</cfquery>
		
		<cfif check.recordCount is 0>
			<cfquery datasource="#variables.dsn#">
			insert into #variables.tableprefix#subscriptions(id,useridfk, 
				<cfif arguments.mode is "conference">
				conferenceidfk
				<cfelseif arguments.mode is "forum">
				forumidfk
				<cfelseif arguments.mode is "thread">
				threadidfk 
				</cfif>)
			values(<cfqueryparam value="#createUUID()#" cfsqltype="cf_sql_varchar" maxlength="35">,
			<cfqueryparam value="#uid#" cfsqltype="cf_sql_varchar" maxlength="35">,
			<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" maxlength="35">)
			</cfquery>
		</cfif>
				
	</cffunction>		

	<cffunction name="unsubscribe" access="public" returnType="void" output="false"
				hint="Unsubscribes a user from Galleon data.">
		<cfargument name="username" type="string" required="true">
		<cfargument name="id" type="uuid" required="true">
		<cfset var uid = getUserId(arguments.username)>
				
		<cfquery datasource="#variables.dsn#">
		delete	from	#variables.tableprefix#subscriptions
		where	id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar" maxlength="35">
		and		useridfk = <cfqueryparam value="#uid#" cfsqltype="cf_sql_varchar" maxlength="35">				
		</cfquery>		
				
	</cffunction>		

	<cffunction name="setSettings" access="public" output="No" returntype="void">
		<cfargument name="settings" required="true" hint="Setting">

		<cfset var cfg = arguments.settings.getSettings() />
		<cfset variables.dsn = cfg.dsn>
		<cfset variables.dbtype = cfg.dbtype>
		<cfset variables.tableprefix = cfg.tableprefix>
		<cfset variables.requireconfirmation = cfg.requireconfirmation>
		<cfset variables.title = cfg.title>
		<cfset variables.fromAddress = cfg.fromAddress>
		<cfset variables.rooturl = cfg.rooturl>
		<cfset variables.encryptpasswords = cfg.encryptpasswords>
		
	</cffunction>
	
	<cffunction name="setUtils" access="public" output="No" returntype="void">
		<cfargument name="utils" required="true" hint="utils">
		<cfset variables.utils = arguments.utils />
	</cffunction>

</cfcomponent>