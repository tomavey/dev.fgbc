<cfcomponent extends="Controller" output="false">

<cfobject name="register" component="models.conferenceregister" >

<cffunction name="init" access="public" returntype="void" output="false">
	<cfset createEmptyShoppingCart()>
	<cfset flashInsert(welcome="???")>
	<cfset usesLayout("/conference/layout2018")>
	<cfset filters(through="setReturn", only="welcome,selectregtype,selectoptions,person,showregs")>
	<cfset filters(through="setOpenReg", only="welcome")>
	<cfset filters(through="checkOpenReg", only="selectregtype,selectoptions")>
	<cfset filters("clearSession")>

</cffunction>

<cffunction name="getEvent">
		<cfif isDefined("params.event")>
			<cfreturn params.event>
		<cfelseif preRegIsOpen()>
			<cfreturn super.getNextEvent()>
		<cfelse>
			<cfreturn super.getEvent()>
		</cfif>
</cffunction>

<cffunction name="clearSession">
	<cfif isDefined("params.clearsession")>
		<cfset clearsession()>
		<cfset renderText("This session is cleared")>
	</cfif>
	<cfreturn true>
</cffunction>

<cffunction name="setOpenReg">
	<cfif isDefined("params.openreg") and !application.wheels.registrationIsOpen>
		<cfset session.auth.openreg = true>
	</cfif>
	<cfif isDefined("params.closereg") and !application.wheels.registrationIsOpen>
		<cfset structDelete(session.auth,"openreg")>
	</cfif>
</cffunction>

<cffunction name="checkOpenReg">
	<cfif (isDefined("session.auth.openreg")) OR regIsOpen()>
	<cfelse>
		<cfset renderText("The registration system is not open at this time")>
	</cfif>
</cffunction>

<cffunction name="getRegistrar">
	<cfreturn application.wheels.registrarEmail>
</cffunction>

<!---Creates Empty Shopping Cart is needed--->
<cffunction name="createEmptyShoppingCart">
	<cflock name="init" timeout = "30" type = "Exclusive">
		<cftry>
			<cfif not isArray(session.shoppingcart)>
				<cfset session.shoppingcart = arraynew(1)>
			</cfif>
		<cfcatch>
			<cfset session.shoppingcart = arraynew(1)>
		</cfcatch>
		</cftry>
	</cflock>
</cffunction>

<cffunction name="isCarts">
<cfset var loc=structNew()>
	<cfif not structKeyExists(session, "registrationcart")>
		<cfset structDelete(session,"shoppingcart")>
		<cfreturn false>
	</cfif>
	<cfif not structKeyExists(session, "shoppingcart")>
		<cfset structDelete(session,"registrationcart")>
		<cfreturn false>
	</cfif>
	<cfreturn true>
</cffunction>

<cffunction name="isAdmin"><!---not sure where this is used.  Perhaps in a view--->
<cfset var loc = structNew()>
  <cftry>
	  <cfif session.auth.admin>
	  	 <cfset loc.return = true>
	  <cfelse>
	  	 <cfset loc.return = false>
	  </cfif>

	  <cfcatch>
	  	 <cfset loc.return = false>
	  </cfcatch>
  </cftry>

  <cfif gotRights("office")>
  	<cfset loc.return=true>
  <cfelse>
  	<cfset loc.return=false>
  </cfif>

<cfreturn loc.return>
</cffunction>









<!---------------------------------->
<!---/conference.register/welcome--->
<!---------------------------------->

<cffunction name="welcome">
	<cfif isDefined("params.key") and params.key is "admin">
		<cfset session.auth.admin = 1>
	<cfelse>
	</cfif>
	<cftry>
		<cfset arrayclear(session.shoppingcart)>
		<cfcatch></cfcatch>
	</cftry>
	<cftry>
		<cfset structDelete(session,"registrationcart")>
	<cfcatch></cfcatch></cftry>
	<cfif isDefined("params.selectRegType")>
		<cfset redirectTo(action="selectregtype")>
	</cfif>
	<cfset formaction = "checkCaptcha">
</cffunction>

<cffunction name="checkCaptcha" hint="processes the welcome screen captcha form">

	<cfif len(params.captcha) AND params.captcha is decrypt(params.captcha_check,application.wheels.passwordkey,"CFMX_COMPAT","HEX")>
		<cfset flashInsert(message="Type one adult (ie: 'John''), couple (ie:'John and Jane') or child (ie:'Johnny') on the left then select the appropriate registration options below before click 'Add To Cart'")>
		<cfset redirectTo(controller="conference.register", action="selectregtype")>
	<cfelse>
		<cfset flashInsert(error="Please try again.")>
		<cfset redirectTo(action="welcome")>
	</cfif>

</cffunction>









<!---------------------------------------->
<!---/conference.register/selectoptions--->
<!---------------------------------------->


<cffunction name="selectoptions" hint="Step one in the registration process. I show a form with options for registration">


	<cfif !regIsOpen()>
		<cfset redirectTo(action="welcome")>
	</cfif>

	<!---Get Options data (registration options)for form--->
	<cfif isDefined("params.listOfMealIds")>
		<cfset meals = model("Conferenceoption").findAllOptions("meal",params.listOfMealIds,getEvent())>
	<cfelseif regType() NEQ "group">
		<cfset meals = model("Conferenceoption").findAllOptions(type="meal",event=getEvent())>
	</cfif>

	<!---build the where string for registration options--->
	<cfif regType() is "single">
		<cfset wherestring = "type = 'registration-single'">
	<cfelseif regtype() is "couple">
		<cfset wherestring = "type = 'registration-couple'">
	<cfelseif regtype() is "children">
		<cfset wherestring = "type in ('GraceKids-Nursery','GraceKids-Preschool','GraceKids-Elementary')">
	<cfelseif regtype() is "family">
		<cfset wherestring = "type in ('registration-couple','registration-single')">
	<cfelseif regtype() is "group">
		<cfset wherestring = "type in ('registration-group')">
	<cfelseif regtype() is "meal">
		<cfset wherestring = "type = 'none'">
	<cfelseif regtype() is "options">
		<cfset wherestring = "type = 'none'">
	<cfelseif regtype() is "preRegistration">
		<cfset wherestring = "type = 'preRegistration'">
	<cfelse>
		<cfset wherestring = "type in ('registration-couple','registration-single','childcare','KidsKonference')">
	</cfif>

	<cfset registrations = model("Conferenceoption").findall(where="#wherestring# AND event='#getEvent()#'", order="sortorder")>

	<cfset options = model("Conferenceoption").findall(where="type in ('other','excursion') AND event='#getEvent()#'", order="sortorder")>

	<cfset childCare = model("Conferenceoption").findall(where="type='GraceKidsSegments' AND event='#getEvent()#'", order="sortorder")>

	<cfset KidsKonference = model("Conferenceoption").findall(where="type='GraceKidsExcursions' AND event='#getEvent()#'", order="sortorder")>

	<cfset MobileLearningLabs = model("Conferenceoption").findAllOptions("MobileLearningLab")>

	<cflock name="selectoptions" timeout = "30" type = "Exclusive">
		<!---If this is an existing set the familyid in the session--->
		<cfif isdefined("params.familyid")>
			<cftry>
				<cfif not isStruct(session.registrationCart)>
					<cfset session.registrationCart = structNew()>
				</cfif>
					<cfcatch>
						<cfset session.registrationCart = structNew()>
					</cfcatch>
			</cftry>
			<cfset session.registrationcart.familyid = params.familyid>
		</cfif>
	</cflock>

	<!---Get the existing shopping cart info to display--->
	<cfset cart = showcart()>

	<!---Decide whether this is a new Cart create or update based on person in url--->
	<cfparam name="params.person" default="">
	<cfif len(params.person)><!---use this for a registration add--->
		<cfset formaction="updateCartItemsFromForm">
		<cfset submitValue="Update Cart">
	<cfelse>
		<cfset formaction="createCartItemsFromForm">
		<cfset submitValue="Add to Cart">
	</cfif>

	<!---set the person param if a flash message is set--->
	<cfif flashKeyExists("person")>
		<cfset params.person = flash("person")>
	</cfif>

</cffunction>

<!---used by selectoptions--->
<cffunction name="showCart" >
<cfset var loc=structNew()>
	<cfset loc.Cart = queryNew("cartid,item,description,price,person,quantity")>

	<!---Add in Automatic Discounts based on items already selected--->
	<cftry>
	<cfset register.autoDiscount()>
	<cfcatch></cfcatch></cftry>

	<cftry>
	<cfloop from="1" to="#arraylen(session.shoppingcart)#" index="loc.key">
		<cfset loc.thisoption = getOptionDescriptionAndPrice(session.shoppingcart[loc.key].item,session.shoppingcart[loc.key].person)>
		<cfset queryAddRow(loc.cart)>
		<cfset querySetCell(loc.cart,"cartid", loc.key)>
		<cfset querySetCell(loc.cart,"item", loc.thisoption.id)>
		<cfset querySetCell(loc.cart,"description", loc.thisoption.buttondescription)>
		<cfif isDefined("session.shoppingcart[#loc.key#].cost")>
			<cfset querySetCell(loc.cart,"price", session.shoppingcart[loc.key].cost)>
		<cfelse>
			<cfset querySetCell(loc.cart,"price", loc.thisoption.cost)>
		</cfif>
		<cfset querySetCell(loc.cart,"person", session.shoppingcart[loc.key].person)>
		<!---If this person is a number it may be an id for an existing person, use that persons name instead--->
		<cfif val(session.shoppingcart[loc.key].person)>
			<cftry>
			<cfset querySetCell(loc.cart,"person", getPersonFromId(val(session.shoppingcart[loc.key].person)))>
			<cfcatch></cfcatch></cftry>
		</cfif>
		<cfset querySetCell(loc.cart,"quantity", session.shoppingcart[loc.key].quantity)>
	</cfloop>
	<cfcatch>
		<cfset createEmptyShoppingCart()>
	</cfcatch>
	</cftry>

	<cftry>
    <!---Put cart items in order--->
	<cfquery dbtype="query" name="loc.cart">
		SELECT *
		FROM loc.cart
		ORDER BY person, item, price desc
	</cfquery>
	<cfcatch></cfcatch>
	</cftry>

	<cfreturn loc.cart>
