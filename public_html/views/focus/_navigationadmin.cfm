<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
	
	<cfoutput>	
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>

          #linkTo(class="brand", text="Focus Retreats", controller="focus.main", action="welcome")#

          <div class="nav-collapse">
    		  <ul class="nav">
    			<li class="#getActive('home')#">#linkTo(controller='focus.main', action='welcome', text="Main Page")#</li>
    			<li class="#getActive('home')#">#linkTo(controller="focus.retreats", action="index", text="Retreats")#</li>
		
					<!---OPTIONS DROPDOWN--->

					<li class="dropdown">
					#linkToData(text="Options<b class='caret'></b>", href="##", data_toggle="dropdown", class="dropdown-toggle")#
        				<ul class="dropdown-menu">
        					<cfloop query="#showOptionsFor()#">
        					<li>
        						#linkTo(controller="focus.items", action="index", text=regid, params="retreatid=#id#")#
        					</li>
        					</cfloop>
                            <li>#linkTo(controller="focus.items", action="index", text="Show All")#</li>
        				</ul>
    			</li>

					<!---CONTENT DROPDOWN--->

					<li class="dropdown">
					#linkToData(text="Content<b class='caret'></b>", href="##", data_toggle="dropdown", class="dropdown-toggle")#
        				<ul class="dropdown-menu">
        					<li>
        						#linkTo(text="Home Page", controller="focus.contents", action="index")#
        					</li>
									<li>
										#linkTo(text="Settings", href="https://charisfellowship.us/admin/settings/?category=focus")#
									</li>
        				</ul>
    			</li>

					<!---MAILING LISTS DROPDOWN--->

					<li class="dropdown">
					#linkToData(text="Mailing List<b class='caret'></b>", href="##", data_toggle="dropdown", class="dropdown-toggle")#
        				<ul class="dropdown-menu">
    						<cfoutput query="retreatRegions" group="focusretreat">
        						<cfif len(focusretreat)>
                					<li>
                						#linkTo(text=left(focusretreat,10), controller="handbook.people", action="focus", key=focusretreat, params="includeWomen=#getSetting('includeWomen')#&yearsAgo=#getSetting('yearsAgo')#")#
                					</li>
        						</cfif>	
										<li>
										</li>
								</cfoutput>	
								<cfoutput>
									#linkTo(text="Update Multiple Emails", controller="focus.registrants", action="updateemail", params="tableName=Focusregistrant")#
								</cfoutput>
							</ul>
    			</li>
				
					<!---REGISTRATIONS DROPDOWN--->

					<li class="dropdown">
        			#linkToData(href="##", text="Registrations<b class='caret'></b>", data_toggle="dropdown", class="dropdown-toggle")#
        				<ul class="dropdown-menu">
										<li>#linkTo(controller="focus.registrations", action="index", text="Recent")#</li>
        					<cfloop query="#showRegsFor()#">
        						<li>#linkTo(controller="focus.registrations", action="index", params="retreatid=#id#", text=regid, retreatid=id)#</li>
        					</cfloop>
                     <li>#linkTo(controller="focus.registrations", action="summary", text="Summary")#</li>
        				</ul>
      			</li>	

<!---MISC DROPDOWN--->

					<li class="dropdown">
        			#linkToData(href="##", text="Misc<b class='caret'></b>", data_toggle="dropdown", class="dropdown-toggle")#
        				<ul class="dropdown-menu">
									<li>#linkTo(text="Recent Regs", controller="focus.registrants", action="recentRegistrants")#</li>
									<li>#linkTo(text="Shopping Carts", controller="focus.shoppingcarts", action="index")#</li>
									<li>#linkTo(text="Reg Fox (under development)", href="/focus/regFox")#</li>
        				</ul>
      			</li>	
			</ul>

<!---SEARCH FIELD--->

			#startFormTag(controller="focus.registrations", action="index", method="get" ,class="navbar-search")#
						#textFieldTag(name="search", class="search-query input-small", placeholder="Search")#
					#endFormTag()#
    			<p class="navbar-text pull-right">#linkTo(text="Logout", route="authLogoutUser")#</p>
		</div>

</cfoutput>

		   	</div>
	  </div>
</div>

	<div class="container container-main">
