//TODO - Convert to cfscript
<cfcomponent output="false" extends="Controller">

	<cffunction name="config">
		<cfset usesLayout(template="/handbook/layout_handbook2")>
		<cfset filters(through="setReturn", only="show,index")>
		<cfset filters(through="getDistrict", only="edit,show")>
		<!--- <cfset filters(through="checkSessionAuthEmail", except="setSessionAuthEmail")> --->
		<cfset filters(through="getDistricts", only="index,report")>
		<cfset filters(through="getAgbmRegions", only="new,edit")>
	</cffunction>

	<cffunction name="getDistrict">
		<cfset district = model("Handbookdistrict").findOne(where="districtid=#params.key#")>
		<cfif isDefined("district.agbmregionid") and val(district.agbmregionid)>
		<cfset agbmregion = model("Handbookagbmregion").findOne(where="id=#district.agbmregionid#")>
		</cfif>
	</cffunction>
	
	<cffunction name="getAgbmRegions">
		<cfset district = model("Handbookagbmregion").findAll()>
	</cffunction>

	<cffunction name="checkSessionAuthEmail">
    	<cfif isDefined("session.auth.email") and isValid("email",session.auth.email)>
		    <cfreturn true>
    	<cfelse>
    		<cfset renderView(action="getemail")>
    	</cfif>
	</cffunction>
	
	<cffunction name="setSessionAuthEmail">
    	<cfif isValid("email", params.email)>
        	<cfset session.auth.email = params.email>
        	<cfset returnBack()>
    	<cfelse>
		   	<cfset renderView(action="getemail")>
    	</cfif>
	</cffunction>

	<cffunction name="getDistricts">
		<cfif isDefined("params.sortby")>
			<cfset orderString = params.sortby>
		<cfelse>
			<cfset orderString = "district">
		</cfif>
		<cfset districts = model("Handbookdistrict").findAll(where="district <> 'Empty' AND district <> 'National Ministry' AND district <> 'Cooperating Ministry' AND district <> 'NO DISTRICT'", order=orderString, include="agbmregion")>
	</cffunction>

	<cffunction name="listChurches">
		<cfset orderString = "district, state, org_city">
		<cfset districts = model("Handbookdistrict").findAll(where="district <> 'Empty' AND district <> 'National Ministry' AND district <> 'Cooperating Ministry' AND district <> 'NO DISTRICT' AND statusid in (1,8)", order=orderString, include="organizations(state)")>
	</cffunction>
	
	<cffunction name="edit">
		<cfset district = model("Handbookdistrict").findOne(where="districtid=#params.key#")>			
		<cfset agbmregions = model("Handbookagbmregion").findAll()>
		
		<cfif not isDefined("params.email") and not isDefined("session.auth.email")>
			  <cfset reDirectTo(action="getemail", key=params.key)>
		<cfelseif isDefined("params.email")>
			  <cfset district.updatedBy=params.email>
		<cfelseif isDefined("session.auth.email")>
			  <cfset district.updatedBy=session.auth.email>
		</cfif>
	</cffunction>
	
	<cffunction name="new">
		<cfset district = model("Handbookdistrict").new()>
		<cfset district.createdBy = session.auth.email>
		<cfset formaction = "create">
	</cffunction>
	
	<cffunction name="update">
		<cfset district = model("Handbookdistrict").findOne(where="districtid=#params.district.districtid#")>
		<cfif district.update(params.district)>
			<cfset flashInsert(success="The district was updated successfully.")>	
			<cfset returnBack()>
		<cfelse>
			<cfset flashInsert(success="Something went wrong.")>	
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<cffunction name="create">
		<cfset district = model("Handbookdistrict").new(params.district)>
		<cfif district.save()>
			<cfset reDirectTo(action="index")>
		<cfelse>
			<cfset renderView(action="new")>
		</cfif>	  
	</cffunction>

	<cffunction name="setReview">
	<cfargument name="districtId" default="#params.key#">
	<cfset var loc = structNew()>
    	<cfset loc.district = model("Handbookdistrict").findOne(where="districtid=#arguments.districtid#")>
    	<cfset loc.district.reviewedAt = now()>
    	<cfset loc.district.reviewedBy = session.auth.email>
    	<cfset test = loc.district.update()>
		<cfset returnBack()>
	</cffunction>

	<cffunction name="handbookreport">
		<cfset districts = model("Handbookdistrict").findAll(include="organizations(state)", where="statusid IN (1,4,8,9) AND district NOT IN 'No District,Empty'", order="district,state,org_city")>
	</cffunction>


</cfcomponent>