</cffunction>

<!---create method for selectoptions form--->
<cffunction name="createCartItemsFromForm" hint="">
<cfset var loc=structNew()>

	<cfset loc.checkForSelections = putFormIntoShoppingCart()>

	<cfif loc.checkForSelections is 0>
		<cfset flashInsert(message= "Please select at least one registration item for #params.person#.")>
		<cfset flashInsert(person = params.person)>
	<cfif loc.checkForSelections is 2>
		<cfset flashInsert(message= "Please enter the first name of the person or names of the couple you are registering.")>
		<cfset flashInsert(person = params.person)>
	</cfif>
	<cfelseif not regtype() is "family">
		<cfset flashInsert(message= "Enter the first name and selections for the next person you are registering.<br/> Press the checkout button when you are finished.")>
	</cfif>

	<cfif isdefined("params.return")>
		<cfset redirectTo(action=params.return)>
	<cfelse>
		<cfif regtype() is "family">
			<cfset redirectTo(controller="conference.register", action="selectoptions", params="children")>
		<cfelse>
			<cfset redirectTo(controller="conference.register", action="selectoptions")>
		</cfif>
	</cfif>
</cffunction>

<!---Update method for selectoptions form--->
<cffunction name="updateCartItemsFromForm" access="private">

	<cfset deletePerson(params.person)>
	<cfset createCartItemsFromForm(params)>

</cffunction>

<!---Used by createCartItemsFromForm--->
<cffunction name="putFormIntoShoppingCart">
<cfargument name="cost" required="false">


<cfset var loc=structNew()>
<cfset var loc.checkForSelections = 0>
	<!---Fix Name--->
	<cfset params.person = replace(params.person,","," &","all")>
	<cfset params.person = replace(params.person,";"," &","all")>
	<cfset params.person = trim(params.person)>


	<cfif len(params.person)>

	<!--- Loop through all the items in params --->
	<cfloop collection="#params#" item="i">
		<!--- Put any item in the cart that has an id in the params key --->
		<cfif val(i) and params[i]>
			<cfif isDefined("params.cost") && isDefined("params.groupRegId")>
				<cfset addtocart(item=i, quantity = params[i], person = params.person, cost = params.cost, groupRegid = params.groupRegId)>
			<cfelse>
				<cfset addtocart(item=i, quantity = params[i], person = params.person)>
			</cfif>
			<cfset loc.checkForSelections = 1>
		</cfif>
		<!--- Put radio button registration items into the cart --->
		<cfif i is "registration">
			<cfif isDefined("params.cost")>
				<cfset addtocart(item=params[i], quantity = 1, person = params.person, cost = params.costs)>
			<cfelse>
				<cfset addtocart(item=params[i], quantity = 1, person = params.person)>
			</cfif>
			<cfset loc.checkForSelections = 1>
		</cfif>
		<cfif i is "specialcode" and len(params.specialcode)>
		<cfloop list="#params.specialcode#" delimiters=",; " index="loc.ii">
			<cfif isDiscountQualified(trim(loc.ii))>
				<cfset specialCodeItem = model("Conferenceoption").findOne(where="name='#trim(loc.ii)#'")>
				<cftry>
					<cfswitch expression="specialCodeItem.disountType">
						<cfcase value = "percent">
						</cfcase>
						<cfcase value = "maximum">
						</cfcase>
						<cfdefaultcase>
							<cfset addtocart(item=specialCodeItem.id, quantity = 1, person = params.person)>
						</cfdefaultcase>
					</cfswitch>
					<cfset loc.checkForSelections = 1>
				<cfcatch></cfcatch></cftry>
			</cfif>
		</cfloop>
		</cfif>
	</cfloop>

	<cfelse>
		<cfset checkForSelections = 2>
	</cfif>
<cfreturn loc.checkForSelections>
</cffunction>

<!--- Used by putFormIntoShoppingCart()--->
<cffunction name="isDiscountQualified">
<cfargument name="specialcode" required="true" type="string">
<cfset var isQualified = 0>
<cfset var dependency = structnew()>
<cfset var thisoption = structnew()>

<cftry>
<!---Get the discountDependsOn information from the options table--->
<cfset dependency.names = model("Conferenceoption").findOneByName(arguments.specialcode).discountDependsOn>
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

<cffunction name="thisPersonHasThisItemId">
<cfargument name="itemid" required=true type="numeric">
<cfargument name="person" required=true type="string">
<cfset var loc = arguments>

	<cfloop from="1" to="#arraylen(session.shoppingcart)#" index="loc.i">
		<cfif session.shoppingcart[loc.i].person is loc.person AND session.shoppingcart[loc.i].item EQ loc.itemid>
		<cfreturn true>
		</cfif>
	</cfloop>

	<cfreturn false>

</cffunction>






<!--------------------------------->
<!---/conference.register/person--->
<!--------------------------------->

<cffunction name="person">

	<!---Get States data for dropdown--->
	<cfset states = model("Conferencestate").findAll(order="state")>

	<!---Get list of people that are already in the registrationCart for "use same contact information as" dropdown--->
	<cftry>
	<cfset allPeopleList ="#structKeyList(session.registrationCart)#">
	<cfset peopleList = "">
	<cfloop list="#allPeopleList#" index="i">
		<cfif len(session.registrationCart[i].lname)>
			<cfset peopleList = peoplelist & "," & i>
		</cfif>
	</cfloop>
		<cfset peoplelist = replace(peoplelist,",","","one")>
	<cfcatch></cfcatch></cftry>

	<!--- Set up default blank form values --->
	<cfset formFieldList = "fname,sname,lname,gender,address,city,handbook_statesid,country,province,zip,email,phone,specialneeds,age,familyemail,familyphone,type">
	<cfloop list="#formFieldList#" index="i">
		<cfparam name="params.#i#" default="">
	</cfloop>

	<!---Get the name from the first person in the shopping cart and put into params.thisperson--->
	<cfparam name="params.key" default="1">
	<cftry>
		<cfset params.thisperson = session.shoppingcart[params.key].person>
		<!---if there is already a person set in params use that one instead--->
		<cfif isdefined("params.person") and len(params.person)>
			<cfset params.thisperson = params.person>
		</cfif>
	<cfcatch>
		<!---If there is no one left to update, show the registrations--->
		<cfset redirectTo(action="showregs")>
	</cfcatch>
	</cftry>


	<!---If you are editing someone already in the registration cart, use that data--->
	<!---Need to find a better way to trap this--->
	<cftry>
	<cfloop list="#formFieldList#" index="i">
		<cfif structKeyExists(session.registrationCart,params.thisperson)>
			<cfset params[i] = session.registrationCart[params.thisperson][i]>
		</cfif>
	</cfloop>
	<cfcatch></cfcatch></cftry>

	<!---Set default names based on shopping cart person, used as defaults in first name and spouse name field--->
	<cfif params.fname is "" and params.lname is "" and isdefined("params.thisperson")>
		<cfset params.fname = listFirst(params.thisperson," ")>
		<cfset params.sname = listLast(params.thisperson," ")>

	<!---Decide if spouses field is needed--->

		<!---If fname and sname is the same it is not needed--->
		<cfif params.fname is params.sname>
			<cfset params.isCouple = false>
			<cfset params.sname = "">
		<cfelse>
			<cfset params.isCouple = true>
		</cfif>


		<!---If a couples registration item is selected show spouses field--->
		<cfset coupleItemIds = model("Conferenceoption").findAll(where="name like '%couple%' AND event = '#getEvent()#' AND type='registration'")>

		<cfloop from="1" to="#arraylen(session.shoppingcart)#" index="i">
			<cfif session.shoppingcart[i].person is params.thisperson>
				<cfloop query="coupleItemIds">
					<cfif session.shoppingcart[i].item EQ id>
						<cfset params.isCouple = true>
						<cfbreak>
					</cfif>
				</cfloop>
			</cfif>
		</cfloop>
	</cfif>

	<!---If this is adding to a current families reg - set that familyid--->
	<cfif isdefined("session.registrationcart.familyid")>
		<cfset thisfamily = model("Conferencefamily").findByKey(key=session.registrationcart.familyid, include="state")>
		<cfset thisfamily.usecontactfrom = "">
	</cfif>

	<!---set params.regtype for this params.thisperson--->
	<cfset params.regtype = getCartPersonsType(params.thisperson)>

	<!---Get Age Ranges for Dropdown--->
	<cfif isdefined("params.regtype")>
		<cfset ageRanges = model("Conferenceage_range").findAll(where="type='#params.regtype#'", order="name")>
	<cfelse>
		<cfset ageRanges = model("Conferenceage_range").findAll(order="name")>
	</cfif>

	<!---Set the formaction and form parameter--->
	<cfif isdefined("params.person")>
		<cfset formaction = "updatePersonInRegistrationCart">
	<cfelse>
		<cfset formaction = "addPersonToRegistrationCart">
	</cfif>

	<cfif isdefined("params.regtype")>
		<cfset formparams = "key="&params.key&"&type="&params.regtype>
	<cfelse>
		<cfset formparams = "key="&params.key>
	</cfif>

	<!---Set the submit button text--->
	<cfset submitbutton = "Submit">

</cffunction>

