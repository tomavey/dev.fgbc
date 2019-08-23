<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout(template="/focus/layoutadmin", except="new,edit")>
		<cfset filters("getRetreatRegions")>
	</cffunction>

	<cffunction name="getMinistryAreas">
		<cfreturn '#application.wheels.focusMinistryAreas#'>
	</cffunction>

	<!--- -shoppingcarts/index --->
	<cffunction name="index">
		<cfset shoppingcarts = model("Focusshoppingcart").findAll()>
	</cffunction>

	<!--- -shoppingcarts/show/key --->
	<cffunction name="show">

		<cfset setReturn()>

		<!--- Find the record --->
    	<cfset shoppingcart = model("Focusshoppingcart").findAll(where="shoppingCartid=#params.key#")>

    	<!--- Check if the record exists --->
	    <cfif NOT shoppingcart.recordcount>
	        <cfset flashInsert(error="Shoppingcart #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfset renderPage(layout="/focus/layout2")>

	</cffunction>

	<cffunction name="agent">
    	<cfset agentemail = trim(model("Focusshoppingcart").findByKey(params.key).email)>
		<cfif isOffice()>
			<cfset message = "Bypass options = #getSetting('byPassWords')#">
		<cfelse>
			<cfset message = "">
		</cfif>
		<cfset setReturn()>
		<cfset renderPage(layout="/focus/layout2")>
	</cffunction>

	<!--- -shoppingcarts/new --->
	<cffunction name="new">
		<cfset shoppingcart = model("Focusshoppingcart").new()>
		<cfset shoppingcart.retreat = params.retreatid>
		<cfset shoppingcart.retreatid = params.retreatid>
		<cfif isDefined("params.shoppingCartid")>
			<cfset shoppingCart.shoppingCartid = params.shoppingCartid>
		</cfif>
		<cfset shoppingCartItems = model("Focusitem").findAll(where="retreatId='#params.retreatid#' AND (expiresAt IS NULL OR expiresAt > now()) AND category = 'Public'", order="price DESC")>
		<cfset retreat = model("Focusretreat").findByKey(params.retreatid)>
		<cfset renderPage(layout="/focus/layout2")>
	</cffunction>

	<!--- -shoppingcarts/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset shoppingcart = model("Focusshoppingcart").findByKey(params.key)>

		<!--- Get all items for this retreat --->

		<cfset shoppingcart.retreatid = model("Focusitem").findByKey(listfirst(shoppingCart.items)).retreatid>
		<cfset shoppingCartItems = model("Focusitem").findAll(where="retreatId='#shoppingcart.retreatid#' AND (expiresAt IS NULL OR expiresAt > now()) AND category = 'Public'", order="price DESC")>

		<!--- Get information about this retreat --->
		<cfset retreat = model("Focusretreat").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(shoppingcart)>
	        <cfset flashInsert(error="Shoppingcart #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

		<cfset renderPage(layout="/focus/layout2")>
	</cffunction>

	<!--- -shoppingcarts/create --->
	<cffunction name="create">

		<cfdump var="#params.shoppingcart#"><cfabort>

		<cfset shoppingcart = model("Focusshoppingcart").new(params.shoppingcart)>
		<cfset shoppingCartItems = model("Focusitem").findAll(where="retreatId=#shoppingcart.retreat# AND (expiresAt IS NULL OR expiresAt > now()) AND category = 'Public'", order="price DESC")>

		<cfif isdefined("params.specialCode") and len(params.specialCode)>
		<cfloop list="#params.specialCode#" index="i">
			<cfset specialCodeItem = model("Focusitem").findOne(where="name='#i#'")>
			<cfif isObject(specialCodeItem)>
				<cftry>
					<cfset shoppingCart.items = listAppend(shoppingCart.items,specialCodeItem.id)>
				<cfcatch>
					<cfset shoppingCart.items = specialCodeItem.id>
				</cfcatch>
				</cftry>
			</cfif>
		</cfloop>
		</cfif>

		<cfif isdefined("shoppingcart.items")>
			<cfset shoppingcart.quantities = defaultQuantities(items=shoppingcart.items)>
		<cfelse>
			<cfset flashInsert(error="Please select at least one item.")>
			<cfset shoppingCartItems = model("Focusitem").findAll(where="retreatId=#shoppingcart.retreat# AND (expiresAt IS NULL OR expiresAt > now()) AND category = 'Public'", order="price DESC")>
			<cfset retreat = model("Focusretreat").findByKey(shoppingcart.retreat)>
			<cfset renderPage(action="new", key=shoppingCart.retreat, layout="/focus/layout2")>
		</cfif>
		<!--- Verify that the shoppingcart creates successfully --->
		<cfif shoppingcart.save()>
			<cfset flashInsert(success="The shoppingcart was created successfully.")>
		            <cfset redirectTo(action="show", key=shoppingCart.shoppingcartid, delay="true")>
		<!--- Otherwise --->
		<cfelse>

			<cfset flashInsert(error="There was an error creating the shoppingcart.")>
			<cfset shoppingCartItems = model("Focusitem").findAll(where="retreatId=#shoppingcart.retreat# AND (expiresAt IS NULL OR expiresAt > now()) AND category = 'Public'", order="price DESC")>
			<cfset retreat = model("Focusretreat").findByKey(shoppingcart.retreat)>
			<cfset renderPage(action="new", key=shoppingCart.retreat, layout="/focus/layout2")>
		</cfif>
	</cffunction>

	<cffunction name="defaultQuantities">
	<cfargument name="quantity" default="1">
	<cfargument name="items" required="true">
		<cfset var quantities = "">
		<cfloop list="#items#"  index="i">
			<cfset quantities = quantities & "," & arguments.quantity>
		</cfloop>
		<cfset quantities = replace(quantities,",","","one")>
		<cfreturn quantities>
	</cffunction>

	<!--- -shoppingcarts/update --->
	<cffunction name="update">
		<cfset shoppingcart = model("Focusshoppingcart").findByKey(params.key)>
		<cfset params.shoppingcart.quantities = "">

		<cfif isdefined("params.specialCode") and len(params.specialCode)>
			<cftry>
			<cfset specialCodeItem = model("Focusitem").findOne(where="name='#params.specialCode#'").id>
			<cfset params.shoppingCart.items = removeDuplicatesFromList(listAppend(shoppingCart.items,specialCodeItem))>
			<cfcatch></cfcatch></cftry>
		</cfif>

		<cfset params.shoppingcart.quantities = defaultQuantities(items=shoppingcart.items)>

		<!--- Verify that the shoppingcart updates successfully --->
		<cfif shoppingcart.update(params.shoppingcart)>
			<cfset flashInsert(success="The shoppingcart was updated successfully.")>
            <cfset redirectTo(action="show", key=shoppingcart.shoppingCartid)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the shoppingcart.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- -shoppingcarts/delete/key --->
	<cffunction name="delete">
	<cfdump var="hi"><cfabort>
		<cfset shoppingcart = model("Focusshoppingcart").findByKey(params.key)>

		<!--- Verify that the shoppingcart deletes successfully --->
		<cfif shoppingcart.delete()>
			<cfset flashInsert(success="The shoppingcart was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the shoppingcart.")>
            <cfset returnBack()>
		</cfif>
	</cffunction>

	<!--- -shoppingcarts/delete/key --->
	<cffunction name="deleteShoppingCartItem">
		<cfset shoppingcart = model("Focusshoppingcart").findByKey(params.key)>

		<!--- Verify that the shoppingcart deletes successfully --->
		<cfif shoppingcart.delete()>
			<cfset flashInsert(success="The shoppingcart was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the shoppingcart.")>
            <cfset returnBack()>
		</cfif>
	</cffunction>

	<cffunction name="getItem">
	<cfargument name="itemId" required="true" type="numeric">
		<cfset var item = model("Focusitem").findOne(where="id='#arguments.itemid#'")>
		<cfreturn item>
	</cffunction>

	<cffunction name="total">
	<cfargument name="cartId" required="true" type="numeric">
		<cfset var cart = model("Focusshoppingcart").findOne(where="id='#arguments.cartid#'")>
		<cfset var total = 0>
		<cfif isObject(cart)>
		<cfloop list="#cart.items#" index="i">
			<cfset total = total + getItem(i).price>
		</cfloop>
		</cfif>
		<cfreturn total>s
	</cffunction>

	<cffunction name="checkout">
	<!---params.key must be availble--->
	<cfset var i=0>
	<cfset var thisitem=0>
	<cfset var cart = {}>
	<cfset var totalcost = 0>
	<cfset params.agent = trim(params.agent)>

		<cfif !isValid("email",params.agent) && !find(params.agent, getSetting('byPassWords'))>
			<cfset flashInsert(error="Please provide a valid email address")>
			<cfset returnBack()>
			<cfset renderText("Please press your browsers back button and enter a valid email address. Thanks!")><cfabort>
		</cfif>

		<!---Retrieve Shopping Cart--->
		<cfset carts = model("Focusshoppingcart").findAll(where="shoppingcartid=#params.key#", returnAs="objects")>

		<!---Get retreat name (RegId) for Cart and use regId for OrderId if possible--->
		<cfset carts[1].regId = model("Focusretreat").findOne(where="id=#carts[1].retreatid#").regId>
			<cfif !isDefined("carts[1].regId")>
				<cfset carts[1].regId = carts[1].retreatid>
			</cfif>	

		<!---Create an empty invoice--->
		<cfset params.orderid = "0">
		<cfset params.ccamount = 0>
		<cfset thisInvoice = model("Focusinvoice").create(params)>

		<!---Create a orderid--->
		<cfset thisInvoice.orderid = createOrderId(thisInvoice.id,carts[1].lname,carts[1].regId)>
		<cfset thisInvoice.save()>

		<cfloop from="1" to="#arraylen(carts)#" index="i">

		<cfset cart = carts[i]>
		<!---Check to see if Shopping Cart is already checked out--->
		<cfif val(cart.invoiceid) is 0>

			<!---Save the registrants information--->
			<cfset structDelete(cart,"id")>
			<cfset person = model("Focusregistrant").new(cart)>
			<cfset person.save()>

			<!---Create Registrations for each item and quantity--->
			<cfloop list="#person.items#" index="thisItem">
				<cfset itemNo = listFind(person.items,thisItem)>
				<cfset thisQuantity = listGetAt(person.quantities,itemNo)>
				<cfset thisRegistration.registrantId = person.id>
				<cfset thisRegistration.itemid = thisitem>
				<cfset thisRegistration.invoiceid = thisinvoice.id>
				<cfset thisRegistration.quantity = thisQuantity>
				<cfset thisRegistration.cost = model("Focusitem").findByKey(thisRegistration.itemid).price>
				<cfset totalcost = totalcost + thisRegistration.cost>
				<cfset register = model("Focusregistration").new(thisRegistration)>
				<cfset register.save()>
			
			</cfloop>

			<!---Mark this shopping cart as checked out--->
			<cfset cart = model("Focusshoppingcart").findbykey(params.key)>
			<cfset cart.invoiceid = thisinvoice.id>
			<cfset cart.save()>

			<cfset params.invoiceid = thisinvoice.id>
		<cfelse>
			<cfset params.invoiceid = cart.invoiceid>
		</cfif>

		</cfloop>

		<!---Put Total Cost of items into the invoice--->
		<cfset thisInvoice.ccamount = totalcost>
		<cfset thisInvoice.save()>

		<cfscript>
			if (find(params.agent, getSetting('byPassWords'))) 
				{ redirectTo(controller='focus.invoices', action='show', key=params.invoiceid, params='ccstatus=#params.agent#') };
		</cfscript>

		<cfset redirectTo(controller="focus.invoices", action="payonline", key=params.invoiceid)>

	</cffunction>

	<cffunction name="createOrderId">
	<cfargument name="id" required="true" type="numeric">
	<cfargument name="lname" required="true" type="string">
	<cfargument name="retreat" required="true" type="string">

		<cfset lname = replace(lname," ","","all")>
		<cfset lname = replace(lname,",","","all")>
		<cfset lname = replace(lname,".","","all")>
		<cfset orderid = "#id##lname#_#retreat#">
		<cfset orderid = trim(orderid)>

		<cfreturn orderid>
	</cffunction>

	<cffunction name="removeDuplicatesFromList">
	<cfargument name="list" required="true" type="string">
	<cfset var loc = arguments>
	<cfset loc.newlist = listFirst(loc.list)>
	<cfloop list="#loc.list#" index="loc.i">
		<cfif NOT ListFindNoCase(loc.newlist,loc.i)>
			<cfset loc.newlist = loc.newlist & "," & loc.i>
		</cfif>
	</cfloop>
	<cfreturn loc.newlist>
	</cffunction>

	<!--- Used by putFormIntoShoppingCart()--->
	<cffunction name="isDiscountQualified">
		<cfargument name="specialcode" required="true" type="string">
		<cfset var isQualified = 0>
		<cfset var dependency = structnew()>
		<cfset var thisoption = structnew()>
		<cfset var discount = model("Conferenceoption").findOne(where="name='#arguments.specialcode#' AND event='#getEvent()#'")>
		
		<cftry>
		<!---Get the discountDependsOn information from the options table--->
		<cfset dependency.names = discount.discountDependsOn>
		<cfset dependency.names = replace(dependency.names," ","","all")>
		<!---If there are no dependencies set qualfication = true--->
		<cfif not len(dependency.names)>
				<cfset isQualified = 1>
		</cfif>
		<cfcatch></cfcatch></cftry>
		
		<!---check params.registration for discount dependency--->
		<cfif isdefined("params.registration")>
			<cftry>
			<!---Get the option name for this option id--->
			<cfset thisoption = model("Conferenceoption").findOne(where="id='#params.registration#'")>
			<!---check to see if this option name is in the list of dependencies--->
			<cfif listFind(dependency.names,thisoption.name)>
				<cfset isQualified = 1>
			</cfif>
			<cfcatch></cfcatch></cftry>
		</cfif>
		
		<cfif not isQualified>
		<cftry>
		
		<!---Loop through all the other items in the shoppingcart using params keys--->
			<cfloop collection="#params#" item="i">
				<!---Get the option name for this option id--->
				<cfset thisoption = model("Conferenceoption").findOne(where="id='#i#'")>
				<!---check to see if this option name is in the of dependencies--->
				<cfif listFind(dependency.names,thisoption.name)>
					<cfset isQualified = 1>
					<cfbreak>
				</cfif>
			</cfloop>
		<cfcatch></cfcatch></cftry>
		</cfif>
		
		<cfreturn isQualified>
		</cffunction>

</cfcomponent>
