//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/membership/layout")>
		<cfset filters(through="setreturn", only="index,show")>
		<cfset filters(through="isAuthorized", except="checkin,createblankform,emailVerify,emailsent,verify,functions,index,update,edit,isEmailOnMembershipTeam")>
		<cfset filters(through="loadStates,setPageTitle")>
		<cfset filters(through="loadChurch", only="edit,show,emailverify,delete,thankyou")>
		<cfset filters(through="loadChurches", only="new,create,update")>
		<cfset filters(through="loadOrganizations", only="new,edit,create,update")>
		<cfset filters(through="loadAllChurches", only="edit")>
	</cffunction>


<!---Filters--->
<!---Filters--->
	<cffunction name="isAuthorized">
		<cfif isDefined("params.key") AND len("#params.key#") GTE 30>
			<cfset params.uuid = params.key>
		</cfif>
		<cfif isDefined("params.uuid")>
			<cfset newchurch = model("Membershipnewchurch").findOne(where="uuid='#params.uuid#'")>
			<cfif isObject(newchurch)>
				<cfset session.newchurch.email = newchurch.email>
				<cfset session.newchurch.uuid = newchurch.id>
				<cfset session.newchurch.uuid = newchurch.uuid>
				<cfreturn true>
			</cfif>
		<cfelseif getNewChurchid() and getNewChurchuuid() and getNewChurchEmail()>
			<cfreturn true>
		<cfelseif gotRights("superadmin,office")>
			<cfset redirectTo(action="checkin")>
		<cfelse>
			<cfset redirectTo(action="checkin")>
		</cfif>
	</cffunction>

	<cffunction name="loadStates">
		<cfset states = model("Handbookstate").findAll(order="state")>
	</cffunction>

	<cffunction name="setPageTitle">
		<cfset pageTitle = "New Church Form">
		<cfset pageTitleLinkController = "membership.newchurches">
	</cffunction>

	<cffunction name="loadChurch">
	<cfargument name="uuid"  required="false">
	<cfset var whereString = "">
		<cfif isDefined("params.uuid")>
			<cfset whereString = "uuid='#params.uuid#'">
		<cfelseif isDefined("arguments.uuid")>
			<cfset whereString = "uuid='#arguments.uuid#'">
		<cfelseif isDefined("params.key") and isNumeric("params.key")>
			<cfset whereString = "id=#params.key#">
		<cfelseif isDefined("params.key")>
			<cfset whereString ="uuid='#params.key#'">
		<cfelse>
			<cfset whereString ="id=0">
		</cfif>
		<cfset newchurch = model("Membershipnewchurch").findOne(where=whereString)>
		<cfif !isObject(newchurch)>
			<cfset renderText("This record does not exist")>
		</cfif>
	</cffunction>

	<cffunction name="loadChurches">
		<cfset churches = model("Handbookorganization").findChurchesForDropDown()>
	</cffunction>

	<cffunction name="loadAllChurches">
		<cfset churches = model("Handbookorganization").findChurchesForDropDown('1,8,9,2,4')>
	</cffunction>

	<cffunction name="loadOrganizations">
		<cfset organizations = model("Handbookorganization").findMinistriesForDropDown()>
	</cffunction>


<!---Getters--->
<!---Getters--->
	<cffunction name="getNewChurchid">
	<cfset var loc=structNew()>
		<cfset loc.return=false>
		<cfif isDefined("session.newchurch.id") and session.newchurch.id>
			<cfset loc.return = session.newchurch.id>
		</cfif>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="getNewChurchuuid">
	<cfset var loc=structNew()>
		<cfset loc.return=false>
		<cfif isDefined("session.newchurch.uuid") and len(session.newchurch.uuid)>
			<cfset loc.return = session.newchurch.uuid>
		</cfif>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="getNewChurchEmail">
	<cfset var loc=structNew()>
		<cfset loc.return=false>
		<cfif isDefined("session.newchurch.email") and len(session.newchurch.email)>
			<cfset loc.return = session.newchurch.email>
		</cfif>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="isOffice">
	<cfset var loc.return = false>
		<cfif gotRights("superadmin,office")>
			<cfset loc.return = true>
		</cfif>
	<cfreturn loc.return>
	</cffunction>