<cffunction name="getCartPersonsType">
<cfargument name="person" required="yes" type="string">
<cfset type="Adult">
<cfset sc = session.shoppingcart>
	<cfloop from="1" to="#arraylen(sc)#" index="i">
		<cfset option = model("Conferenceoption").findByKey(sc[i].item)>
		<cfif sc[i].person is arguments.person and option.type contains "GraceKids-Nursery">
			<cfset type="GKN">
		<cfbreak>
		</cfif>
	</cfloop>
	<cfloop from="1" to="#arraylen(sc)#" index="i">
		<cfset option = model("Conferenceoption").findByKey(sc[i].item)>
		<cfif sc[i].person is arguments.person and option.type contains "GraceKids-Preschool">
			<cfset type="GKP">
		<cfbreak>
		</cfif>
	</cfloop>
	<cfloop from="1" to="#arraylen(sc)#" index="i">
		<cfset option = model("Conferenceoption").findByKey(sc[i].item)>
		<cfif sc[i].person is arguments.person and option.type contains "GraceKids-Elementary">
			<cfset type="GKE">
		<cfbreak>
		</cfif>
	</cfloop>
<cfreturn type>
</cffunction>

<!---update method to process person form--->
<cffunction name="updatePersonInRegistrationCart">
	<cfloop list="#fields()#" index="i">
		<cfset session.registrationCart[params.thisperson][i] = params[i]>
	</cfloop>
	<cfset redirectTo(action="showregs")>
</cffunction>

<!---save method to process person form--->
<cffunction name="addPersonToRegistrationCart">
<cfif not len(params.lname) AND not len(params.usecontactfrom)>
	<cfset flashInsert(message = "Please provide a last name.")>
	<cfset redirectTo(back=true)>
<cfelseif not len(params.fname)>
	<cfset flashInsert(message = "Please provide a first name.")>
	<cfset redirectTo(back=true)>
<cfelseif not isvalid("email", params.email) AND not params.email contains "parent">
	<cfset flashInsert(message = "Please provide an email address.")>
	<cfset redirectTo(back=true)>
<cfelse>
	<cfset params.fieldnames = form.fieldnames>
	<!--- Create the Registration Cart if it does not exists --->
		<cftry>
		<cfif not isStruct(session.registrationCart)>
		<cfset session.registrationCart = structNew()>
		</cfif>
			<cfcatch>
				<cfset session.registrationCart = structNew()>
			</cfcatch>
		</cftry>



	<!--- Put this person in the cart if not exists already --->
		<cfif not structKeyExists(session.registrationCart,params.thisperson)>
		<!---Put form/params information in that registration cart record--->
			<cfloop list="#params.fieldnames#" index="i">
				<cfset session.registrationCart[params.thisperson][i] = params[i]>
			</cfloop>
<!---
			<cfset session.registrationCart[params.thisperson].type = getSpouse(params.thisperson)>
 --->
		</cfif>

	<cfset params.nextperson = getNextPersonInShoppingCart(params.thisperson)>
	<cfset redirectTo(action="person", params="key=#params.nextperson.key#")>
</cfif>
</cffunction>


<!---end of posting methods for the person() method--->








<!----------------------------------->
<!---/conference.register/showregs--->
<!----------------------------------->

<cffunction name="showregs">
	<cftry>
		<cfset rc = duplicate(session.registrationcart)>
		<cfset sc = duplicate(session.shoppingcart)>
		<cfset structDelete(rc,"familyid")>
		<cfset structDelete(rc,"invoiceid")>
		<cfset listOfNamesInRegCart = structKeyList(rc)>
		<cfset formaction = "postCarts">
	<cfcatch>
		<cfset errormessage = "<p>So sorry.  An error has occured in creating your shopping cart.</p><p>#linkto(text="Use this link to try your registration again.", route="conferencereg", class="btn")#</p><p>An alert has been sent and we will check into the error.</p><p>If you need more immediate help, email #mailto('tomavey@fgbc.org')#.</p>">

		<cfset sendEmail(subject="Conference Show Regs Error", to="tomavey@fgbc.org", from="tomavey@fgbc.org", template="showregserror", layout="layout_for_email")>

	</cfcatch>
	</cftry>
</cffunction>

<cffunction name="getInvoiceIdFromRegId">
<cfargument name="regId" required="true" type="numeric">
<cfset var loc = arguments>
	<cfset loc.reg = model("Conferenceregistration").findOne(where="id=#loc.regid#")>
	<cfif isObject(loc.reg)>
		<cfreturn loc.reg.equip_invoicesId>
	<cfelse>
		<cfset renderText("oops - there is not registration with this id")><cfabort>
	</cfif>	
</cffunction>

<!---Put shopping cart and registration info into the database--->
<cffunction name="postCarts">
<cfset var rc = session.registrationcart>
<cfset var sc = session.shoppingcart>

	<cfset RegisterFamilies()>
	<cfset RegisterPeople()>
	<cfset putPeopleIdInShoppingcart()>
		<cfif usingGroupReg()>
		<cfset thisInvoiceid = getInvoiceIdFromRegId(session.shoppingCart[1].groupRegId)>
	<cfelse>
		<cfset thisinvoiceid = createEmptyInvoice()>
	</cfif>
	<cfset rc.invoiceid = thisinvoiceid>
	<cfset postShoppingCart()>
	<cfset emailbeforepayment(thisinvoiceid)>

	<cfset redirectTo(action="GetAgent")>
</cffunction>

<!---Used by postCarts()--->
<cffunction name="RegisterFamilies" access="private">
<cfset var index=structnew()>
<cfset var peoplelist = getRegistrationCartLists()>
<cfset var rc = session.registrationcart>
<cfset var thisfamily=structnew()>
<cfset var thisfamilyBasic=structnew()>
<cfset var thisperson = "">

	<!---For each person that does not have a usecontactfrom key either create a new record or update an existing one--->
	<cfloop list="#peoplelist.parents#" index="thisperson">
		<cfset thisfamily.lname = rc[thisperson].lname>
		<cfset thisfamily.address = replace(rc[thisperson].address,'.','','all')>
		<cfset thisfamily.address = "test">
		<cfset thisfamily.city = rc[thisperson].city>
		<cfset thisfamily.handbook_statesid = rc[thisperson].handbook_statesid>
		<cfset thisfamily.province = rc[thisperson].province>
		<cfset thisfamily.country = rc[thisperson].country>
		<cfset thisfamily.email = rc[thisperson].familyemail>
		<cfset thisfamily.phone = rc[thisperson].familyphone>
		<cfset thisfamily.comment = rc[thisperson].specialneeds>

		<!---If this is adding to an existing family, rc.familyid should be set. This code puts that id into the persons equip_familiesid key--->
		<cftry>
			<cfset rc[thisperson].equip_familiesid = rc.familyid>
			<cfset thisfamily.equip_familiesid = rc.familyid>
		<cfcatch></cfcatch></cftry>

		<!---If a new person, create the record--->
		<cfif not structkeyexists(rc[thisperson],"equip_familiesid")>
			<!---Catches errors due to certain charactes in addresses. Not sure why it happens--->
			<cftry>
			<cfset rc[thisperson].equip_familiesid = model("Conferencefamily").create(thisfamily).id>
			<cfcatch>
				<cfset thisfamilybasic.lname = rc[thisperson].lname>
				<cfset thisfamilybasic.email = rc[thisperson].familyemail>
				<cfset rc[thisperson].equip_familiesid = model("Conferencefamily").create(thisfamilybasic).id>
			</cfcatch>
			</cftry>

		<!---If an existing person, updated the record--->
		<cfelse>
			<cfset thisfamily.id = rc[thisperson].equip_familiesid>
			<cfset thisfamilyrecord = model("Conferencefamily").findByKey(thisfamily.id)>
			<cfset thisfamilyrecord.update(thisfamily)>
		</cfif>

		<!---create an index for child families lookup--->
		<cfset index[thisperson]=rc[thisperson].equip_familiesid>

	</cfloop>

	<!---For each person that does have a usecontactfrom key, set that persons family id to it's parent record--->
	<cfloop list="#peoplelist.childs#" index="thisperson">

			<cfset usecontactfrom = rc[thisperson].usecontactfrom>
			<cfset rc[thisperson].equip_familiesid = index[usecontactfrom]>

	</cfloop>
</cffunction>

<!---Used by postCarts()--->
<cffunction name="RegisterPeople" access="private">
<cfset var peoplelist = getRegistrationCartLists()>
<cfset var rc = session.registrationcart>
<cfset var eachpersonreg = structNew()>

<cflock name="registerpeople" timeout = "30" type = "Exclusive">
	<cfloop list="#peoplelist.all#" index="eachperson">
		<cfloop list="fname,equip_familiesid,type,age,email,phone,gender" index="r">
			<cfset eachpersonreg[r] = rc[eachperson][r]>
		</cfloop>

		<!---If there is not a fnameid key for this person, that means he has not been registered yet so register him--->
		<cfif not structkeyexists(rc[eachperson],"fnameid")>
			<cfset rc[eachperson].fnameid = model("Conferenceperson").create(eachpersonreg).id>
		<cfelse>
			<cfset eachpersonreg.id = rc[eachperson].fnameid>
			<cfset thisperson = model("Conferenceperson").findByKey(key=eachpersonreg.id, include="family")>
			<cfset thisperson.update(eachpersonreg)>
		</cfif>
		<cfif len(rc[eachperson].sname)>
				<cfset params.fname = rc[eachperson].sname>
				<cfif rc[eachperson].gender is "Male" or rc[eachperson].gender is "M">
					<cfset params.gender = "Female">
				<cfelseif rc[eachperson].gender is "Female" or rc[eachperson].gender is "F">
					<cfset params.gender = "Male">
				</cfif>
				<cfset params.type = "spouse">
				<cfset params.equip_familiesID = rc[eachperson].equip_familiesid>
			<cfif not structKeyExists(rc[eachperson],"snameid")>
				<cfset sperson = model("Conferenceperson").create(params)>
				<cfset rc[eachperson].snameid = sperson.id>
			<cfelse>
				<cfset rc[eachperson].id = rc[eachperson].fnameid>
				<cfset thisperson = model("Conferenceperson").findByKey(key=rc[eachperson].snameid, include="family")>
				<cfset thisperson.update(params)>
			</cfif>
		</cfif>
	</cfloop>
