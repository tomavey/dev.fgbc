    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          #linkTo(class="brand", text="FGBC Statistics", controller="handbook.statistics", action="welcome")#
          <div class="nav-collapse">
            <ul class="nav">

            	<cfif gotRights("superadmin,office")>
				<li class="dropdown">
					#linkToData(text="Stats<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<li>
							#linkto(text="Add new", controller="handbook.statistics", action="new")#
						</li>
						<li>
							#linkto(text="List (#year(now())-1#", controller="handbook.statistics", action="index")#
						</li>
						<li>
							#linkto(text="List (#year(now())-2#)", controller="handbook.statistics", action="index", params="year=#year(now())-2#")#
						</li>
						<li>
							#linkto(text="Deliquencies", controller="handbook.statistics", action="delinquent")#
						</li>
						<li>
							#linkto(text="Paid", controller="handbook.statistics", action="allCurrent", params="type=paid")#
						</li>
						<li>
							#linkto(text="Not Paid (#year(now())#)", controller="handbook.statistics", action="allCurrent", params="type=notpaid")#
						</li>
						<li>
							#linkto(text="Not Paid (#year(now())-1#)", controller="handbook.statistics", action="allCurrent", params="type=notpaid&year=#year(now())-1#")#
						</li>
						<li>
							#linkto(text="All", controller="handbook.statistics", action="allCurrent")#
						</li>
						<li>
							#linkto(text="501c3 Group Roster", controller="handbook.organizations", action="groupRoster")#
						</li>
					</ul>
				</li>
		</cfif>
				<li class="dropdown">
					#linkToData(text="Reports<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<li>
							#linkto(
								text="Summary",
								controller="handbook.statistics",
								action="getSummary",
								key=year(now())-1,
								params="
									compyear=#year(now())-2#&
									compyear2=#year(now())-3#&
									compyear3=#year(now())-4#&
									compyear4=#year(now())-5#"
									)
								#
						</li>
						<li>
							#linkto(
								text="Growth",
								controller="handbook.statistics",
								action="churchgrowth",
								params="
									year1=#year(now())-1#&
									year2=#year(now())-6#&
									delta=10"
									)
								#
						</li>
						<li>
							#linkto(
								text="Stat History",
								controller="handbook.statistics",
								action="stathistory"
									)
								#
						</li>
						<li>
							#linkto(
								text="Distribution",
								controller="handbook.statistics",
								action="sizeByPercent",
								key=year(now())-1
									)
								#
						</li>
						<li>
							#linkto(
								text="Member List",
								controller="handbook.organizations",
								action="memberChurches"
									)
								#
						</li>
						<li>
							#linkto(
								text="Status Changed List",
								controller="handbook.statistics",
								action="closedchurches"
									)
								#
						</li>
						<li>#linkto(text="fgbc.org/sendstats", controller="handbook.statistics", action="submit", target="_new")#</li>
					</ul>
				</li>

		<cfif gotRights("office")>
				<li class="dropdown">
					#linkToData(text="Downloads<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<li>
							#linkto(
								text="Member Churches",
								controller="handbook.admin",
								action="downloadMemberChurches"
								)#
						</li>
						<li>
							#linkto(
								text="Member Churches w/Campuses",
								controller="handbook.admin",
								action="downloadMemberChurches",
								key="includecampuses"
								)#
						</li>
						<li>
							#linkto(
								text="Member Churches w/Campuses and New Churches",
								controller="handbook.admin",
								action="downloadMemberChurches",
								key="includecampusesandnewchurches"
								)#
						</li>
						<li>
							#linkto(
								text="Churches not paid",
								controller="handbook.statistics",
								action="allCurrent",
								params="download=1&type=notPaid"
								)#
						</li>
					</ul>
				</li>
				<li>
					#linkTo(Text="Projection", controller="handbook.statistics", action="getfee")#
				</li>
<!---
			  <li>
				  	#startFormTag(action="search", class="navbar-search")#
					#textFieldTag(name="key", class="search-query input-small", placeholder="Search")#
					#endFormTag()#
			  </li>
 --->
            	</cfif>

            </ul>
			<cfif isdefined("session.auth.email")>
           	 	<p class="navbar-text pull-right">#session.auth.email#&nbsp;#linkto(text="logout", controller="auth.users", action="logout")#</p>
			</cfif>
          </div><!--/.nav-collapse -->
			</cfoutput>
        </div>
      </div>
    </div>
