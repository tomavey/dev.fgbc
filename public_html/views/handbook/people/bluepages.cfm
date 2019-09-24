<!---Test--->
<cfparam name="bluepagesPeople" type="query">

<cfset previouslname = "">
<cfset previousfname = "">
<cfset alert=0>
<cfset count = 0>
<cfoutput>
<div class="span10 offset1">
<!---#javaScriptIncludeTag("ajaxdelete")#--->

<!--- 
  not working yet
  <p>
  <cfloop list="#getSetting('alphabet')#" index="ii">
    #linkToPlus(text=ii, addParams="alpha=#ii#")#
  </cfloop>
</p> --->

<!---This section places buttons at the top depending on params defined--->
<!---params.layout turns off all buttons--->
<!---params.showdedit turns on special edit and alert options and it turns off the Show Edit Button--->
<div class="btn-group btn-group-justified">
  <cfif NOT isDefined("params.showedit") AND not isDefined("params.layout")>
    #linkToPlus(
      text="Show Edit Button, Position Delete, <br/> Update and Duplication Alert <br/> and removed from staff and AGBM only", 
      action="bluepages", 
      addParams="showedit=1&showupdatedat=1&showalert=1&showremoved=1&showhiddenpositions=1", 
      class="btn btn-xl")#
  <cfelseif not isDefined("params.layout")>
    #linkTo(
      text="Hide <br/> Edit Button, Position Delete, <br/> Update and Duplication Alert", 
      action="bluepages", 
      params="", 
      class="btn btn-xl")#
  </cfif>

<!---params.nonstaff filters out people who are on staff at a church or ministry or is a member of the agbm.  Use this to find names that might need to be deleted.  It also turns off the non-staff button--->
  <cfif NOT isDefined("params.nonstaff") AND not isDefined("params.layout")>
      #linkToPlus(
        text="Only show <br/> Non-Staff and <br/> Non-Agbm With Links", 
        action="bluepages", 
        addParams="nonstaff=1&showedit=1&showupdatedat=1&showalert=1", 
        class="btn btn-xl")#
  <cfelseif not isDefined("params.layout")>
      <!--- this button removes all the special params--->
      #linkTo(
        text="Show all <br/> without <br/> links", 
        action="bluepages", 
        params="", 
        class="btn btn-xl")#
  </cfif>

<!--- this button causes the controller to use layout_naked--->
  <cfif gotrights("superadmin,handbookadmin") && !isDefined("params.getremovedstaffonly") && !isDefined("params.layout")>
      #linktoPlus(
        text="Show <br/> removed from staff <br/> only.", 
        addParams="showedit=1&showupdatedat=1&showalert=1&showremoved=1&showhiddenpositions=1&showRemovedStaffOnly", 
        action="bluepages", 
        class="btn btn-xl")#
  </cfif>

<!--- this button causes the controller to use layout_naked--->
  <cfif not isDefined("params.layout")>
      #linktoPlus(
        text="Show <br/> without <br/> formatting", 
        addParams="layout=naked", 
        action="bluepages", 
        class="btn btn-xl")#
  </cfif>

<!---this button causes the controller to use downloadstaff template and the layout_download--->
  <cfif not isDefined("params.download") && !isDefined("params.layout")>
      #linkto(text="Download as<br/>
      Excel<br/>with edit links", params="download=1", action="bluepages", class="btn btn-xl")#
  </cfif>
</div>

</cfoutput>

<cffunction name="filterAvey">
  <cfargument name="obj">
  <cfif obj.lname is "Avey">
    <cfreturn true>
  </cfif>
  <cfreturn false>
</cffunction>

  <cfoutput query="bluepagesPeople" group="alpha">
    <cfoutput group="id">

      <cfif (!isDefined("params.nonstaff")) || (!isNatMinOrCoopMin(id) && !isAGBMMember(id))>

        <cfif lname EQ previouslname and fname EQ previousfname and isDefined("params.showalert")>
           <cfset alert = 1>
        </cfif>

          <cfset previouslname = "">
          <cfset previousfname = "">

          <cfif alert>
            **Possible Duplication**&nbsp;<br/>
          </cfif>

        #includePartial("/_shared/handbookinfo")#

        <p class="bluepageextrainfo">

          <cfif isDefined("params.showupdatedat") and isDate(updatedAt)>
            Last updated: #dateformat(updatedAt)#<br/>
          <cfelseif isDefined("params.showupdatedat")>
            Created: #dateformat(createdAt)#<br/>
          </cfif>

	      	<cfif isDefined("params.showupdatedat") and isAgbmMember(id)>
	      		#linkTo(text="AGBM (present member)", controller="handbook.agbm-info", action="show", key=id, onclick="window.open(this.href); return false;")#<br/>
          <cfelseif  isDefined("params.showupdatedat") and isAgbm(id)>
            #linkTo(text="AGBM (former member)", controller="handbook.agbm-info", action="show", key=id, onclick="window.open(this.href); return false;")#<br/>
	      	</cfif>

          <cfif isDefined("params.showupdatedat")  and isDate(updatedAt)>
          <cftry>
            #linkTo(text="Access handbook as #fname#", controller="handbook.welcome", action="welcome", onlyPath=false, key=encrypt(email,application.wheels.passwordkey,"CFMX_COMPAT","HEX"))#
          <cfcatch></cfcatch></cftry>
          </cfif>

		  </p>

          <br/>

          <cfset previouslname = lname>
          <cfset previousfname = fname>
          <cfset alert=0>
        <cfset count = count +1>

      </cfif>

    </cfoutput>
  </cfoutput>

<cfoutput>
  Count: #count#
</cfoutput>
</div>