</cflock>

</cffunction>

<!---Used by postCarts()--->
<cffunction name="putPeopleIdInShoppingcart" access="private">
<cfset var sc = session.shoppingcart>
<cfset var rc = session.registrationcart>
	<cflock name="putPeopleIdInShoppingcart" timeout = "30" type = "Exclusive">
		<cfloop from = "1" to = "#arraylen(sc)#" index="i">
			<cfset thisperson = sc[i].person>
			<cfset sc[i].equip_peopleid = rc[thisperson].fnameid>
		</cfloop>
	</cflock>
</cffunction>

<!---Used by postCarts()--->
<cffunction name="createEmptyInvoice" access="private">
<cfset var emptyinvoice= structnew()>
<cfset var thisinvoice = structNew()>
<cfset var rc = session.registrationCart>
<cfset var neworderid = "">
<cflock timeout="30">
	<cfif structKeyExists(rc,"invoiceid")>
		<cfset thisinvoice.id = rc.invoiceid>
	<cfelse>
		<cfset emptyinvoice.ccorderid = "temp">
		<cfset emptyinvoice.event = getEvent()>
		<cfset emptyinvoice.ccamount = 0>
		<cfset emptyinvoice.ccname = "NA">
		<cfset emptyinvoice.ccemail = "NA">
		<cfset emptyinvoice.ccstatus = "Pending">
		<cfset emptyinvoice.agent = "temp">
		<cfset orderidlname = getlname()>
		<cfset thisinvoice = model("Conferenceinvoice").create(emptyinvoice)>
		<cfset neworderid = thisinvoice.id & emptyinvoice.event & orderIdLname>
		<cfset model("Conferenceinvoice").findByKey(thisinvoice.id).update(ccorderid=neworderid)>
	</cfif>
</cflock>
<cfreturn thisinvoice.id>
</cffunction>

<!---Used by postCarts()--->
<cffunction name="getRegistrationCartLists" returntype="struct" access="private">
<cfset var parentpeoplelist = "">
<cfset var childpeoplelist = "">
<cfset var peoplelist = structnew()>
<cfset var allPersonsInRegistrationCart = structkeylist(session.registrationcart)>
<cfset var invoiceIdLocation = listFind(allPersonsInRegistrationCart,"INVOICEID")>
<cfset var familyIdLocation = listFind(allPersonsInRegistrationCart,"FAMILYID")>
<cfset var rc = session.registrationcart>

<cflock timeout="30">
	<!---clean up extra info from rc--->
	<cfif invoiceIdLocation>
		<cfset allPersonsInRegistrationCart = listDeleteAt(allPersonsInRegistrationCart,invoiceIdLocation)>
	</cfif>
	<cfif familyIdLocation>
		<cfset allPersonsInRegistrationCart = listDeleteAt(allPersonsInRegistrationCart,familyIdLocation)>
	</cfif>

		<cfloop list="#allPersonsInRegistrationCart#" index="i">
			<cfif not len(rc[i].usecontactfrom)>
				<cfset parentpeoplelist= parentpeoplelist & "," & i>
			<cfelse>
				<cfset childpeoplelist= childpeoplelist & "," & i>
			</cfif>
		</cfloop>
		<cfset peoplelist.parents = trim(replace(parentpeoplelist,",","","one"))>
		<cfset peoplelist.childs = trim(replace(childpeoplelist,",","","one"))>
		<cfset peoplelist.all = trim(allPersonsInRegistrationCart)>
</cflock>
<cfreturn peoplelist>
</cffunction>

<!---Used by postCarts()--->
<cffunction name="postShoppingCart" access="private">
<cfset var sc = session.shoppingCart>
<cfset var rc = session.registrationCart>
<cfset var i = "">
<cfset var thisreg = structNew()>
<!---Loop from each shopping cart item and save or update that information--->
<cflock timeout="20">
	<cfloop from="1" to="#arraylen(sc)#" index = "i">
		<cfset thisreg.equip_peopleid = sc[i].equip_peopleid>
		<cfset thisreg.equip_invoicesid = rc.INVOICEID>
		<cfset thisreg.equip_optionsid = sc[i].item>
		<cfset thisreg.quantity = sc[i].quantity>
		<cfif usingGroupReg()>
			<cfset thisreg.cost = session.shoppingCart[1].cost>
		<cfelse>
			<cfset thisreg.cost = model("Conferenceoption").findByKey(sc[i].item).cost>
		</cfif>

		<cfif structKeyExists(sc[i],"id")>
			<cfset thisreg.id = sc[i].id>
			<cfset thisRegistration = model("Conferenceregistration").findByKey(thisreg.id).update(thisReg)>
		<cfelse>
			<cfset thisRegistration = model("Conferenceregistration").create(thisReg)>
			<cfset sc[i].id = thisRegistration.id>
		</cfif>
	</cfloop>
</cflock>
</cffunction>

<!---Used by postCarts()--->
<cffunction name="emailbeforepayment">
<cfargument name="thisinvoiceid" default="1">

	<cftry>
	<cfset sendemail(from="tomavey@fgbc.org", to=getRegistrar(), template="emailbeforepayment", subject="#getEventAsTextA()# Registration has been started", layout="layout_for_email", thisinvoiceid=arguments.thisinvoiceid)>
	<cfcatch></cfcatch>
	</cftry>


</cffunction>


<!---End of methods for postCarts--->










<!----------------------------------->
<!---/conference.register/getagent--->
<!----------------------------------->

<cffunction name="getAgent">

	<cftry>
	<cfset keysInRegCart = structKeyList(session.registrationcart)>

	<cfset invoiceIdLocation = listfind(keysInRegCart,"INVOICEID")>

	<cfset peopleInRegCart = listDeleteAt(keysInRegCart,invoiceIdLocation)>
	<cfset firstPersonInRegistrationCart = listfirst(peopleinRegCart)>

	<cfif structKeyExists(session.registrationcart[firstPersonInRegistrationCart],"email") and session.registrationcart[firstPersonInRegistrationCart].email is not "parent">
		<cfset params.agent = session.registrationcart[firstPersonInRegistrationCart].email>
	<cfelse>
		<cfset params.agent = "">
	</cfif>

	<cfcatch><cfset params.agent = ""></cfcatch></cftry>

	<cfset session.payonline = structnew()>
	<cfset session.payonline.invoiceid = session.registrationcart.invoiceid>

	<!---Set the invoice amount to the total in cart--->
	<cfif !usingGroupReg()>
		<cfset test = model("Conferenceinvoice").findOne(where="id=#session.payonline.invoiceid#").update(ccamount=register.totalinshoppingcart())>
	<cfelse>	
		<cfset remove1RegFromGroup(session.shoppingCart[1].groupRegId)>
	</cfif>
	<cfset formaction2="conferenceSaveAgent">
</cffunction>

<cffunction name="saveAgent">
	<cfif isvalid("email", params.agent) OR params.agent is "comp" OR params.agent is "manual" OR params.agent is "prepaid" OR params.agent is "test">
		<cfset session.registrationcart.agent = params.agent>
		<cfset model("Conferenceinvoice").updateByKey(key=session.registrationcart.invoiceid, agent=session.registrationcart.agent)>
		<cfset thisinvoice = model("Conferenceinvoice").findOne(where="id=#session.registrationcart.invoiceid#")>
		<cfset optionsInThisInvoice = model("Conferenceregistration").findall(where="equip_invoicesid = #session.registrationcart.invoiceid#", include="option,person(family)", order="equip_people.id")>

		<cfif gotRights("office")>

			<cfset sendemail(from=getRegistrar(), to=thisinvoice.agent, cc=getSetting('registrarEmail'), template="invoice", subject="Your #getEventAsText()# Registration", layout="layout_for_email")>

		</cfif>

	<cfelse>
		<cfset flashInsert(agent="Please enter a valid email address")>
		<cfset redirectTo(action="getAgent")>
	</cfif>
	<!---Set conditions where no online payment is needed--->

	<cfif usingStaffReg()>	
		<cfset redirectTo(controller="conference.invoices", action="show", key=session.registrationcart.invoiceid, params="ccstatus=Comp")>
	<cfelseif params.agent is "prepaid">
		<cfset redirectTo(controller="conference.invoices", action="show", key=session.registrationcart.invoiceid, params="ccstatus=paid")>
	<cfelseif params.agent is "manual@fgbc.org" OR params.agent is "comp" OR params.agent is "manual" OR params.agent is "test" OR register.totalInShoppingCart() LTE 0>
		<cfset redirectTo(controller="conference.invoices", action="show", key=session.registrationcart.invoiceid, params="ccstatus=TBD")>
	<cfelseif usingGroupReg()>
		<cfset redirectTo(controller="conference.invoices", action="show", key=session.registrationcart.invoiceid)>
	</cfif>

	<cfif params.agent is "tomavey@fgbc.org" AND application.wheels.environment is "development">
		<cfset redirectTo(action="confirm", params="email=tomavey@fgbc.org&nameoncard=Tom Avey&total=1&status=1&key=#session.registrationcart.invoiceid#")>
	<cfelse>
		<cfset redirectTo(action="payonline")>
	</cfif>
