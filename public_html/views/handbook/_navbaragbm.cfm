    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
			<cfoutput>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          #linkTo(class="brand", text="Inspire Membership List #currentmembershipyear#", controller="handbook.agbm-info", action="list")#
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
						<li>
							#linkto(text="10 Year List", controller="handbook.agbminfo", action="agbm10YearMembers")#
						</li>
					</ul>	
				</li>
				<li class="dropdown">
					#linkToData(text="Opportunities.<b class='caret'></b>", href="##", data_toggle= "dropdown", class="dropdown-toggle")#
					<ul class="dropdown-menu">
						<!--- <li>
							#linkto(text="Dashboard", controller="handbook.agbmInfo", action="dashboard")#
						</li> --->
						<li>
							#linkto(text="Sr Pastor Not-list", route="handbookPastorsNotAgbm", params="type=seniorpastors")#
						</li>
						<li>
							#linkto(text="Staff Pastor Not-list", route="handbookPastorsNotAgbm", params="type=staffpastors")#
						</li>
						<li>
							#linkto(text="All Pastor Not-list", route="handbookPastorsNotAgbm", params="type=allpastors")#
						</li>
						<li>
							#linkto(text="All Staff Not-list", route="handbookPastorsNotAgbm")#
						</li>
						<li>
							#linkto(text="Not-paid list", route="handbookAgbmDelinquent")#
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
							#linkTo(text="Set Current Membership Year to #currentmembershipyear+1#", route="handbookSetYear", key=currentmembershipyear+1)#
						</li>
						<li>
							#linkTo(text="Set Current Membership Year to #currentmembershipyear-1#", route="handbookSetYear", key=currentmembershipyear-1)#
						</li>
						<li>
							#linkTo(text="Inspire Regions", route="HandbookAgbmRegions")#
						</li>
						<li>
							#linkTo(text="Districts", controller="handbook.districts", action="index")#
						</li>

					</ul>	
				</li>
			  <li>	
				  	#startFormTag(route="handbookSearchAgbm", class="navbar-search")#
					#textFieldTag(name="search", class="search-query input-small", placeholder="Search")#
					#endFormTag()#
			  </li>	

            </ul>
			<cfif isdefined("session.auth.email")>	
           	 	<p class="navbar-text pull-right">#session.auth.email#&nbsp;#linkto(text="Logout", route="authLogoutUser")#</p>
			</cfif>
          </div><!--/.nav-collapse -->
			</cfoutput>
        </div>
      </div>
    </div>
