<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isOffice", only="index,edit")>
	</cffunction>

	<!--- messages/index --->
	<cffunction name="index">
		<cfif isDefined("params.search")>
			<cfset messages = model("Mainmessage").findAll(where="name LIKE '%#params.search#%'", order="createdAt DESC")>
		<cfelseif isDefined("params.showall")>
			<cfset messages = model("Mainmessage").findAll(order="createdAt DESC")>
		<cfelse>
			<cfset messages = model("Mainmessage").findAll(order="createdAt DESC", maxrows=100)>
		</cfif>
	</cffunction>

	<!--- messages/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset message = model("Mainmessage").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(message)>
	        <cfset flashInsert(error="Message #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- messages/new --->
	<cffunction name="new">
		<cfset message = model("Mainmessage").new()>
		<cfset strCaptcha = getcaptcha()>
	</cffunction>

	<!--- messages/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset message = model("Mainmessage").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(message)>
	        <cfset flashInsert(error="Message #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- messages/create --->
	<cffunction name="create">
		<cfset strCaptcha = getcaptcha()>
		<cfif len(params.captcha) AND params.captcha is decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX")>
			<cfset message = model("Mainmessage").new(params.message)>

			<!--- Verify that the message creates successfully --->
			<cfif message.save()>
				<cfset flashInsert(success="The message was created successfully.")>
	            <cfset redirectTo(action="notification", key=message.id)>

			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(error="There was an error creating the message.")>
				<cfset renderPage(action="new")>
			</cfif>
		<cfelse>
			<cfset flashInsert(error="Please try to enter the scrambled image again.")>
			<cfset message = model("Mainmessage").new(params.message)>
			<cfset strCaptcha = getcaptcha()>
			<cfset renderPage(action="new")>
		</cfif>

	</cffunction>

	<!--- messages/update --->
	<cffunction name="update">
		<cfset message = model("Mainmessage").findByKey(params.key)>

		<!--- Verify that the message updates successfully --->
		<cfif message.update(params.message)>
			<cfset flashInsert(success="The message was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the message.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- messages/delete/key --->
	<cffunction name="delete">
		<cfset message = model("Mainmessage").findByKey(params.key)>

		<!--- Verify that the message deletes successfully --->
		<cfif message.delete()>
			<cfset flashInsert(success="The message was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the message.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="notification">
    	<cfset message = model("Mainmessage").findByKey(params.key)>
		<cfset sendEmail(template="notification", from=message.email, to="tomavey@comcast.net", subject="A message from charisfellowship.us contact page...", layout="/layout_naked")>
        <cfset redirectTo(action="thankyou")>
	</cffunction>

</cfcomponent>
