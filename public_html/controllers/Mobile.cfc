<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("layout")>
	</cffunction>

	<cffunction name="index">
		<cfset setReturn()>
		<cfset announcements = model("Mainannouncement").findall(where="startAt <= now() AND endAt > now() AND onhold = 'N'", order="startAt desc", maxRows=3)>
    	<cfset ministry = model("Mainministry").findAll(order="category,name")>	
		<cfset churches = model("Handbookorganization").findAll(where=" statusid in ('1,4,8,9')", include="Handbookstate", order="state,org_city,name")>
		<cfset menuoptions = model("Mainmenu").FindAllGotRightsTo()>
		<cfset dataajax = "true">
	</cffunction>

	<cffunction name="churches">
		<cfset churches = model("Handbookorganization").findAll(where="(name like '%#params.search#%' OR state like '%#params.search#%' OR org_city like '%#params.search#%') AND statusid in (1,8)", include="Handbookstate", order="state,org_city,name")>
		<cfset dataajax = "false">
	</cffunction>

	<cffunction name="opportunities">
		<cfset setReturn()>
		<cfset job = model("Mainjob").findAll(where="expirationdate > now() AND approved='Y'", order="id desc")>
		<cfset dataajax = "false">
	</cffunction>

	<cffunction name="login">
		<cfset dataajax = "true">
	</cffunction>

	<cffunction name="news">
		<cfset dataajax = "true">
	</cffunction>

	<cffunction name="more">
		<cfset setReturn()>
		<cfset menuoptions = model("Mainmenu").FindAllGotRightsTo()>
	</cffunction>

</cfcomponent>