</cffunction>

<cffunction name="payExistingInvoiceOnline">
	<cfset payonline = structnew()>
	<cfset payonline.merchant = "fellowshipofgracen">
	<cfset payonline.orderid = params.ccorderid>
	<cfset invoice =  model("Conferenceinvoice").findOne(where="ccorderid = '#params.ccorderid#'")>
	<cfset payonline.email = invoice.agent>
	<cfset payonline.amount = invoice.ccamount>

	<cfif CGI.http_host CONTAINS "localhost:8888">
		<cfset payonline.url = "http://localhost:8888/index.cfm?controller=conference.register&action=confirm">
	<cfelse>
		<cfset payonline.url = "http://#CGI.http_host#/index.cfm?controller=conference.register&action=confirm">
	</cfif>

	<cfset renderPage(template="payonline")>
</cffunction>


<!---/conference.register/payonline ---- autosubmited by javascript ---->
<cffunction name="payonline">

	<cfset payonline = structnew()>
	<cfset payonline.merchant = "fellowshipofgracen">
	<cfset payonline.orderid = model("Conferenceinvoice").findOne(where="id=#session.registrationcart.invoiceid#").ccorderid>
	<cfset payonline.email = session.registrationcart.agent>
	<cfset payonline.amount = register.totalInShoppingCart()>
	<cfset session.payonline = payonline>
	<cfif CGI.http_host CONTAINS "localhost:8888">
		<cfset payonline.url = "http://localhost:8888/index.cfm?controller=conference.register&action=confirm">
	<cfelse>
		<cfset payonline.url = "http://#CGI.http_host#/index.cfm?controller=conference.register&action=confirm">
	</cfif>
	<cfif val(payonline.amount) is 0>
		<cfset redirectTo(action="confirm", params="email=tomavey@fgbc.org&nameoncard=Tom Avey&total=1&status=1&key=#session.registrationcart.invoiceid#")>
	</cfif>

</cffunction>














<!---Methods to handle the confirmation process after payment has been attempted--->

<cffunction name="confirm">
<cfset var thistransaction = structNew()>
<cfset var thisagent = structNew()>

	<cftry>
	<cfset deletecarts()>
	<cfcatch></cfcatch></cftry>

     <cftry>
	<cfset thistransaction = getTransactionFromParamsForConfirmation(params)>

	<!--- I use this for force the catch block to test the redirect and sendemail--->
	<cfif isDefined("params.forceCatchBlock")>
		<cfset  forceCatchBlock = params.doesnotexist>
	</cfif>
	<!--------------->

	<cfif params.status>


		<cfset test = model("Conferenceinvoice").findByKey(thistransaction.key).update(thistransaction)>

<!---
		<cfset extendorderid(ccorderid = thistransaction.key, extension=thistransaction.ccname)>
--->

		<cfset thisagent = model("Conferenceinvoice").findByKey(thistransaction.key)>

		<cfif thisagent.agent is "">
			<cfset thisagent.agent = thistransaction.ccemail>
			<cfset model("Conferenceinvoice").updateByKey(key=thistransaction.key,agent=thisagent.agent)>
		</cfif>

		<cfset thisInvoice = model("Conferenceinvoice").findOne(where="id=#thistransaction.key#")>
		<cfset optionsInThisInvoice = model("Conferenceregistration").findall(where="equip_invoicesid = #thistransaction.key#", include="option,person(family)", order="equip_people.id")>

		<cfset sendemail(from=getRegistrar(), to=thisinvoice.agent, cc=getSetting('registrarBackupEmail'), template="invoice", subject="Your #getEventAsText()# Registration", layout="layout_for_email")>

		<cfset sendemail(from=thisinvoice.agent, to=getRegistrar(), template="invoice", subject="#getEventAsTextA()# Registration from #thisinvoice.agent#", cc=application.wheels.errorEmailAddress, layout="layout_for_email")>

		<cfset redirectTo(controller="conference.register", action="invoice", params="NameOnCard=#params.NameOnCard#&email=#params.email#&status=#params.status#&amount=1&orderid=#params.orderid#&key=#val(params.orderid)#")>

	<cfelse>

		<cfset redirectTo(action="declined", params="key=#thistransaction.key#")>

	</cfif>
 	<cfcatch>
 		<cfset sendEmail(subject="Conference Registration Confirmation Error", to=application.wheels.registrarEmail, from=application.wheels.requestInvoiceReceiptFrom, template="confirmationerror")>
 		<cfset redirectTo(action="thankyou")>
 	</cfcatch>
      </cftry>

</cffunction>

<cffunction name="thankyou">

</cffunction>

<cffunction name="deleteCarts">
	<cfif structKeyExists(session,"registrationCart")>
		<cfset structdelete(session,"registrationCart")>
	</cfif>
	<cfif structKeyExists(session,"shoppingCart")>
		<cfset structdelete(session,"shoppingCart")>
	</cfif>
</cffunction>

<cffunction name="extendOrderId">
<cfargument name="extension" required="yes" type="string">
<cfargument name="ccorderid" required="yes" type="string">
<cfset var thisinvoice = structNew()>
<cfset var oldOrderId = "">
<cfset var newOrderId = "">
<cfset arguments.extension = replace(arguments.extension," ","","all")>
<cftry>
	<cfset thisinvoice.id = val(ccorderid)>
	<cfset oldOrderId = model("Conferenceinvoice").findOne(where="id=#thisinvoice.id#").ccorderid>
	<cfif not find(arguments.extension,oldOrderid)>
	<cfset newOrderId = oldOrderId & arguments.extension>
	<cfset model("Conferenceinvoice").findByKey(thisinvoice.id).update(ccorderid = newOrderId)>
	</cfif>
<cfcatch>
</cfcatch>
</cftry>
</cffunction>

<cffunction name="getTransactionFromParamsForConfirmation">
<cfargument name="params" type="struct">
<cfset var thistransaction  = structNew()>
	<cfscript>
		if (isdefined("params.key")) {params.orderid = params.key;};
		thistransaction.ccname = params.NameonCard;
		thistransaction.ccemail = params.email;
		thistransaction.ccstatus = params.Status;
		thistransaction.containerid = val(params.Orderid);
		thistransaction.key = val(params.OrderId);
	</cfscript>
<cfreturn thistransaction>
</cffunction>


<!---/conference.register/invoice--->
<cffunction name="invoice">
<cfset var thiskey = "">
<cftry>
	<!--- I use this for force the catch block to test the redirect and sendemail--->
	<cfif isDefined("params.forceInvoiceCatchBlock")>
		<cfset  forceCatchBlock = params.doesnotexist>
	</cfif>
	<!--------------->

<cfset thisinvoice = structNew()>
<cfset optionsInThisInvoice = structNew()>
	<cfif isdefined("params.key")>
		<cfset thiskey = val(params.key)>
	<cfelse>
		<cfset thiskey = val(params.orderid)>
	</cfif>

	<cfset thisInvoice = model("Conferenceinvoice").findOne(where="id=#thiskey#")>
	<cfset optionsInThisInvoice = model("Conferenceregistration").findall(where="equip_invoicesid = #thiskey#", include="option,person(family)", order="equip_people.id")>
<cfcatch>
	<cfset sendEmail(subject="Conference Invoice Error", to=application.wheels.registrarEmail, from=application.wheels.requestInvoiceReceiptFrom, template="confirmationerror")>
	<cfset redirectTo(action="thankyou")>
</cfcatch>
</cftry>
</cffunction>

<!---Called from a link on the invoice--->
<cffunction name="sendInvoiceByEmail">
<cfargument name="invoiceid" required="yes" type="numeric">
<cfset thisinvoice = structNew()>
<cfset optionsInThisInvoice = structNew()>

	<cfset thisInvoice = model("Conferenceinvoice").findOne(where="id=#arguments.invoiceid#")>
	<cfset optionsInThisInvoice = model("Conferenceregistration").findall(where="equip_invoicesid = #arguments.invoiceid#", include="option,person(family)", order="equip_people.id")>
	<cfset sendemail(from=application.wheels.registraremail, to=thisinvoice.email, template="invoice", subject="Your #getEventAsText()# Registration", layout="layout_for_email", type="html")>
</cffunction>



<!---/conference.register/declined--->
<cffunction name="declined">
<cfset var thiskey = "">

<cfset payonline = structnew()>
<cfset thisinvoice = structNew()>
<cfset thiskey = val(params.key)>

	<cfset thisInvoice = model("Conferenceinvoice").findOne(where="id=#thiskey#")>

	<cfset payonline.merchant = "fellowshipofgracen">
	<cfset payonline.orderid = thisinvoice.ccorderid>
	<cfset payonline.email = thisinvoice.agent>
	<cfset payonline.amount = thisinvoice.ccamount>
	<cfif CGI.http_host CONTAINS "localhost:8888">
		<cfset payonline.url = "http://localhost:8888/index.cfm?controller=conference.register&action=confirm">
	<cfelse>
		<cfset payonline.url = "http://fgbc.org/index.cfm?controller=conference.register&action=confirm">
	</cfif>

</cffunction>

<!---Methods that do not map to a view but do a redirect--->

<cffunction name="deletePersonThenRedirect">
	<cfset deletePerson(params.person)>
<cfset redirectTo(controller="conference.register", action="selectoptions")>
</cffunction>


<cffunction name="emptyRegistrationCart" access="public" returntype="void" output="false">
	<cftry>
		<cfset structDelete(session, "registrationCart")>
	<cfcatch></cfcatch></cftry>
	<cfset redirectTo(controller="conference.register", action="selectoptions")>
</cffunction>

<cffunction name="addPersonToCart">

