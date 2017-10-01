	<cfoutput>
	<div class="navbar">
	<div class="navbar-inner">
	<div class="container">
		 <cfif isMobile()>
		 #linkto(text="FGBC Handbook", class="brand", route="handbookPeople")#
		 </cfif>
		 <div class="pull-right">
				#startFormTag(controller="handbook/tags", action="search", method="get", class="navbar-search pull-left")#
				#textFieldTag(name="Search", class="search-query input-small", placeholder="Search", prependToLabel="", append="")#
				#endFormTag()#
		</div>
		<div class="pull-left">
                                <a class='btn btn-navbar' data-target='.nav-collapse' data-toggle='collapse'>
                    			  <span class="menu">Menu</span>
                                  <span class='icon-bar'></span>
                                  <span class='icon-bar'></span>
                                  <span class='icon-bar'></span>
                                </a>
		</div>
		<div class="nav-collapse collapse">
    		<ul class="nav">
    			<li>&nbsp;</li>
    			<li>
    				#linkto(text="Churches", controller="handbook.organizations", action="index", title="Churches in the FGBC", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="People", controller="handbook.people", action="index", title="People in the FGBC", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="My Tags", controller="handbook.tags", action="index", id="navsearch", title="Your Tags", class="tooltip2")#
    			</li>
    			<cfif isDefined("session.auth.handbook.organizations") AND not isMobile() AND 0 EQ 1>
    			<cfloop list="#session.auth.handbook.organizations#" index="i">
    			<li>
    				#linkto(text="My Church", controller="handbook.organizations", action="show", key=i, id="navsearch", title="View #getChurchName(i)# page.", class="tooltip2")#
    			</li>
    			</cfloop>
    			</cfif>
    			<li>
    				#linkto(text="Pictures", controller="handbook.pictures", action="index", title="Pictures of people", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="Birthdays", controller="handbook.people", action="dates", dateType="birthday", title="View Birthdays", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="Anniversaries", controller="handbook.people", action="dates", dateType="anniversary", title="View Anniversaries", class="tooltip2")#
    			</li>

				<!---
    			<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Prayer<b class='caret'></b>")#
    				<ul class="dropdown-menu">
        				<li>
        					#linkto(text="Today", controller="handbook.prayers", action="thisday", id="navsearch", title="Today's prayer list", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="This Week", controller="handbook.prayers", action="thisweek", id="navsearch", title="This weeks prayer list", class="tooltip2")#
        				</li>

    				</ul>
    			</li>
                <li>
                    #linkto(text="?", controller="handbook.welcome", action="help", title="Help Tutorials", class="tooltip2")#
                </li>
				--->
    		</ul>

    		<ul class="nav">

    			<cfif gotrights("superadmin,office,agbmadmin,ministrystaff,handbookadmin")>

    			<li class="dropdown">
    				#linkToData(controller="handbook.menus", action="administration", class="dropdown-toggle", data_toggle="dropdown", text="Administration<b class='caret'></b>")#
                <ul class="dropdown-menu">
                    #includePartial("/handbook/navdropadmin")#
                </ul>
    			</li>
    			</cfif>

    			<cfif gotRights("superadmin,office,handbookedit")>
    			<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Handbook Reports<b class='caret'></b>")#
    				<ul class="dropdown-menu">
        				<li>
        					#linkto(text="Blue Pages", route="handbookBluepages", id="navsearch", title="People Info for Handbook", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Yellow Pages", route="handbookYellowpages", id="navsearch", title="Church Info for Handbook", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Prayer List", route="handbookPrayerlist", id="navsearch", title="Generate a prayerlist for the handbook.", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Districts", controller="handbook.districts", action="index", id="navsearch", title="Links to District Information", class="tooltip2")#
        				</li>
                        <li>
                            #linkto(text="Districts Report", controller="handbook.districts", action="handbookreport", id="navsearch", title="Report for Handbook", class="tooltip2")#
                        </li>
        				<li>
        					#linkto(text="Church Distribution", controller="handbook.organizations", action="distribution", id="navsearch", title="Download distribution list to churches", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="People Distribution", controller="handbook.people", action="distribution", id="navsearch", title="Download distribution list to people", class="tooltip2")#
        				</li>
    				</ul>
    			</li>
    			</cfif>

                                    <li>
                                        #linkToData(text="Change Log", controller="handbook.updates", action="index", title="View a list of recent changes to data in this handbook.")#
                                    </li>

    			<cfif gotrights("superadmin,office,natminproject,myfgbc,natminproj,natminstaff,ministrystaff")>
    			<li>
    				#linkToData(text="Downloads", controller="handbook.organizations", action="downloadguidelines")#
    			</li>
    			</cfif>

    			<cftry>
            		<cfif
    					  (isdefined("session.auth.handbook.people")
    					  AND gotHandbookOrganizationRights(handbookorganization.id)
    					  AND handbookorganization.statusid NEQ 10
    					  AND handbookorganization.statusid NEQ 11)
    					  OR gotRights("superadmin,office,agbmadmin")
    					  >
    					<li>
    						#linkTo(text="Printed Handbook Listing", controller="handbook.organizations",action="handbookpages",key=params.key)#
    					</li>
    				</cfif>
    			<cfcatch></cfcatch>
    			</cftry>

    		</ul>
		</div>
		</div>
		</div>
		</div>

 		#showFlashErrorOrSuccess()#

	</cfoutput>
