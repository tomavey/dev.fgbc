//TODO - Convert to cfscript
<cfcomponent output="false" extends="Model">

<cfset dsn = application.wheels.datasourcename>	
<cfset this.event = "visiondc">
	
<cffunction name="saveFamily" output="no">
<cfargument name="lname" required="true">
<cfargument name="address" default="">
<cfargument name="city" default="">
<cfargument name="handbook_statesid"  default=0>
<cfargument name="zip"  default="">
<cfargument name="province" default="">
<cfargument name="country" default="">
<cfargument name="familyemail" default="">
<cfargument name="familyphone" default="">
<cfargument name="comment" default="">
<cfargument name="createdat" default='#now()#'>
<cfargument name="updatedat" default='#now()#'>
<cfset var data="">

<cfif isdefined('arguments.familyemail')>
	<cfset arguments.email = arguments.familyemail>
</cfif>

<cfif isdefined('arguments.familyphone')>
	<cfset arguments.phone = arguments.familyphone>
</cfif>

      <cfquery datasource="#dsn#">
            INSERT INTO equip_families
				(lname,address,city,handbook_statesID,zip,province,country,email,phone,comment,createdat,updatedat)
            VALUES (
                  <cfqueryparam value='#trim(arguments.lname)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.address)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.city)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#val(arguments.handbook_statesid)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.zip)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.province)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.country)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.email)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.phone)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.comment)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.createdat)#' CFSQLType="CF_SQL_DATE">,
                  <cfqueryparam value='#trim(arguments.updatedat)#' CFSQLType="CF_SQL_DATE">
                  )
      </cfquery>

      <cfquery datasource="#dsn#" name="data">
            SELECT max(id) as id
            FROM equip_families
      </cfquery>


<cfreturn data.id>
</cffunction> 

<cffunction name="saveUser_Family">
<cfargument name="familyid" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset loc = arguments>
	<cfif isDefined("session.auth.userid") and session.auth.userid>
		<cfset loc.userid = session.auth.userid>
		<cfset model("Conferenceuser").create(loc)>	
		<cfset structDelete(loc,"userid")>
	</cfif>
	<cfif isDefined("session.auth.fbid") and session.auth.fbid>
		<cfset loc.fbid = session.auth.fbid>
		<cfset model("Conferenceuser").create(loc)>	
	</cfif>
<cfreturn true>		
</cffunction>

<cffunction name="savePerson" output="no">
<cfargument name="equip_familiesid" required="true">
<cfargument name="fname" default="">
<cfargument name="title" default="">
<cfargument name="type" default="">
<cfargument name="email" default="">
<cfargument name="phone" default="">
<cfargument name="age"  default="">
<cfargument name="createdat" default='#now()#'>
<cfargument name="updatedat" default='#now()#'>
<cfset var data="">

      <cfquery datasource="#dsn#">
            INSERT INTO equip_people
				(equip_familiesID,fname,title,type,email,phone,age,createdat,updatedat)
                   VALUES (
                  <cfqueryparam value='#val(arguments.equip_familiesid)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.fname)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.title)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.type)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.email)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.phone)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.age)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.createdat)#' CFSQLType="CF_SQL_DATE">,
                  <cfqueryparam value='#trim(arguments.updatedat)#' CFSQLType="CF_SQL_DATE">
                  )
      </cfquery>
      <cfquery datasource="#dsn#" name="data">
            SELECT max(id) as id
            FROM equip_people
      </cfquery>
<cfreturn data.id>
</cffunction> 

<cffunction name="saveRegistration" output="no">
<cfargument name="equip_peopleid" type="numeric">
<cfargument name="equip_coursesid" type="numeric" default=0>
<cfargument name="equip_invoicesid" type="numeric" default=0>
<cfargument name="equip_optionsid" type="numeric">
<cfargument name="quantity" default=1>
<cfargument name="cost" default=0>
<cfargument name="createdat" default='#now()#'>
<cfargument name="updatedat" default='#now()#'>
<cfset var data="">

      <cfquery datasource="#dsn#">
            INSERT INTO equip_registrations
				(equip_peopleid,equip_coursesid,equip_invoicesid,equip_optionsid,quantity,cost,createdat,updatedat)
                   VALUES (
                  <cfqueryparam value='#trim(arguments.equip_peopleid)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.equip_coursesid)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.equip_invoicesid)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.equip_optionsid)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.quantity)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.cost)#' CFSQLType="CF_SQL_INTEGER">,
                  <cfqueryparam value='#trim(arguments.createdat)#' CFSQLType="CF_SQL_DATE">,
                  <cfqueryparam value='#trim(arguments.updatedat)#' CFSQLType="CF_SQL_DATE">
                  )
      </cfquery>
      <cfquery datasource="#dsn#" name="data">
            SELECT max(id) as id
            FROM equip_registrations
      </cfquery>
<cfreturn data.id>
</cffunction> 

<cffunction name="createInvoice">
<cfargument name="event" default='#this.event#'>
<cfargument name="ccorderid" default="temp">
<cfargument name="ccamount" default=0>
<cfargument name="ccstatus" default=0>
<cfargument name="ccname" default="">
<cfargument name="ccemail" default="">
<cfargument name="agent" default="">
<cfargument name="createdat" default='#now()#'>
<cfargument name="updatedat" default='#now()#'>
<cfset var data="">
<cfset var newccorderid = "">

      <cfquery datasource="#dsn#">
            INSERT INTO equip_invoices
            (event,ccorderid,ccamount,ccstatus,ccname,ccemail,agent,createdat,updatedat)
                   VALUES (
                  <cfqueryparam value='#trim(arguments.event)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.ccorderid)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.ccamount)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.ccstatus)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.ccname)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.ccemail)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.agent)#' CFSQLType="CF_SQL_CHAR">,
                  <cfqueryparam value='#trim(arguments.createdat)#' CFSQLType="CF_SQL_DATE">,
                  <cfqueryparam value='#trim(arguments.updatedat)#' CFSQLType="CF_SQL_DATE">
                  )
      </cfquery>
      <cfquery datasource="#dsn#" name="data">
            SELECT max(id) as id
            FROM equip_invoices
      </cfquery>
	
	  <cfset newccorderid = data.id&arguments.event&arguments.agent>		

	  <cfquery datasource="#dsn#" name="data2">
	  		UPDATE equip_invoices
	  		SET ccorderid = "#newccorderid#"
	  		WHERE id = #data.id#	
	  </cfquery>		
