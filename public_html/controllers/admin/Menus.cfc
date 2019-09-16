<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="index,edit")>
	</cffunction>
	
	<!--- menus/index --->
	<cffunction name="index">
		<cfset menus=model("Mainmenu").findAll(order="category,name")>
	</cffunction>
	
	<!--- menus/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset menu = model("Mainmenu").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(menu)>
	        <cfset flashInsert(error="Menu #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- menus/new --->
	<cffunction name="new">
		<cfset menu = model("Mainmenu").new()>
	</cffunction>
	
	<!--- menus/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset menu = model("Mainmenu").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(menu)>
	        <cfset flashInsert(error="Menu #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- menus/create --->
	<cffunction name="create">
		<cfset menu = model("Mainmenu").new(params.menu)>
		
		<!--- Verify that the menu creates successfully --->
		<cfif menu.save()>
			<cfset flashInsert(success="The menu was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the menu.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- menus/update --->
	<cffunction name="update">
		<cfset menu = model("Mainmenu").findByKey(params.key)>
		
		<!--- Verify that the menu updates successfully --->
		<cfif menu.update(params.menu)>
			<cfset flashInsert(success="The menu was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the menu.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- menus/delete/key --->
	<cffunction name="delete">
		<cfset menu = model("Mainmenu").findByKey(params.key)>
		
		<!--- Verify that the menu deletes successfully --->
		<cfif menu.delete()>
			<cfset flashInsert(success="The menu was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the menu.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
	<cffunction name="moveUp">
	<cfargument name="category" default="office">	
		<cfset menus= model('menu').findall(where="category = '#arguments.category#'", order="category,sortorder,name")>
		<cfoutput query="menus">
			<cfset menu = model('menu').findOne(menus.id)>
			<cfset menu.sortorder = menus.currentRow>
			<cfset menu.update(sortorder=menus.currentRow)>
		</cfoutput>
	<cfset redirectTo(controller="menus", action="index")>
	</cffunction>

	<cffunction name="fellowshipCouncil">
		<cflocation url="http://www.charisfellowship.us/fc?code=fellowshipcouncil&email=#session.auth.email#">
	</cffunction>
	
	<cffunction name="fellowshipCouncilDev">
		<cflocation url="http://www.charisfellowship.us/fc?code=fellowshipcouncil&email=#session.auth.email#">
	</cffunction>

	<cffunction name="handbookadmin">
		<cfset unlockKey = getKey(session.auth.email)>
		<cflocation url="http://www.charisfellowship.us/handbook/adm?key=#unlockKey#">
	</cffunction>

	<cffunction name="handbookadmiDev">
		<cfset unlockKey = getKey(session.auth.email)>
		<cflocation url="http://www.charisfellowship.us/handbook/adm?key=#unlockKey#">
	</cffunction>
	<cffunction name="myfgbc">
		<cfset unlockKey = getKey(session.auth.email)>
		<cflocation url="http://my.charisfellowship.us/data?key=#unlockKey#">
	</cffunction>

	<cffunction name="myfgbc">
		<cflocation url="http://www.charisfellowship.us/data?unlock=charis">
	</cffunction>

</cfcomponent>