<!---Create the registrationCart if it does not exist--->
<cftry>
<cfif not isArray(session.registrationCart)>
<cfset session.registrationCart = arraynew(1)>
</cfif>
	<cfcatch>
	<cfset session.registrationCart = arraynew(1)>
	</cfcatch></cftry>

<!---Get the current size of the registration cart and create a empty record--->
<cfset sizeOfCart = arraylen(session.registrationCart)>
<cfset thisCart = sizeOfCart+1>
<cfset session.registrationCart[thisCart] = structNew()>

<!---Put form/params information in that registration cart record--->
	<cfloop list="fname,sname,lname,address,city,state,country,province,zip,email,phone,specialneeds,key" index="i">
		<cfset session.registrationCart[thisCart][i] = params[i]>
	</cfloop>

<cfloop from="1" to="#arrayLen(session.shoppingcart)#" index="i">
	<cfif session.shoppingcart[i].person is not params.thisperson>
	<cfset params.nextperson = params.key+1>
	<cfbreak>
	</cfif>
</cfloop>

<cfset params.nextperson = getNextPersonInShoppingCart(params.thisperson)>

<cfset redirectTo(action="person", params="key=#params.nextperson.key#")>

</cffunction>

<cffunction name="tryagain">
	<cfset emptyCart()>
	<cfset renderPage(action="selectoptions")>
</cffunction>

<cffunction name="emptyCart" access="public" returntype="void" output="false">
<cfargument name="returnto" default="selectoptions">
	<cfset arrayclear(session.shoppingcart)>
	<cftry>
	<cfset structDelete(session,"registrationcart")>
	<cfcatch></cfcatch></cftry>
	<cfset redirectTo(back=true)>
</cffunction>




<!---Methods that do not map to a view. Could be moved to model?--->

<cffunction name="deletePerson">
<cfargument name="person" default="#params.person#">
	<cflock timeout="10" type="exclusive">
		<cfloop from="1" to="3" index="ii">
			<cfloop from="1" to="#arrayLen(session.shoppingcart)#" index="i">
				<cftry>
				<cfif session.shoppingcart[i].person is arguments.person>
					<cfset arrayDeleteAt(session.shoppingcart, i)>
				</cfif>
				<cfcatch></cfcatch></cftry>
			</cfloop>
		</cfloop>
	</cflock>
</cffunction>

<cffunction name="addToCart" >
<cfargument name="item" required="true">
<cfargument name="quantity" required="true">
<cfargument name="person" required="true">
<cfargument name="cost" required="false">
<cfargument name="groupRegId" required="false">
<cfset arguments.quantity = val(arguments.quantity)>
<cfset arguments.person = trim(arguments.person)>
<cfset newitem = "true">

<cflock timeout="10" type="exclusive">
<cfloop from="1" to="#arrayLen(session.shoppingcart)#" index="i">
	<cfif session.shoppingcart[i].item EQ arguments.item
		AND session.shoppingcart[i].person EQ arguments.person
	>
			<cfset session.shoppingcart[i].quantity = arguments.quantity>
		<cfset newitem = "false">
		<cfbreak>
	</cfif>
</cfloop>

<cfif newItem>
	<cfset arrayAppend(session.shoppingcart, structNew())>
	<cfset session.shoppingcart[arrayLen(session.shoppingcart)].item = arguments.item>
	<cfset session.shoppingcart[arrayLen(session.shoppingcart)].person = arguments.person>
	<cfset session.shoppingcart[arrayLen(session.shoppingcart)].quantity = arguments.quantity>
	<cfif isDefined("arguments.cost")>
		<cfset session.shoppingcart[arrayLen(session.shoppingcart)].cost = arguments.cost>
	</cfif>
	<cfif isDefined("arguments.groupRegId")>
		<cfset session.shoppingcart[arrayLen(session.shoppingcart)].groupRegId = arguments.groupRegId>
	</cfif>
</cfif>
</cflock>
</cffunction>

<cffunction name="updateCart">
<cfargument name="item" type="string" required="yes">
<cfargument name="person" type="string" default="">
<cfargument name="quantity" type="numeric" required="no">
<cfif arguments.quantity>
	<cflock timeout="10" type="exclusive">
		<cfset arrayAppend(session.shoppingcart, structNew())>
		<cfset session.shoppingcart[arrayLen(session.shoppingcart)].item = arguments.item>
		<cfset session.shoppingcart[arrayLen(session.shoppingcart)].person = arguments.person>
		<cfset session.shoppingcart[arrayLen(session.shoppingcart)].quantity = arguments.quantity>
	</cflock>
</cfif>
</cffunction>

<cffunction name="removeFromCart">
<cfargument name="cartid" type="numeric" required="yes">
<cfset arrayDeleteAt(session.shoppingcart, arguments.cartid)>
</cffunction>

<cffunction name="testgetOptionDescriptionAndPrice">
<cfif isDefined("params.key")>
	<cfset id = params.key>
<cfelse>
	<cfset id = 365>
</cfif>
	<cfset test = getOptionDescriptionAndPrice(id)>
	<cfdump var="#test#"><cfabort>
</cffunction>

<cffunction name="getOptionDescriptionAndPrice">
<cfargument name="id" required=true type="numeric">
<cfargument name="person" default="">
<cfset var loc = arguments>

	<cfset loc.thisOptionDescriptionAndPrice = model("Conferenceoption").findByKey(key=loc.id, select="id,name,buttondescription,cost,type,discountType,discountDependsOn,event", returnAs="query", cache=0)>

	<cfif usingGroupReg()>
		<cfset loc.thisOptionDescriptionAndPrice.cost[1] = session.shoppingCart[1].cost>
	</cfif>

	<!---use this clone to actually create the query for the shopping cart--->
	<cfset loc.cloneOptionDescriptionAndPrice = duplicate(loc.thisOptionDescriptionAndPrice)>

	<cfset debug.thisOptionDescriptionAndPrice[loc.id] = loc.thisOptionDescriptionAndPrice>
	<cfset debug.cloneOptionDescriptionAndPrice[loc.id] = loc.cloneOptionDescriptionAndPrice>

	<!---convert price for discounts that are based on percent of dependant item--->
	<cfif loc.cloneOptionDescriptionAndPrice.type is "discount">

		<!---If a list of dependent options is provided, select the one that qualifies--->
		<cfset loc.discountDependsOn.Id = getQualifyingOptionForDisount(loc.cloneOptionDescriptionAndPrice,loc.person)>


 		<!--- get the dependant option--->
		<cfset loc.discountIsBasedOn.Cost = model("Conferenceoption").findOne(where="id='#loc.discountDependsOn.Id#' AND event = '#loc.cloneOptionDescriptionAndPrice.event#'")>


	<cfset debug.discountIsBasedOn[loc.id] = loc.discountIsBasedOn>

		<!---set a new price for this option based on discount--->
		<cfswitch expression="#loc.cloneOptionDescriptionAndPrice.discountType#">
			<cfcase value="percent">
				<!--- check to see if a number greater than 1 was used and convert to decimal--->
				<cfif loc.cloneOptionDescriptionAndPrice.cost GT 1>
					<cfset loc.cloneOptionDescriptionAndPrice.cost = loc.cloneOptionDescriptionAndPrice.cost/100>
				</cfif>
				<!---Calculate a new cost for this discount option --->
				<cfset loc.cloneOptionDescriptionAndPrice.cost = -1 * (loc.discountIsBasedOn.Cost * loc.cloneOptionDescriptionAndPrice.cost)>
			</cfcase>
			<cfcase value="maximum">
				<!---Calculate a new cost for this discount option --->
				<cfif loc.thisOptionDescriptionAndPrice.cost LTE loc.discountIsBasedOn.cost>
					<cfset loc.cloneOptionDescriptionAndPrice.cost = (loc.cloneOptionDescriptionAndPrice.cost - loc.discountIsBasedOn.cost)>
				</cfif>
			</cfcase>
		</cfswitch>
	</cfif>

	<cfset debug.thisOptionDescriptionAndPrice[loc.id] = loc.thisOptionDescriptionAndPrice>
	<cfset debug.cloneOptionDescriptionAndPrice[loc.id] = loc.cloneOptionDescriptionAndPrice>

	<cfreturn loc.cloneOptionDescriptionAndPrice>
</cffunction>

<cffunction name="getQualifyingOptionForDisount">
<cfargument name="thisOptionDescriptionAndPrice" required=true type="query">
<cfargument name="person" required=false type="string">
<cfset var loc = arguments>

	<cfset loc.discountDependsOn = listFirst(loc.thisOptionDescriptionAndPrice.discountDependsOn)>

	<cfloop from="1" to="#arrayLen(session.shoppingcart)#" index="loc.i">
		<cfset loc.personInShoppingCart = session.shoppingcart[loc.i].person>
		<cfloop list="#loc.thisOptionDescriptionAndPrice.discountDependsOn#" index="loc.ii">
			<cfif loc.DISCOUNTDEPENDSON is loc.ii AND loc.person is loc.PERSONINSHOPPINGCART>
				<cfset loc.idOfQualifyingOption = model("Conferenceoption").findOne(where="name='#loc.DISCOUNTDEPENDSON#' AND event='#getevent()#'").id>
				<cfset debug.loc = loc>
				<cfreturn loc.idOfQualifyingOption>
			</cfif>
		</cfloop>
	</cfloop>

	<cfreturn false>

</cffunction>

<cffunction name="fields">
	<cfset loc.fields = "fname,sname,lname,age,address,city,handbook_statesID,country,province,zip,email,phone,familyEmail,familyPhone,specialneeds,key,useContactFrom">
	<cfreturn loc.fields>
</cffunction>