<cfreturn data.id>
</cffunction>

<cffunction name="totalInShoppingCart">
<cfset var total = 0>	
<cfset var thisItemCost = 0>	
	<cfloop from="1" to="#arrayLen(session.shoppingcart)#" index="i">
		<cfset thisItemCost = model("Conferenceoption").findOne(where="id=#session.shoppingcart[i].item#").cost>
		<cfset thisItemCost = val(thisItemCost)>
		<cfset total = total + (thisItemCost*(val(session.shoppingcart[i].quantity)))>		
	</cfloop>
<cfif total LTE 0>
	<cfset total = 0>
</cfif>		
<cfreturn total>
</cffunction>

<cffunction name="autoDiscount">
	<cfset var count = 0>
	<cfset var thisperson = "">
	<cfset var optionName = "">
	<cfset var shoppingCartLen = arraylen(session.shoppingcart)>
	<cfset var listOfAutoDiscountIds = "">
	<cfset var loc=structNew()>
	<!--- Note: Auto Discounts are used for family discounts of multiple children --->

	<!--- Create a list of autoDiscount id's --->
	<cfset discountoptions = model("Conferenceoption").findAll(where="type='AutoDiscount' AND event = '#getEvent()#'")>

	<cfif discountoptions.recordcount>

		<cfloop query="discountoptions">
			<cfset listOfAutoDiscountIds = listOfAutoDiscountIds & "," & id>
		</cfloop>
		<cfset listOfAutoDiscountIds = replace(listOfAutoDiscountIds,",","","one")>
		
		<!---Delete all existing auto discounts--->	
		<cfloop from="1" to="#shoppingCartLen#" index="key">
			<cfloop list="#listOfAutoDiscountIds#" index="i">
				<cftry>
				<cfif session.shoppingCart[key].item is i>
					<cfset arrayDeleteAt(session.shoppingCart,key)>
				</cfif>
				<cfcatch></cfcatch></cftry>
			</cfloop>	
		</cfloop>
	
		<!---Count full childcare and full kids konference regs--->
		<cfset shoppingCartLen = arraylen(session.shoppingcart)>
		<cfloop from="1" to="#shoppingCartLen#" index="key">
			<cfset loc.qualifiesfordiscount = model("Conferenceoption").findOne(where="id=#session.shoppingcart[key].item# AND event='#getEvent()#'").qualifiesforfamilydiscount>
			<cfif loc.qualifiesfordiscount is "yes">
				<cfset count = count+1>
				<cfset thisperson = session.shoppingcart[key].person>
			</cfif>
		</cfloop>
		
		<!---Put discounts in shopping cart for 2nd or more children--->
		<cfif count GTE 2>
			<cfset discountName = count&"children">
			<cfset option = model("Conferenceoption").findOne(where="name='#discountName#' AND event= '#getEvent()#'")>
			<cfset arrayAppend(session.shoppingcart, structNew())>
			<cfset session.shoppingcart[shoppingCartLen+1].item = option.id>	
			<cfset session.shoppingcart[shoppingCartLen+1].quantity = 1>
			<cfset session.shoppingcart[shoppingCartLen+1].person = thisperson>
		</cfif>
	
	</cfif>

</cffunction>

<cffunction name="deleteall">

	<cfquery datasource="fgbc_main_3">
		delete from equip_invoices
	</cfquery>	
	<cfquery datasource="fgbc_main_3">
		delete from equip_people
	</cfquery>	
	<cfquery datasource="fgbc_main_3">
		delete from equip_families
	</cfquery>	
	<cfquery datasource="fgbc_main_3">
		delete from equip_registrations
	</cfquery>	
<cfreturn "done">	
</cffunction>

<cffunction name="putFormIntoShoppingCart">
<cfargument name="params" required="yes">	
<cfset var checkForSelections = 0>	
	<!--- Loop through all the items in params --->
	<cfloop collection="#arguments.params#" item="i">
		<!--- Put any item in the cart that has an id in the params key --->	
		<cfif val(i) and arguments.params[i]>
			<cfset addtocart(item=i, quantity = arguments.params[i], person = arguments.params.person)>
			<cfset checkForSelections = 1>
		</cfif>
		<!--- Put radio button registration items into the cart --->
		<cfif i is "registration">
			<cfset addtocart(item=arguments.params[i], quantity = 1, person = arguments.params.person)>
			<cfset checkForSelections = 1>
		</cfif>
		<cfif i is "specialcode" and len(arguments.params.specialcode) and isDiscountQualified(arguments.params.specialcode)>
			<cfset specialCodeItem = model("Conferenceoption").findOne(where="name='#arguments.params.specialcode#'")>
			<cftry>
				<cfset addtocart(item=specialCodeItem.id, quantity = 1, person = arguments.params.person)>
				<cfset checkForSelections = 1>
			<cfcatch></cfcatch></cftry>	
		</cfif>
	</cfloop>
<cfreturn checkForSelections>
</cffunction>

</cfcomponent>