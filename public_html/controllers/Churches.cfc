<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="checkOffice", except="index,getAddressesForMap,test")>
		<cfset filters(through="setReturn", only="index")>
		<cfset provides("html,json")>
	</cffunction>

	<cffunction name="index">
		<cfif isdefined("params.state")>
			<cfset churches = model("Handbookorganization").findAll(where="state='#params.state#' AND statusid in (1,8,4,2)", include="Handbookstate", order="state,org_city,name")>
		<cfelse>
			<cfset churches = model("Handbookorganization").findAll(where="statusid in (1,8,4,2)", include="Handbookstate", order="state,org_city,name")>
		</cfif>
		<cfset churchesjson = queryToJson(churches)>

		<cfset churchStates = model("Handbookorganization").findAll(where="statusid IN (1,4,8,9)", order="state", distinct=true, select="state", include="Handbookstate")>
		<cfset churchStatesJson = queryToJson(churchStates)>

	</cffunction>

	<cffunction name="list">
		<cfset redirectTo(action="index")>
	</cffunction>

	<!--- churches/show/key --->
	<cffunction name="show">

			<!--- Find the record --->
	    	<cfset church = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate")>

	    	<!--- Check if the record exists --->
		    <cfif NOT IsObject(church)>
		        <cfset flashInsert(error="church #params.key# was not found")>
		        <cfset redirectTo(action="index")>
		    </cfif>

	</cffunction>

	<cffunction name="getAddressesForMap">
		<!--- parse the search string (city, state, zip) --->
		<!---
			POSSIBLE FORMATS:	sunnyside, wa 98944
								sunnyside, wa
								sunnyside
								98944
								sunnyside, washington
								washington
		--->
		<cfif isDefined("params.searchText")>

			<!--- remove extra spaces --->
			<cfset params.searchText = reReplace(params.searchText, "/\s{2,}/g", " ")>

			<!--- find zip first, if exists --->
			<cfloop index="j" list="#params.searchText#" delimiters="#chr(32)#">
		        <cfif REFIND("^[0-9]{5}(|,)$",j,0)>
		        	<cfset j = ReReplace(j,",","","ALL")>
		            <cfset whereClause = "zip = '#Mid(j,1,len(j))#'">
		        </cfif>
		    </cfloop>
		    <!--- if zip not found, see if state exists --->
		    <cfif not isDefined("whereClause")>
		    	<cfset whereClause = "">

		    	<cfset city = "">
		    	<cfloop index="i" list="#params.searchText#" delimiters="#chr(32)#">
		    		<cfset i = REReplace(i,",","","ALL")>
		    		<cfif REFIND("\b[a-z,A-Z]{2}\b",i,0)>
		    			<cfset state = "#Mid(i,1,len(i))#">
		    		<cfelse>
		    			<cfif not find(params.searchText, ",")>
		    				<cfset state = params.searchText>
		    			<cfelse>
		    				<cfif len(city)>
			    				<cfset city &= ' #i#'>
			    			<cfelse>
			    				<cfset city &= '#i#'>
			    			</cfif>
		    			</cfif>
		    		</cfif>
		    	</cfloop>

		    	<cfif isDefined("state")>
		    		<cfset whereClause = "state = '#state#' OR state_mail_abbrev='#state#'">
		    	</cfif>
		    	<cfif city neq '' and isDefined("state")>
		    		<cfset whereClause &= " AND org_city = '#city#'">
		    	<cfelseif city neq ''>
		    		<cfset whereClause &= "org_city = '#city#'">
		    	</cfif>
		    </cfif>
		    <cfif not isDefined("whereClause")>
		    	<cfset whereClause = "state != ' '">
		    </cfif>
		<cfelse>
			<cfif not isDefined("params.state")>
				<cfset whereClause = "state != ' '">
			<cfelse>
				<cfset whereClause = "state='#params.state#' OR state_mail_abbrev = '#params.state#'">
			</cfif>
		</cfif>

		<cfset whereClause = "statusid in (1,4,8,9,2) AND " & whereClause>

		<!--- get the addresses --->
		<cfset qAddress = model("Handbookorganization").findAll(include="Handbookstate", order="state", where=whereClause)>
		<!--- prepare message for request --->
		<cfset addresses = []>
		<cfloop query="qAddress">
			<cfif address1 eq ''>
				<cfset addy = address2>
			<cfelseif address2 eq ''>
				<cfset addy = address1>
			<cfelse>
				<cfset addy = "#address1#, #address2#">
			</cfif>
			<cfset arrayAppend(addresses, {long=longitude,lat=latitude,id=id,name=name,address=addy,location="#org_city#, #state# #zip#", website=website, fax=fax, phone=phone, meeting=meetingPlace})>
		</cfloop>

		<!--- respond to request with json --->
		<cfset renderWith(addresses)>
	</cffunction>

</cfcomponent>