<cffunction name="getNextPersonInShoppingCart">
	<cfargument name="currentperson" type="string" default="#params.currentperson#">
	<cfset nextperson = structnew()>

	<!---Get this persons first key--->
		<cfloop from="1" to="#arrayLen(session.shoppingcart)#" index="i">
			<cfif session.shoppingcart[i].person is arguments.currentperson>
				<cfset currentPersonsKey = i>
				<cfbreak>
			</cfif>
		</cfloop>
		<cfloop from="#currentpersonskey#" to="#arrayLen(session.shoppingcart)#" index="i">
			<cfif session.shoppingcart[i].person is not arguments.currentperson>
			<cfset nextPersonInShoppingCart.key = i>
			<cfset nextPersonInShoppingCart.person = session.shoppingcart[i].person>
			<cfset nextPersonInShoppingCart.previousPerson = arguments.currentperson>
			<cfset nextPersonInShoppingCart.shoppingCartLength = arrayLen(session.shoppingcart)>
			<cfbreak>
			</cfif>
			<cfif arrayLen(session.shoppingcart) is i>
			<cfset nextPersonInShoppingCart.key = 999>
			<cfset nextPersonInShoppingCart.person = "empty">
			<cfset nextPersonInShoppingCart.previousPerson = arguments.currentperson>
			<cfset nextPersonInShoppingCart.shoppingCartLength = arrayLen(session.shoppingcart)>
			<cfbreak>
			</cfif>
		</cfloop>
	<cfreturn nextPersonInShoppingCart>
</cffunction>

<cffunction name="cleanChildcareItems">
<cfset sc = session.shoppingcart>
<cfset ccoptions = model("Conferenceoption").findAllByType("ChildCare")>
<cfset ccoptionIds = valuelist(ccoptions.id)>
<cfset options = model("Conferenceoption").findAllByType("ChildCareOptions")>
<cfset optionIds = valuelist(options.id)>
<cfloop from="1" to="#arraylen(session.shoppingcart)#" index="i">
	<cfif listfind(ccoptionIds,sc[i].item)>
		<cftry>
		<cfloop from="1" to="#arraylen(session.shoppingcart)#" index="ii">
			<cfif listfind(optionIds,sc[ii].item)>
				<cfset arrayDeleteAt(session.shoppingcart,ii)>
			</cfif>
		</cfloop>
		<cfcatch></cfcatch></cftry>
	<cfbreak>
	</cfif>
</cfloop>
</cffunction>

<cffunction name="getPersonFromId">
<cfargument name="id" required="true" type="numeric">
	<cfset personName = model("Conferenceperson").findAll(where="id=#arguments.id#", include="family").fullname>
<cfreturn personName>
</cffunction>





<!---Methods used to add options to an existing Reg--->
<cffunction name="startFamilyRegs">
	<cftry>
	<cfset arrayclear(session.shoppingcart)>
	<cfset clearRegtype()>
	<cfcatch></cfcatch></cftry>
	<cftry>
	<cfset structDelete(session,"registrationcart")>
	<cfcatch></cfcatch></cftry>
	<cfset redirectTo(action="showFamilyRegs", key=params.key)>
</cffunction>




<!---/conference.register/showFamilyRegs--->
<cffunction name="showFamilyRegs">

	<cfif application.wheels.registrationIsOpen is false and gotrights("office") is false>
		<cfset redirectTo(action="welcome")>
	</cfif>

   	<cfset family = model("Conferencefamily").findAll(where="id=#params.key#", include="person(registration(option)),state")>
	<cfset cart = showcart()>
	<cfset cartformaction = "checkOutAddedOptions">
</cffunction>

<cffunction name="checkOutAddedOptions">
<cfset session.registrationcart = structnew()>

	<cfloop from="1" to="#arraylen(session.shoppingcart)#" index="i">
		<cfset session.shoppingcart[i].equip_peopleid = session.shoppingcart[i].person>
	</cfloop>

	<cfset thisinvoiceid = createEmptyInvoice()>
	<cfset session.registrationcart.invoiceid = thisinvoiceid>
	<cfset postShoppingCart()>

	<cfset sendemail(from="tomavey@fgbc.org", to=getSetting('registraremail'), cc=getSetting('errorEmailAddress'), template="emailbeforepayment", subject="#getEventAsTextA()# Registration has been started", layout="layout_for_email")>

	<cfset redirectTo(action="getAgent")>

</cffunction>





<!---/conference.register/addoptions--->
<cffunction name="addoptions">
	<cfset formaction = "cartAddedOptions">
	<cfset submitvalue = "Add these options">
	<cfset meals = model("Conferenceoption").findAllOptions("meal")>
	<cfset registrations = model("Conferenceoption").findall(where="type in (#typeOfAddRegOptions()#) AND event='#getevent()#'", order="sortorder")>
	<cfset options = model("Conferenceoption").findall(where="type in ('other','excursion') AND event='#getevent()#'", order="sortorder")>
	<cfset childCare = model("Conferenceoption").findall(where="type='ChildCareOptions' AND event='#getevent()#'", order="sortorder")>
	<cfset KidsKonference = model("Conferenceoption").findall(where="type='KidsKonferenceOptions' AND event='#getevent()#'", order="sortorder")>
	<cfset preconference = model("Conferenceoption").findall(where="type='preconference' AND event='#getevent()#'", order="sortorder")>
	<cfset thisperson = model("Conferenceperson").findOne(where="id=#params.key#", include="family")>
	<cfset params.regtitle = "Add registration options for #thisperson.fullname#">
	<cfset params.mealstitle = "Add meal options for #thisperson.fullname#">
	<cfset params.childcareTitle = "Add childcare options for #thisperson.fullname#">
	<cfset params.kidskonferenceTitle = "Add kids konference options for #thisperson.fullname#">
	<cfset params.preconferenceTitle = "Add pre-conference options for #thisperson.fullname#">
</cffunction>

<!---Process addoptions form--->
<cffunction name="cartAddedOptions">

	<cfset checkForSelections = putFormIntoShoppingCart()>

	<cfif checkForSelections is 0>
		<cfset flashInsert(message= "Please select at least one registration item for #params.person#.")>
		<cfset flashInsert(person = params.person)>
	<cfelse>
		<cfset flashInsert(message= "Enter the first name and selections for the next person you are registering.<br/> Press the checkout button when you are finished.")>
	</cfif>

	<cfif isdefined("params.return")>
		<cfset redirectTo(action=params.return)>
	<cfelse>
		<cfset redirectTo(controller="conference.register", action="showFamilyRegs", key=params.familyid)>
	</cfif>

</cffunction>






<cffunction name="addOneOption" access="private" hint="used to add a single specific item to a the cart">
<cfargument name="peopleid" required="true">
<cfargument name="optionid" required="true">
<cfargument name="invoiceid" required="true">
<cfargument name="quantity" default=1>
<cfargument name="maxInInvoice" default=1>
	<cfset checkcount = model("Conferenceregistration").findAll(where="equip_peopleId = #arguments.peopleid# AND equip_optionsId = #arguments.optionid# AND equip_invoicesId = #arguments.invoiceid#").recordcount>
	<cfif checkcount LT arguments.maxInInvoice>
		<cfset optionCost = model("Conferenceoption").findOne(where="id=#arguments.optionid#")>
		<cfset reg = model("Conferenceregistration").new()>
		<cfset reg.equip_peopleId = arguments.peopleid>
		<cfset reg.equip_optionsId = arguments.optionid>
		<cfset reg.equip_invoicesId = arguments.invoiceid>
		<cfset reg.quantity = arguments.quantity>
		<cfset reg.cost = optionCost.cost>
		<cfset results = reg.save()>
	<cfelse>
		<cfset results = false>
	</cfif>
	<cfreturn results>
</cffunction>








<!---Used for Phil Wickham concert in 2011, saved only as an example--->
<cffunction name="addSingleConcertTicket">
	<cfset addOneOption(peopleid=params.peopleid, invoiceid=params.invoiceid, optionid=88)>
	<cfif results>
		<cfset renderPage(template="addedconcert")>
	<cfelse>
		<cfset renderPage(template="alreadyhaveticket")>
	</cfif>
</cffunction>

<!---Used for Phil Wickham concert in 2011, saved only as an example--->
<cffunction name="addCoupleConcertTicket">
	<cfset addOneOption(peopleid=params.peopleid, invoiceid=params.invoiceid, optionid=88, quantity=2)>
	<cfif results>
		<cfset renderPage(template="addedconcert")>
	<cfelse>
		<cfset renderPage(template="alreadyhaveticket")>
	</cfif>
</cffunction>


<!---testing methods--->

<cffunction name="testDataInShoppingCart">
	<cfscript>
		addToCart(item=14,quantity=1,person="Tom and Sandi");
		addToCart(item=29,quantity=2,person="Tom and Sandi");
		addToCart(item=40,quantity=1,person="Tobi");
		addToCart(item=40,quantity=1,person="Trey");
		addToCart(item=15,quantity=1,person="Simon");
	</cfscript>
	<cfset redirectTo(action="selectoptions")>

</cffunction>

