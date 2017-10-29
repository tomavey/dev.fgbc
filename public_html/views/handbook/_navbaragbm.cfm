    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          #linkTo(class="brand", text="Agbm Membership List #currentmembershipyear#", controller="handbook.agbm-info", action="list")#
          <div class="nav-collapse">
            <ul class="nav">
				<li class="dropdown">
					#linkToData(text="Lists<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<li>
							#linkto(text="Members", route="handbookAgbmList", action="list", params="type=members")#
						</li>
						<li>
							#linkto(text="Mail List", route="handbookAgbmList", action="list", params="type=mail")#
						</li>
						<li>
							#linkto(text="Handbook List", route="handbookList", action="handbook")#
						</li>
					</ul>	
				</li>
				<li class="dropdown">
					#linkToData(text="Opportunities.<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<li>
							#linkto(text="Dashboard", controller="handbook.agbmInfo", action="dashboard")#
						</li>
						<li>
							#linkto(text="Sr Pastor Not-list", route="handbookPastorsNotAgbm", params="type=seniorpastors")#
						</li>
						<li>
							#linkto(text="Staff Pastor Not-list", controller="handbook.agbm-info", action="pastorsnotagbm", params="type=staffpastors")#
						</li>
						<li>
							#linkto(text="All Staff Not-list", controller="handbook.agbm-info", action="pastorsnotagbm")#
						</li>
						<li>
							#linkto(text="Not-paid list", controller="handbook.agbmInfo", action="delinquent")#
						</li>
					</ul>	
				</li>
				<li class="dropdown">
					#linkToData(text="More<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<li>
							#linkto(text="RSS Feed", controller="handbook.agbmInfo", action="rss")#
						</li>
						<li>
							#linkto(text="Handbook Report", controller="handbook.agbmInfo", action="handbookMembershipReport")#
						</li>
						<li>
							#linkTo(text="Add a new person", controller="handbook.people", action="new", params="agbm=")#
						</li>
						<li>
							#linkTo(text="Set Current Membership Year to #currentmembershipyear+1#", controller="handbook.agbm-info", action="setyear", key=currentmembershipyear+1)#
						</li>
						<li>
							#linkTo(text="Set Current Membership Year to #currentmembershipyear-1#", controller="handbook.agbm-info", action="setyear", key=currentmembershipyear-1)#
						</li>
						<li>
							#linkTo(text="AGBM Regions", controller="handbook.agbmregions", action="index")#
						</li>
						<li>
							#linkTo(text="Districts", controller="handbook.districts", action="index")#
						</li>

					</ul>	
				</li>
			  <li>	
				  	#startFormTag(controller="handbook.agbm-info", action="list", class="navbar-search")#
					#textFieldTag(name="search", class="search-query input-small", placeholder="Search")#
					#endFormTag()#
			  </li>	

            </ul>
			<cfif isdefined("session.auth.email")>	
           	 	<p class="navbar-text pull-right">#session.auth.email#&nbsp;#linkto(text="logout", action="logout")#</p>
			</cfif>
          </div><!--/.nav-collapse -->
			</cfoutput>
        </div>
      </div>
    </div>