<!---Starting point--->
<!---Starting point--->
	<cffunction name="welcome">

	</cffunction>

	<cffunction name="checkin">
			<cfset newchurch = model("Membershipnewchurch").new()>
			<cfset formaction = "createBlankForm">
	</cffunction>

	<cffunction name="isEmailOnMembershipTeam">
		<cfargument name="email" default="#params.email#">
		<cfif !isDefined("arguments.email")>
			<cfreturn true>
		</cfif>
		<cfset check = model("Handbooktag").findAll(where="email = '#email#' AND username = 'tomavey' AND tag = 'fc_membership'", include="Handbookperson(State)")>
		<cfif check.recordcount>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>	
	</cffunction>

	<cffunction name="createBlankForm">
		<cfif isDefined("params.newchurch.email") AND isValid("email",params.newchurch.email)>
			<cfset newchurch = model("Membershipnewchurch").new(params.newchurch)>
			<cfset newchurch.uuid = createUUID()>
			<cfset newchurch.save(validate=false)>
			<cfset $emailverify(newchurch.uuid)>
			<cfif isEmailOnMembershipTeam(params.newchurch.email)>
				<cfset session.auth.rightslist = "basic">
			</cfif>
			<cfset redirectTo(action="emailsent", params="uuid=#newchurch.uuid#")>
		<cfelse>
			<cfset redirectTo(action="checkin", flashAction="Please enter your email address!")>	
		</cfif>	
	</cffunction>

	<cffunction name="$emailVerify" access="private">
	<cfargument name="uuid" required="true" type="string">
		<cfif !isLocalMachine()>
			<cfset sendEmail(to=newchurch.email, from="tomavey@fgbc.org", subject="Your new church", template="emailverify", layout="/membership/layout_naked")>
		</cfif>
		<cfreturn true>
	</cffunction>

	<cffunction name="emailsent">
		<cfset newchurch = model("Membershipnewchurch").findOne(where="uuid='#params.uuid#'")>
	</cffunction>


<!---CRUD--->
<!---CRUD--->
	<!--- Newchurch/index --->
	<cffunction name="index">
		<cfif isDefined("params.showall")>
			<cfset whereString = "">
		<cfelse>
			<cfset whereString = "validatedAt IS NOT NULL">
		</cfif>
		<cfif isDefined("params.grantEligibleAt")>
			<cfset whereString = whereString & " AND grantEligibleAt='#params.grantEligibleAt#'">
		</cfif>
		<cfset newchurches = model("Membershipnewchurch").findAll(where=whereString, order="createdAt DESC")>
	</cffunction>

	<!--- Newchurch/show/key --->
	<cffunction name="show">

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(newchurch)>
	        <cfset flashInsert(error="New church #params.key# was not found")>
	        <cfset redirectTo(action="index")>
			</cfif>
			
	</cffunction>

	<!--- Newchurch/edit/key --->
	<cffunction name="edit">
		<cfset params.key = newchurch.id>
		<cfset formaction = "update">
		<cfset model("Membershipnewchurch").validate(newchurch.id)>
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(newchurch)>
	        <cfset flashInsert(error="New church #params.key# was not found")>
			<cfset redirectTo(action="checkin")>
	    </cfif>

	</cffunction>

	<!--- Newchurch/update --->
	<cffunction name="update">

		<!--- <cfdump var="#params#"><cfabort>

		<cfif isDefined("params.keyy")>
			<cfset params.key = params.keyy>
		</cfif> --->

		<cfset newchurch = model("Membershipnewchurch").findOne(where="uuid='#params.newchurch.uuid#'")>

		<cfif !isObject(newchurch) OR !isDefined("params.newchurch")>
			No church to update!<cfabort>
		</cfif>


		<!--- Verify that the Membershipnewchurch updates successfully --->
		<cfif newchurch.update(params.newchurch)>
			<cfset flashInsert(success="The Membershipnewchurch was updated successfully.")>
			<cfif gotRights("superadmin,office")>
			            	<cfset returnBack()>
			            <cfelse>
			            	<cfset renderView(action="thankyou")>
			            </cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the Membershipnewchurch.")>
			<cfset formaction = "update">
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- Newchurch/delete/key --->
	<cffunction name="delete">

		<!--- Verify that the Membershipnewchurch deletes successfully --->
		<cfif newchurch.delete()>
			<cfset flashInsert(success="The new church was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the new church.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="thankyou">
	</cffunction>

<cfscript>
	public function getTestData(){
		var testData = {};
		testData.fname = "Tom";
		testData.lname = "Avey";
		testData.email = "tomavey@fgbc.org";
		testData.phone = "574-527-6061";
		return testData;
	}
</cfscript>	

</cfcomponent>
