<!---TRASH--->	
<cffunction name="Xindex">
  <cfparam name="params.page" default="1">
  <cfset request.showpagination = true>
  <cfset states = model("Handbookorganization").findStatesWithOrganizations()>

  <cfset whereString = "show_in_handbook = 1">
  <cfset includeString="handbookstate,handbookstatus">
  <cfset orderString="state,org_city">
  <cfset pageCount = 0>
  <cfset perpageCount = 10000000>
  <cfset returnAsString = "query">
  <cfset selectString = "">

  <cfif isdefined("params.status")>
    <cfset whereString = "status='#params.status#'">
  <cfelseif isdefined("params.state")>
    <cfset whereString = whereString & " AND state_mail_abbrev = '#params.state#'">
  <cfelseif isDefined("params.district") AND isDefined("params.membersonly")>
    <cfset includeString = includeString & ",handbookdistrict">
    <cfset whereString = whereString & " AND districtid = #params.district# AND statusID = 1">
  <cfelseif isDefined("params.district")>
    <cfset includeString = includeString & ",handbookdistrict">
    <cfset whereString = whereString & " AND districtid = #params.district#">
  <cfelseif isDefined("params.format") and params.format is "json">
    <cfset returnAsString = "structs">
    <cfset selectString = "name,org_city,listed_as_city,meetingplace,state,id,address1,address2,phone,email,website,fname">
  <cfelse>
    <cfset pageCount = params.page>
    <cfset perpageCount = 50>
  </cfif>

  <cfset handbookorganizations = model("Handbookorganization").findAll(select=selectString, where=whereString, include=includeString, page=pageCount, perPage=perPageCount, order=orderString, returnAs=returnAsString)>

  <cfif isDefined("params.state")>
    <cfset request.showpagination = false>
  </cfif>
  <cfif isDefined("params.district")>
    <cfset request.showpagination = false>
  </cfif>

  <cfset renderWith(data=handbookorganizations)>

</cffunction>

