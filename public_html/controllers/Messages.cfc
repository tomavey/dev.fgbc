<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
	</cffunction>

	<!--- messages/index --->
	<cffunction name="index">
		<cfif isDefined("params.showall")>
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
		<cfif isDefined("params.subject")>
			<cfset message.subject = params.subject>
		<cfelse>	
			<cfset message.subject = "">
		</cfif>
		<cfset strCaptcha = getcaptcha()>
	</cffunction>

	<!--- messages/new --->
	<cffunction name="cci_new">
		<cfset params.subject= "Constitution Questions">
		<cfset params.headermessage = "Send your question:">
		<cfset message = model("Mainmessage").new()>
		<cfif isDefined("params.subject")>
			<cfset message.subject = params.subject>
		<cfelse>	
			<cfset message.subject = "">
		</cfif>
		<cfset strCaptcha = getcaptcha()>
		<cfset renderPage(action="new")>
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

	<cffunction name="notification">
		<cfset var loc = structNew()>
    	<cfset message = model("Mainmessage").findByKey(params.key)>
		<cfif len(message.subject)>
			<cfset loc.subject = message.subject>
		<cfelse>
			<cfset loc.subject = "A message from charisfellowship.us contact page...">
		</cfif>	
		<cfif !isLocalMachine()>
			<cfset sendEmail(template="notification", from=message.email, to=getSetting('sendContactUsTo'), subject=loc.subject, layout="/layout_naked")>
		<cfelse>
			<cfset flashInsert(failed="Email was not sent from this local machine to #getSetting('sendContactUsTo')#")>
		</cfif>
      <cfset redirectTo(action="thankyou")>
	</cffunction>

</cfcomponent>
