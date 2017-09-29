<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("handbookupdates")>
		<cfset belongsTo(name="Handbookperson", modelName="handbookPerson", foreignKey="recordId")>
		<cfset belongsTo(name="Handbookorganization", foreignKey="recordId")>
            <cfset belongsTo(name="Handbookposition", foreignKey="recordId")>
	</cffunction>

       <cffunction name="findUpdates" hint="I am called by findPeopleUpdates and findOrganizationUpdates" access="private">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>
            <cfparam name="args.showperson" default=0>
            <cfparam name="args.showmaxrows" default=10000000>
            <cfparam name="args.page" default=0>
            <cfparam name="args.perpage" default=50>
            <cfparam name="args.whereString" default="">
            <cfparam name="args.modelName" default="">
            <cfparam name="args.includeString" default="">
            <cfparam name="args.yesterday" default='#dateformat(dateAdd("d",-1,now()),"yyyy-mm-dd")#'>
            <cfparam name="args.today" default='#dateformat(dateAdd("d",0,now()),"yyyy-mm-dd")#'>
            <cfparam name="showperson" default=0>

            <!--- args that are needed = showmaxrows,page,perpage,whereString,modelName,showOnlyYesterday,yesterday,today,includeString,showperson--->

            <cfif isDefined("args.showmaxrows")>
              <cfset args.perpage = args.showmaxrows>
            </cfif>

            <cfif !isDefined("args.page")>
              <cfset args.page = 0>
            </cfif>

                    <!---Build the where string and args used in the view for certain conditions--->
                    <!--------------------------------------------------------------------------------------------------->

                    <cfset  args.whereString = "modelName='#args.modelName#' AND columnName <> 'reviewedAt' AND columnName <> 'updatedBy' AND columnName <> 'reviewedBy'">

                    <cfif args.showperson>
                          <cfset args.whereString = args.whereString & " AND recordId = #args.showperson#">
                          <!---I don't think this is needed
                          <cfset args.showorganizationupdates = false>
                          <cfset args.showdeletes = false>
                          --->
                    </cfif>

                    <cfif args.showOnlyYesterday>
                        <cfset args.whereString = args.whereString & " AND handbookupdates.createdAt like '#args.yesterday#%'">
                    </cfif>

                    <cfif args.showOnlyToday>
                        <cfset args.whereString = args.whereString & " AND handbookupdates.createdAt like '#args.today#%'">
                    </cfif>

                    <cfif args.modelName is "HandbookPerson">
                      <cfset args.modelName = "Handbookperson">
                    </cfif>

                    <cfif args.modelName is "Handbookposition">
                        <cfset args.includeString = '#args.modelName#(Handbookperson(State))'>
                     <cfelse>
                        <cfset args.includeString = '#args.modelName#(Handbookstate)'>
                     </cfif>

                    <cfset args.updates = model("Handbookupdate").findAll(
                           where=args.whereString,
                           include=args.includeString,
                           maxrows=args.showmaxrows,
                           page = args.page,
                           perpage = args.perpage,
                           order="createdAt DESC")>

              <cfreturn args.updates>

       </cffunction>

       <cffunction name="findPeopleUpdates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

            <cfquery datasource='#getDataSource()#' name="args.peopleUpdates">
                SELECT *
                FROM handbookupdates u
                LEFT JOIN handbookpeople p
                ON u.recordid = p.id
                LEFT JOIN handbookstates s
                ON p.stateid = s.id
                WHERE modelName = "Handbookperson"
                <cfif args.showOnlyToday>
                    AND handbookupdates.createdAt like '#args.today#%'
                </cfif>
                <cfif args.showOnlyYesterday>
                    handbookupdates.createdAt like '#args.yesterday#%'
                </cfif>
                ORDER BY u.createdAt DESC
                LIMIT #args.showmaxrows#
            </cfquery>


            <cfreturn args.peopleUpdates>

       </cffunction>

       <cffunction name="findPeopleCreates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>
            <cfparam name="args.page" default=0>
            <cfparam name="args.perpage" default=50>

            <cfquery datasource='#getDataSource()#' name="args.creates">
                SELECT *
                FROM handbookupdates u
                LEFT JOIN handbookpeople p
                ON u.recordid = p.id
                LEFT JOIN handbookstates s
                ON p.stateid = s.id
                WHERE modelname='handbookperson'
                AND datatype='new'
                <cfif args.showOnlyToday>
                    AND handbookupdates.createdAt like '#args.today#%'
                </cfif>
                <cfif args.showOnlyYesterday>
                    handbookupdates.createdAt like '#args.yesterday#%'
                </cfif>
                ORDER BY u.createdAt DESC
                LIMIT #args.showmaxrows#

            </cfquery>

              <cfreturn args.creates>

       </cffunction>

       <cffunction name="findOrganizationUpdates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

            <cfquery datasource='#getDataSource()#' name="args.organizationUpdates">
                SELECT *
                FROM handbookupdates u
                LEFT JOIN handbookorganizations o
                ON u.recordid = o.id
                LEFT JOIN handbookstates s
                ON o.stateid = s.id
                WHERE modelName = "handbookorganization"
                <cfif args.showOnlyToday>
                    AND handbookupdates.createdAt like '#args.today#%'
                </cfif>
                <cfif args.showOnlyYesterday>
                    handbookupdates.createdAt like '#args.yesterday#%'
                </cfif>
                ORDER BY u.createdAt DESC
                LIMIT #args.showmaxrows#
            </cfquery>

              <cfreturn args.organizationUpdates>

       </cffunction>

       <cffunction name="findPositionUpdates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

            <cfquery datasource='#getDataSource()#' name="args.positionUpdates">
                SELECT *
                FROM handbookupdates u
                LEFT JOIN handbookpositions p
                ON u.recordid = p.id
                LEFT JOIN handbookpeople ppl
                ON p.personid = ppl.id
                LEFT JOIN handbookstates s
                ON ppl.stateid = s.id
                WHERE modelName="handbookposition"
                <cfif args.showOnlyToday>
                    AND handbookupdates.createdAt like '#args.today#%'
                </cfif>
                <cfif args.showOnlyYesterday>
                    handbookupdates.createdAt like '#args.yesterday#%'
                </cfif>
                ORDER BY u.createdAt DESC
                LIMIT #args.showmaxrows#
            </cfquery>

              <cfreturn args.positionUpdates>

       </cffunction>

       <cffunction name="findPeopleDeletes">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

            <cfquery datasource='#getDataSource()#' name="args.peopledeletes">
                SELECT *
                FROM handbookupdates u
                LEFT JOIN handbookpeople p
                ON u.recordid = p.id
                LEFT JOIN handbookstates s
                ON p.stateid = s.id
                WHERE modelname = "handbookperson"
                AND dataType = 'delete'
                <cfif args.showOnlyToday>
                    AND handbookupdates.createdAt like '#args.today#%'
                </cfif>
                <cfif args.showOnlyYesterday>
                    handbookupdates.createdAt like '#args.yesterday#%'
                </cfif>
                LIMIT #args.showmaxrows#
            </cfquery>

              <cfreturn args.peopledeletes>

       </cffunction>

</cfcomponent>