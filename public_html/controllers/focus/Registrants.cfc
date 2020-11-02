<cfcomponent extends="Controller" output="true">
	
	<cffunction name="init">
		<cfset useslayout('/focus/layoutadmin')>
		<cfset filters('checkOffice')>
		<cfset filters(through="setReturn", only="index,show")>
		<cfset filters(through="getRetreatRegions")>
	</cffunction>
	
	<!--- -registrants/index --->
	<cffunction name="index">
	<cfset var local = structNew()>	
		<cfset local.year = year(now())>
		<cfset local.month = month(now())>
		<cfif local.month LTE 9>
			<cfset local.month = 9>
			<cfset local.year = year + 1>
		<cfelse>
			<cfset local.month = 9>
		</cfif>	
		
		<cfset local.date = createDate(local.year,local.month,1)>

		<cfset registrants = model("Focusregistrant").findAll(where="createdAt > '#local.date#'")>
		<cfset registrantsSince = local.date>
	</cffunction>
	
	<!--- -registrants/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset registrant = model("Focusregistrant").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registrant)>
	        <cfset flashInsert(error="Registrant #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- -registrants/new --->
	<cffunction name="new">
		<cfset registrant = model("Focusregistrant").new()>
	</cffunction>
	
	<!--- -registrants/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset registrant = model("Focusregistrant").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registrant)>
	        <cfset flashInsert(error="Registrant #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- -registrants/create --->
	<cffunction name="create">
		<cfset registrant = model("Focusregistrant").new(params.registrant)>
		
		<!--- Verify that the registrant creates successfully --->
		<cfif registrant.save()>
			<cfset flashInsert(success="The registrant was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the registrant.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- -registrants/update --->
	<cffunction name="update">
		<cfset registrant = model("Focusregistrant").findByKey(params.key)>
		
		<!--- Verify that the registrant updates successfully --->
		<cfif registrant.update(params.registrant)>
			<cfset flashInsert(success="The registrant was updated successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the registrant.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- -registrants/delete/key --->
	<cffunction name="delete">
		<cfset registrant = model("Focusregistrant").findByKey(params.key)>
		
		<!--- Verify that the registrant deletes successfully --->
		<cfif registrant.delete()>
			<cfset flashInsert(success="The registrant was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the registrant.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<cfscript>
	function recentRegistrants(){
		if ( isDefined('params.regids') ) { 
			regidsString = commaListToSingleQuoteList(params.regids) 
			recentFocusRegs = distinctsFromQuery(model("Focusregistrant").findRecentFocusRegistrants(regidsString))
		} else {
			ShowInstructions = true
		}
	}

	function updateEmail(
		oldEmail="",
		newEmail="",
		wholeWord=false,
		go= false
		){
		emailList = []


		if ( isDefined("params.oldEmail") ) { arguments.oldEmail = params.oldEmail }	
		if ( isDefined("params.newEmail") ) { arguments.newEmail = params.newEmail }	
		if ( isDefined("params.go") && params.go ) { arguments.go = true }	
		if ( isValid("email", arguments.oldemail) && isValid("email", arguments.newEmail) ) { arguments.wholeword = true }

		args=arguments


		if ( len(args.oldemail) ) {

			//find all regs based on whole email or part of the email
			if ( args.wholeWord ) { whereString = "email='#args.oldEmail#'" }
			else { whereString = "email LIKE '%#args.oldEmail#%'" }
			var registrants = model("Focusregistrant").findAll(where=whereString)
			var count  = 0
			// iterate through each registrant	
			for ( registrant in registrants ){
				var thisNewEmail = ""
				//get each registrant as an object
				var thisReg = model("Focusregistrant").findOne(where="id = #registrant.id#")

				//convert to the new email
				if ( args.wholeword ) { thisNewEmail = args.newemail }
				else { thisNewEmail = replaceNoCase(thisReg.email,args.oldEmail,args.newEmail) }

				//Add that old email and new email to an array
				arrayAppend(emailList,{"CurrentEmail":thisReg.email,"NewEmail": thisNewEmail})

				//save the new email to each registrants record
				if ( args.go ) {
					count = count + 1
					thisReg.email = thisNewEmail
					if ( thisReg.update() ) {
						emaillist = []
						flashInsert(success="#count# emails were updated")
					}
				}
			}
		}
	}

</cfscript>
</cfcomponent>
