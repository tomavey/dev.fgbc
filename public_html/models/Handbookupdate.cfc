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
                        <cfset args.includeString = '#args.modelName#(State)'>
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

              <cfset args.modelName = "Handbookperson"><!---Needed to select type of update by modelName--->

              <cfset args.peopleUpdates = findUpdates(args)>

            <cfreturn args.peopleUpdates>

       </cffunction>

       <cffunction name="findPeopleCreates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>
            <cfparam name="args.page" default=0>
            <cfparam name="args.perpage" default=50>

                    <cfset args.createsWhereString = "modelName='HandbookPerson' AND dataType = 'new'">

                    <cfif args.showOnlyToday>
                        <cfset args.createsWhereString = args.createsWhereString & " AND handbookupdates.createdAt like '#args.today#%'">
                    </cfif>

                    <cfif args.showOnlyYesterday>
                        <cfset args.createsWhereString = args.createsWhereString & " AND handbookupdates.createdAt like '#args.yesterday#%'">
                    </cfif>

                    <cfset args.creates = model("Handbookupdate").findAll(
                           where= args.createsWhereString,
                           page = args.page,
                           perpage = args.perpage,
                           maxrows = args.perpage,
                           order="createdAt DESC")>

              <cfreturn args.creates>

       </cffunction>

       <cffunction name="findOrganizationUpdates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

              <cfset args.modelName = "Handbookorganization"><!---Needed to select type of update by modelName--->

              <cfset args.organizationUpdates = findUpdates(args)>

            <cfreturn args.organizationUpdates>

       </cffunction>

       <cffunction name="findPositionUpdates">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

              <cfset args.modelName = "Handbookposition"><!---Needed to select type of update by modelName--->

              <cfset args.organizationUpdates = findUpdates(args)>

            <cfreturn args.organizationUpdates>

       </cffunction>

       <cffunction name="findPeopleDeletes">
            <cfargument name="args" required = "true" type="struct">
            <cfset var args = arguments.args>

                    <cfset args.deleteWhereString = "modelName= 'HandbookPerson' AND dataType = 'deleted'">

                    <cfif args.showOnlyToday>
                        <cfset args.deleteWhereString = args.deleteWhereString & " AND handbookupdates.createdAt like '#args.today#%'">
                    </cfif>

                    <cfif args.showOnlyYesterday>
                        <cfset args.deleteWhereString = args.deleteWhereString & " AND handbookupdates.createdAt like '#args.yesterday#%'">
                    </cfif>

                    <cfset peopledeletes = model("Handbookupdate").findAll(
                           where= args.deleteWhereString,
                           order="createdAt DESC")>

              <cfreturn peopledeletes>

       </cffunction>

</cfcomponent>