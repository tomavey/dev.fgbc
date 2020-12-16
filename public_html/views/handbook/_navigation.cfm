	<cfoutput>
	<div class="navbar">
	<div class="navbar-inner">
	<div class="container">
		 <cfif isMobile()>
		 #linkto(text="Charis Fellowship Handbook", class="brand", route="handbookPeople")#
		 </cfif>
		 <div class="pull-right">
				#startFormTag(route="HandbookSearchtags", class="navbar-search pull-right", method="get")#
				#textFieldTag(name="Search", class="search-query input-small", placeholder="Search......", prependToLabel="", append="")#
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
		<div class="nav-collapse collapse pull-left">
    		<ul class="nav">
    			<li>&nbsp;</li>
    			<li>
    				#linkto(text="Churches", controller="handbook.organizations", action="index", title="Churches in the FGBC", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="People", controller="handbook.people", action="quickSearch", title="People in the FGBC", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="Thrive", controller="handbook.wives", action="index", title="Charis Pastor's Wives Network", class="tooltip2")#
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
    				#linkto(text="Birthdays", controller="handbook.people", action="dates", params="dateType=birthday", title="View Birthdays", class="tooltip2")#
    			</li>
    			<li>
    				#linkto(text="Anniversaries", controller="handbook.people", action="dates", params="dateType=anniversary", title="View Anniversaries", class="tooltip2")#
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
				--->
                <li>
                    #linkto(text="?", controller="handbook.welcome", action="help", title="Help Tutorials", class="tooltip2")#
                </li>
    		</ul>

    		<ul class="nav">

    			<cfif gotrights("superadmin,office,agbmadmin,ministrystaff,handbookadmin")>

    			<li class="dropdown">
						<cfif isMobile()>
							#linkTo(controller="handbook.menus", action="administration", text="Administration")#
						<cfelse>	
							#linkTo(controller="handbook.menus", action="administration", class="dropdown-toggle", data_toggle="dropdown", text="Administration<b class='caret'></b>")#
                <ul class="dropdown-menu">
                    #includePartial(partial="/handbook/navdropadmin")#
                </ul>
						</cfif>
    			</li>
    			</cfif>

    			<cfif gotRights("superadmin,office,handbookedit")>
						<li class="dropdown">
							<cfif isMobile()>
								#linkTo(controller="handbook.menus", action="handbook", text="Handbook Reports")#
							<cfelse>	
								#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Handbook Reports<b class='caret'></b>")#
									<ul class="dropdown-menu">
													#includePartial(partial="/handbook/navdrophandbook")#
									</ul>
							</cfif>
						</li>
    			</cfif>

					<li>
							#linkToData(text="Change Log", controller="handbook.updates", action="index", title="View a list of recent changes to data in this handbook.")#
					</li>

    			<cfif gotrights("superadmin,office,natminproject,myfgbc,natminproj,natminstaff,ministrystaff,stats")>
						<li>
							#linkToData(text="Downloads", controller="handbook.organizations", action="downloadguidelines")#
						</li>
						<li>
							#linkToData(text="Statistics", controller="handbook.statistics", action="welcome")#
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
