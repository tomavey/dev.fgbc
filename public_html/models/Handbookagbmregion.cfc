//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset hasMany(name="Handbookdistrict", foreignKey="agbmregionid")>
		<cfset belongsTo(name="agbmrep", modelName="Handbookperson", foreignKey="agbmrepid")>
	</cffunction>

	<cffunction name="agbmregionsasjson">
		<cfset var agbmregions = findAll(order="name")>
		<cfset agbmregions = queryToJson(agbmregions)>
		<cfreturn agbmregions>
	</cffunction>

	<cffunction name="agbmregionasjson">
	<cfargument name="regionid" required="true" type="numeric">
	<cfargument name="currentmembershipyear" required="false">
	<cfif not isDefined('arguments.currentmembershipyear')>
		<cfset currentmembershipyear = model("Handbookperson").currentMembershipYear()>
	</cfif>
		<cfquery datasource="#application.wheels.datasourcename#" name="data">
			SELECT pe.fname,pe.lname,pe.id,concat(rep.fname,' ',rep.lname) as repName,rep.id as repId,o.name,o.org_city,max(membershipfeeyear) as lastpayment
			FROM handbookagbmregions a
			JOIN handbookpeople rep
			ON a.agbmrepid = rep.id
			JOIN handbookdistricts d
			ON d.agbmregionid = a.id
			JOIN handbookorganizations o
			ON o.districtid = d.districtid
			JOIN handbookpositions p
			ON p.organizationid = o.id
			JOIN handbookpeople = pe
			ON p.personid = pe.id
			JOIN handbookagbminfo i
			ON pe.id = i.personid
			WHERE a.id=#arguments.regionid#
			GROUP BY p.id
			ORDER BY pe.lname,pe.fname
		</cfquery>		
		<cfquery dbType="query" name="data">
			SELECT *
			FROM data
			WHERE lastpayment='#val(arguments.currentMembershipyear)#'
		</cfquery>
		<cfset data = queryToJson(data)>
		<cfreturn data>
	</cffunction>

	<cffunction name="getRep">
	<cfargument name="regionId" required="true" type="numeric">
		<cfset var data = findAll(where="id=#arguments.regionid#", include="agbmrep(Handbookstate)")>
		<cfset data = queryToJson(data)>
		<cfreturn data>
	</cffunction>

</cfcomponent>
