//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
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

	<cffunction name="findLastAttYear">
		<cfargument name='churchid' required="true" type="numeric">
		<cfset var loc = structNew()>
			<cfset loc.statistic = findAll(where="organizationid = #churchid#", order="updatedAt DESC")>
			<cfif loc.statistic.recordcount>
				<cfreturn loc.statistic.year>
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

	<cffunction name="findStatsSummary">
	<cfargument name="year" required="true" type="numeric">
	<cfset var loc = structNew()>
		<cfquery datasource='#getDatasource()#' name="loc.data">
			SELECT sum(att) as sumAtt, avg(att) as avgAtt, sum(ss) as sumSs, avg(ss) as avgSs, sum(conversions) as sumConversions, avg(conversions) as avgConversions, sum(baptisms) as sumBaptisms, avg(baptisms) as avgBaptisms, sum(members) as sumMembers, avg(members) as avgMembers, sum(triune) as sumTriune, avg(triune) as avgTriune
			FROM handbookstatistics s
			WHERE
				s.year = '#arguments.year#'
			AND 
				s.deletedAt IS NULL
		</cfquery>

	<cfreturn loc.data>		

	</cffunction>



</cfcomponent>