<cffunction name="Xshow">

  <cfset setReturn()>
  <!--- Find the record --->
    <cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")>
  <cfset tags=model("Handbooktag").findMyTagsForId(params.key,"organization")>
  <cfset positions = model("Handbookperson").findall(where="organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="p_sortorder,updatedAt")>

    <!--- Check if the record exists --->
    <cfif NOT IsObject(handbookorganization)>
        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
        <cfset redirectTo(action="index")>
    </cfif>

     <cfif isdefined("params.ajax")>
    <cfset renderPartial("show")>
  </cfif>

</cffunction>

<cffunction name="XshowInPanel">

  <cfset setReturn()>
  <!--- Find the record --->
    <cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")>
  <cfset tags=model("Handbooktag").findMyTagsForId(params.key,"organization")>
  <cfset positions = model("Handbookperson").findall(where="organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="p_sortorder,lname")>

    <!--- Check if the record exists --->
    <cfif NOT IsObject(handbookorganization)>
        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
        <cfset redirectTo(action="index")>
    </cfif>

  <cfset renderPartial("show")>

</cffunction>

<cffunction name="Xnew">
  <cfset handbookorganization = model("Handbookorganization").new()>
  <cfset var paramslist = structKeyList(params)>
  <cfset paramslist = replace(paramslist,"ROUTE,","")>
  <cfset paramslist = replace(paramslist,"CONTROLLER,","")>
  <cfset paramslist = replace(paramslist,"CONTROLLER","")>
  <cfset paramslist = replace(paramslist,"ACTION,","")>
  <cfset paramslist = replace(paramslist,"ACTION","")>
  <cfloop list="#paramslist#" index="i">
    <cfif isDefined("params[i]")>
      <cfset handbookorganization[i] = params[i]>
    </cfif>
  </cfloop>
</cffunction>

<cffunction name="Xedit">

  <!--- Find the record --->
    <cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="handbookstate")>

    <!--- Check if the record exists --->
    <cfif NOT IsObject(handbookorganization)>
        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
    <cfset redirectTo(action="index")>
    </cfif>

</cffunction>

<cffunction name="Xcreate">
  <cfset handbookorganization = model("Handbookorganization").new(params.handbookorganization)>

  <!--- Verify that the handbookorganization creates successfully --->
  <cfif handbookorganization.save()>
    <cfset flashInsert(success="The handbookorganization was created successfully.")>
    <cfset $updateNewChurchOrApplication(handbookorganization)>
          <cfset redirectTo(action="index")>
  <!--- Otherwise --->
  <cfelse>
    <cfset flashInsert(error="There was an error creating the handbookorganization.")>
    <cfset renderView(action="new")>
  </cfif>
</cffunction>

<cffunction name="XdownloadMemberChurches">
  <cfset memberChurches = model("Handbookorganization").findAll(where="statusId in (1,8,9)",include="Handbookstate,Handbookdistrict,Handbookstatus")>
  <cfset $setDownloadLayout()>
</cffunction>

<cffunction name="X$addStatNote">
  <cfargument name="churchid" required="true" type="numeric">
  <cfset var loc=structNew()>
    <cfset loc.stat = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#year(now())-1#'")>
    <cftry>
      <cfset loc.return = loc.stat.att & "/" & loc.stat.members>
    <cfcatch>
      <cfset loc.return = '*'>
    </cfcatch>
    </cftry>
    <cfreturn loc.return>
  </cffunction>

  <cffunction name="Xhandbookpages">
    <cfset setReturn()>

    <cfset organization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")>

    <cfset reSort(params.key)>

    <cfset whereString = "organizationid='#params.key#' AND position NOT LIKE '%Removed%' AND position NOT LIKE '%AGBM Only%'">

    <cfif !isDefined("params.showall")>
      <cfset whereString = whereString & " AND p_sortorder < #getNonStaffSortOrder()#">
    </cfif>

    <cfset orderString = "p_sortorder,lname">

    <cfif isDefined("params.sortByLname")>
      <cfset orderString = "lname,fname,p_sortorder">
    </cfif>

    <cfset positions = model("Handbookperson").findall(where=whereString, include="Handbookpositions,Handbookstate", order=orderString)>

    <cfset positionsalpha = model("Handbookperson").findall(where=whereString, include="Handbookpositions,Handbookstate", order="lname,fname")>

    <cfif positions.recordcount>
       <cfset newSortOrder = positions.p_sortorder + 1>
    </cfif>

    <cfset renderView(layout="/Handbook/layout_handbook2")>
  </cffunction>

  <cffunction name="Xmove">
    <cfargument name="thisId" default="#params.positionid#">
    <cfargument name="thisSortorder" default="#params.sortorder#">
    <cfargument name="otherId" default="#params.otherId#">
    <cfargument name="otherSortorder" default="#params.otherSortorder#">
    <cfargument name="orgid" default="#params.orgid#">
  
    <cfset move = model("Handbookperson").swapSortorder(
         thisid = #arguments.thisid#,
         thisSortorder = #arguments.thisSortOrder#,
         otherid = #arguments.otherid#,
         othersortorder = #arguments.othersortorder#
         )>
  
      <cfset redirectTo(back=true)>
    </cffunction>
  
    <cffunction name="XavailableForSpeedDate">
      <cfargument name="host" required="true" type="numeric">
      <cfargument name="guest" required="true" type="numeric">
      <cfset var loc= structNew()>
      <cfset loc = arguments>
      <cfset loc.return = true>
      <cfset loc.groups = params.groups>
      <cfset loc.groupscount = structCount(loc.groups)>
        <cfloop from="1" to="#loc.groupscount#" index="loc.session">
          <cftry>
            <cfif val(loc.groups[loc.session][loc.host]) EQ loc.guest OR val(loc.groups[loc.session][loc.guest]) EQ loc.host or loc.host EQ loc.guest>
              <cfset loc.return = false>
              <cfreturn loc.return>
            </cfif>
          <cfcatch></cfcatch></cftry>
        </cfloop>
      <cfreturn loc.return>
      </cffunction>
    
      <cffunction name="Xshowparams">
        <cfloop collection="#params#" item="i">
          <cfdump var="#i#"><cfdump var="#params[i]#">
        </cfloop>
        <cfdump var="#params#"><cfabort>
      </cffunction>
    
      <cffunction name="XspeedDating">
        <cfset var loc= structNew()>
          <cfif isDefined("params.groupscount")>
            <cfset params.groups = structNew()>
            <cfloop from="1" to="#params.groupscount#" index="loc.session">
              <cfloop from="1" to="#params.groupscount#" index="loc.host">
                <cfloop from="1" to="#params.groupscount#" index="loc.guest">
                  <cfif availableForSpeedDate(loc.host,loc.guest)>
                    <cfset params.groups[loc.session][loc.host]=loc.guest>
                  <cfbreak>
                  </cfif>
                </cfloop>
              </cfloop>
            </cfloop>
          </cfif>
          <cfdump var="#params#"><cfabort>
          <cfset renderView(layout="/handbook/layout_handbook2")>
        </cffunction>
      
        <cffunction name="XsetReview">
          <cfargument name="organizationId" default="#params.key#">
          <cfif session.auth.email NEQ "tomavey@fgbc.org" && session.auth.email NEQ "tomavey@charisfellowship.us" >
              <cfset organization = model("Handbookorganization").findOne(where="id=#arguments.organizationid#", include="Handbookstate")>
            <cfif NOT len(organization.updatedBy)>
                <cfset organization.updatedBy = session.auth.email>
            </cfif>
              <cfset organization.reviewedAt = now()>
              <cfset organization.reviewedBy = session.auth.email>
              <cfset test = organization.update()>
          </cfif>
            <cfset returnBack()>
          </cffunction>
        
          <cffunction name="Xyellowpages">
            <cfif isDefined("params.key")>
              <cfset whereString = "id = #params.key#">
            <cfelse>
              <cfset whereString = "statusid IN (1,2,8)">
            </cfif>
        
            <cfset orderString = "state,listed_as_city,name,p_sortorder">
        
            <cfset churches = model("Handbookorganization").findAll(where=whereString, include="ListeAsState,Positions(Handbookperson)", order=orderString)>
        
            <cfquery dbType="query" name="churches">
              SELECT * from churches
              WHERE p_sortorder IS NULL OR 
                positiontypeid = 32 OR 
                (p_sortorder > 0 AND p_sortorder < #getNonStaffSortOrder()#)
            </cfquery>
        
            <cfif isDefined("params.noFormat")>
              <cfset renderView(layout="/layout_naked", hideDebugInformation="true")>
            <cfelse>
              <cfset renderView(layout="/handbook/layout_handbook")>
            </cfif>
          </cffunction>
        
                          
