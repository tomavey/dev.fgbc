<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table(name="handbookstatistics")>
		<cfset belongsTo(name="Handbookorganization", foreignKey="organizationId")>
		<cfset property(name="attInt", sql='convert(att,Decimal)')>
	</cffunction>

	<cffunction name="findLastAtt">
	<cfargument name='churchid' required="true" type="numeric">
	<cfset var loc = structNew()>
		<cfset loc.statistic = findAll(where="organizationid = #churchid#", order="updatedAt DESC")>
		<cfif loc.statistic.recordcount>
			<cfreturn loc.statistic.att>
		<cfelse>
			<cfreturn "NA">
		</cfif>
	</cffunction>

	<cffunction name="getNow">
	<cfset var loc = structNew()>
	<cfset loc.return = dateAdd("yyyy",-1,now())>	
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="findMemFeePaidBy">
	<cfargument name="yearsago" default=-1>
	<cfargument name="today" default="#getNow()#">
	<cfargument name="statyear" default="#year(getNow())#">
	<cfset var loc=structNew()>
	<cfset loc.oneYearAgo = dateAdd("yyyy",arguments.yearsago,arguments.today)>
	<cfset loc.statyear = arguments.statyear+(arguments.yearsago-1)>
	<cfset loc.selectString = "count(year) as counta, sum(memfee) as summemfee">
	<cfset loc.whereString = "year=#loc.statyear# AND createdAt <= '#loc.oneYearAgo#'">


	<cfquery datasource="#getDatasource()#" name="loc.count">
		SELECT count(year) as counta, sum(memfee) as summemfee
		FROM handbookstatistics s
		WHERE
			(
				s.year = '#loc.statyear#'
				AND s.createdAt <= #loc.oneYearAgo#
			) 
		AND 
			(
				s.deletedAt IS NULL
			)
	</cfquery>

	<cfset loc.return.countmemfee = loc.count.counta>
	<cfset loc.return.summemfee = loc.count.summemfee>

	<cfreturn loc.return>

	</cffunction>

</cfcomponent>