<cffunction name="testDataInRegistrationCart">
	<cfif not structKeyExists(session,"registrationcart")>
		<cfset session.registrationCart = structNew()>
	</cfif>
		<cfset session.registrationCart["Tom and Sandi"] = structNew()>
		<cfset session.registrationCart["Tom and Sandi"].lname = "Avey#second(now())#">
		<cfset session.registrationCart["Tom and Sandi"].email = "tomonline2@fgbc.org">
		<cfset session.registrationCart["Tom and Sandi"].familyemail = "tomonline2@fgbc.org">
		<cfset session.registrationCart["Tom and Sandi"].fname = "Tom#second(now())#">
		<cfset session.registrationCart["Tom and Sandi"].sname = "Sandi#second(now())#">
		<cfset session.registrationCart["Tom and Sandi"].address = "100 4th Street">
		<cfset session.registrationCart["Tom and Sandi"].city = "Winona Lake">
		<cfset session.registrationCart["Tom and Sandi"].province = "">
		<cfset session.registrationCart["Tom and Sandi"].country = "">
		<cfset session.registrationCart["Tom and Sandi"].zip = "46590">
		<cfset session.registrationCart["Tom and Sandi"].handbook_statesid = 15>
		<cfset session.registrationCart["Tom and Sandi"].age = "50-60">
		<cfset session.registrationCart["Tom and Sandi"].type = "Adult">
		<cfset session.registrationCart["Tom and Sandi"].phone = "574-527-6061">
		<cfset session.registrationCart["Tom and Sandi"].familyphone = "574-527-6061">
		<cfset session.registrationCart["Tom and Sandi"].usecontactfrom = "">
		<cfset session.registrationCart["Tom and Sandi"].specialneeds = "">
		<cfset session.registrationCart["Tobi"] = structNew()>
		<cfset session.registrationCart["Tobi"].fname = "Tobi#second(now())#">
		<cfset session.registrationCart["Tobi"].usecontactfrom = "Tom and Sandi">
		<cfset session.registrationCart["Tobi"].type = "KK">
		<cfset session.registrationCart["Tobi"].age = "">
		<cfset session.registrationCart["Tobi"].email = "">
		<cfset session.registrationCart["Tobi"].phone = "">
		<cfset session.registrationCart["Tobi"].sname = "">
		<cfset session.registrationCart["Tobi"].lname = "">
		<cfset session.registrationCart["Trey"] = structNew()>
		<cfset session.registrationCart["Trey"].fname = "Trey#second(now())#">
		<cfset session.registrationCart["Trey"].usecontactfrom = "Tom and Sandi">
		<cfset session.registrationCart["Trey"].type = "KK">
		<cfset session.registrationCart["Trey"].age = "">
		<cfset session.registrationCart["Trey"].email = "">
		<cfset session.registrationCart["Trey"].phone = "">
		<cfset session.registrationCart["Trey"].sname = "">
		<cfset session.registrationCart["Trey"].lname = "">
		<cfset session.registrationCart["Simon"] = structNew()>
		<cfset session.registrationCart["Simon"].fname = "Simon#second(now())#">
		<cfset session.registrationCart["Simon"].usecontactfrom = "Tom and Sandi">
		<cfset session.registrationCart["Simon"].type = "CC">
		<cfset session.registrationCart["Simon"].age = "">
		<cfset session.registrationCart["Simon"].email = "">
		<cfset session.registrationCart["Simon"].phone = "">
		<cfset session.registrationCart["Simon"].sname = "">
		<cfset session.registrationCart["Simon"].lname = "">

	<cfset redirectTo(action="showregs")>

</cffunction>

<cffunction name="getLname">
<cfset var loc = structnew()>
<cfset loc.return = "">
	<cfif structKeyExists(session,"registrationcart")>
		<cfloop list="#structKeyList(session.registrationcart)#" index="i">
			<cftry>
			<cfif structKeyExists(session.registrationcart[i],"lname")>
				<cfset loc.return = session.registrationcart[i].lname>
				<cfbreak>
			</cfif>
			<cfcatch></cfcatch></cftry>
		</cfloop>
	</cfif>
	<cfreturn loc.return>
</cffunction>

<cffunction name="regType">
<cfset var loc=structNew()>
<cfset loc.return = false>

	<cfif isDefined("params.regtype")>
		<cfset loc.return = params.regtype>
	<cfelseif isDefined("params.couple")>
		<cfset loc.return = "couple">
	<cfelseif isDefined("params.single")>
		<cfset loc.return = "single">
	<cfelseif isDefined("params.group")>
		<cfset loc.return = "group">
	<cfelseif isDefined("params.family")>
		<cfset loc.return= "family">
	<cfelseif isDefined("params.children")>
		<cfset loc.return= "children">
	<cfelseif isDefined("params.meals")>
		<cfset loc.return= "meal">
	<cfelseif isDefined("params.meal")>
		<cfset loc.return= "meal">
	<cfelseif isDefined("params.options")>
		<cfset loc.return= "options">
	<cfelseif isDefined("params.preRegistration")>
		<cfset loc.return= "preRegistration">
	<cfelseif isDefined("session.registration.regtype")>
		<cfset loc.return = session.registration.regtype>
	</cfif>
	<cfset session.registration.regtype = loc.return>

<cfreturn loc.return>
</cffunction>

<cffunction name="clearRegType">
	<cfset structDelete(session.registration, "regtype")>
</cffunction>

<cffunction name="isRegType">
<cfargument name="name" required="true" type="string">
<cfset var loc = arguments>
<cfreturn loc.name IS regType(loc.name)>
</cffunction>

<cffunction name = "optionRegType">
<cfargument name="optionid" required="true" type="number">
<cfset var loc = arguments>
	<cfset loc.option = model("Conferenceoption").findOne(where="id=#loc.optionid#")>
	<cfif IsObject(loc.option)>
		<cfreturn loc.option.type>
	<cfelse>
		<cfreturn "none">
	</cfif>		
</cffunction>

<cffunction name="isOptionRegtype">
<cfargument name="optionid" required="true" type="number">
<cfargument name="type" required="true" type="string">
<cfset var loc = arguments>
	<cfif optionRegType(loc.optionid) is loc.type>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>		
</cffunction>

<cffunction name="isOptionRegTypeGroup">
<cfargument name="optionid" required="true" type="number">
<cfset var loc = arguments>
<cfif isDefined("session.registration.regType") && session.registration.regType is "groupToSingle">
	<cfreturn true>
</cfif>
<cfset loc.check = isoptionRegType(loc.optionid,"Registration-group")>
<cfreturn loc.check>
</cffunction>

<cffunction name="getSingleRegOptionId">
<cfset var loc=structNew()>
	<cfset loc.singleReg = model("Conferenceoption").findAll(where="type='Registration-Single' AND event='#getevent()#'", order="cost DESC")>
<cfreturn loc.singleReg.id[1]>
</cffunction>

<cffunction name="GroupRegConvertToSingle">
<cfargument name="singleOptionid" default="#getSingleRegOptionId()#">
<cfargument name="quantity" default="1">
<cfargument name="cost" default="75">
<cfset var loc = arguments>

	<cfif isDefined("params.fname")>
		<cfset loc.person = params.fname>
	<cfelse>
		<cfset renderText("oops - need a persons first name")>	
	</cfif>
	<cfif isDefined("params.groupRegId")>
		<cfset loc.groupRegId = params.groupRegId>
	<cfelse>
		<cfset renderText("oops - need a Registration Id for this Group")>	
	</cfif>

	<cfset session.registration.regtype="groupToSingle">

		<cfscript>
			structDelete(session,"shoppingCart");
			structDelete(session,"registrationCart");
			createEmptyShoppingCart();
			session.shoppingCart[1] = structNew();
			session.registrationCart[params.fname] = structnew();
			loc.sc = session.shoppingcart[1];
			loc.rc = session.registrationcart[params.fname];

			loc.sc.GROUPREGID = loc.groupRegId;
			loc.sc.cost = loc.cost;
			loc.sc.item = loc.singleOptionid;
			loc.sc.name = loc.person;
			loc.sc.quantity = 1;
			loc.sc.person = loc.person;

			loc.rc.age = params.age;
			loc.rc.email = params.email;
			loc.rc.fname = params.fname;
			loc.rc.lname = params.lname;
			loc.rc.phone = params.phone;
			loc.rc.gender = params.gender;
			loc.rc.key = 1;
			loc.rc.thisperson = params.fname;
			loc.rc.type = "Adult";
			loc.rc.useContactFrom = "";
			loc.rc.address = "";
			loc.rc.city = "";
			loc.rc.handbook_statesid = 0;
			loc.rc.province = "";
			loc.rc.familyemail = params.email;
			loc.rc.familyphone = params.phone;
			loc.rc.country = "";
			loc.rc.specialneeds = "";
			loc.rc.sname = "";
			

		</cfscript>

		<cfset redirectTo(controller="conference.register", action="postCarts")>

<!---I don't think this is used
		<cfset redirectTo(controller="conference.register", action="createCartItemsFromForm", params="#loc.singleOptionid#=#loc.quantity#&person=#loc.person#&cost=#loc.cost#&groupRegId=#loc.groupRegId#")>
--->
</cffunction>

<cffunction name="remove1RegFromGroup">
<cfargument name="groupRegId" required="true" type="numeric">
<cfset var loc = arguments>
	<cfset loc.groupReg = model("Conferenceregistration").findOne(where="id=#loc.groupRegId#")>

	<cfif loc.groupReg.quantity GTE 1>
		<cfset loc.groupReg.quantity = loc.groupReg.quantity - 1>
		<cfif loc.groupReg.save()>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>	
	<cfelse>
			<cfreturn false>
	</cfif>	 

</cffunction>

<cffunction name="usingGroupReg">
	<cfif isDefined("session.shoppingcart[1].groupRegId") && session.shoppingcart[1].groupRegId>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>	
</cffunction>

<cffunction name="usingStaffReg">
	<cfset var loc = structNew()>

	<cftry>
		<cfset loc.item = session.shoppingcart[1].item>
	<cfcatch>
		<cfreturn false>
	</cfcatch>
	</cftry>		

	<cfset loc.option = model("Conferenceoption").findOne(where="id=#loc.item#")>
	<cfif isObject(loc.option)>
		<cfset loc.itemType = loc.option.type>
		<cfif loc.itemType is "Registration-Staff">
			<cfreturn true>
		</cfif>	
	<cfelse>
		<cfreturn false>
	</cfif>
	<cfreturn false>
</cffunction>

</cfcomponent>




