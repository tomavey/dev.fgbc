<div>
	<cfoutput>
	<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
	<div class="container">
		<div class="pull-right">
			#startFormTag(action="showsearch", controller="conference.registrations")#
			#textFieldTag(name="search", placeholder="Search by last name or invoice id")#
			#endFormTag()#
		</div>
		<div class="pull-left">
		            <a class='btn btn-navbar' data-target='.nav-collapse' data-toggle='collapse'>
		              <span class='icon-bar'></span>
		              <span class='icon-bar'></span>
		              <span class='icon-bar'></span>
		            </a>
		</div>
		<div class="nav-collapse collapse">
			<ul  class="nav">
				<li>&nbsp;</li>
				<li>#linkto(text="Register", action="welcome", controller="conference.register", action="welcome", params="openreg")#</li>
				<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Events<b class='caret'></b>")#
					<ul class="dropdown-menu">
						<li>#linkto(text="Room Use Agenda", action="index", controller="conference.events")#</li>
						<li>#linkto(text="Locations", action="index", controller="conference.locations")#</li>
						<li>#linkto(text="Workshops/Excursions/Cohorts", action="index", controller="conference.courses")#</li>
						<li>#linkto(text="Instructors", action="index", controller="conference.instructors")#</li>
						<li>#linkto(text="Log", action="index", controller="conference.eventlogs")#</li>
					</ul>
				</li>
				<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Options<b class='caret'></b>")#
					<ul class="dropdown-menu">
						<li>#linkto(text="List Options", action="index", controller="conference.options")#</li>
						<li>#linkto(text="Add New Option", action="new", controller="conference.options")#</li>
						<li>#linkto(text="Age Ranges", action="index", controller="conference.age_ranges")#</li>
					</ul>
				</li>

				<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Registration<b class='caret'></b>")#
					<ul class="dropdown-menu">
						<li>#linkTo(text="Registrations", action="index", controller="conference.registrations")#</li>
						<li>#linkTo(text="Registrations by Option", action="list", controller="conference.registrations")#</li>
						<li>#linkTo(text="Summary Report", action="summary", controller="conference.registrations")#</li>
						<li>#linkTo(text="People", action="index", controller="conference.people")#</li>
						<li>#linkTo(text="Families", action="index", controller="conference.families")#</li>
						<li>#linkTo(text="Invoices", action="index", controller="conference.invoices")#</li>
						<li>#linkto(text="Envelope Info", action="envelopes", controller="conference.families")#</li>
						<li>#linkto(text="Badge Info", action="badges", controller="conference.families")#</li>
					</ul>
				</li>
				<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Exhibits<b class='caret'></b>")#
					<ul class="dropdown-menu">
						<li>#linkto(text="Info-Non", action="info", controller="conference.exhibits")#</li>
						<li>#linkto(text="Info-FGBC", action="info", controller="conference.exhibits", params="natmin=1")#</li>
						<li>#linkto(text="List", action="index", controller="conference.exhibits")#</li>
						<li>#linkto(text="Public List", action="list", controller="conference.exhibits")#</li>
						<li>#linkto(text="History", action="index", controller="conference.exhibits", params="history=")#</li>
						<li>#linkto(text="Add New", action="new", controller="conference.exhibits")#</li>
					</ul>
				</li>
				<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="API's<b class='caret'></b>")#
					<ul class="dropdown-menu">
						<li>#linkto(text="Meals As Json", route="apiMeals", target="_new")#</li>
						<li>#linkto(text="Schedule As Json", route="apiSchedule", target="_new")#</li>
						<li>#linkto(text="Speakers As Json", route="apiSpeakers", target="_new")#</li>
						<li>#linkto(text="Staff As Json", route="apiPersonalities", target="_new")#</li>
						<li>#linkto(text="Course Questions As Json", route="apiSpeakers", target="_new")#</li>
					</ul>
				</li>
				<li class="dropdown">
    				#linkToData(href="##", class="dropdown-toggle", data_toggle="dropdown", text="Misc<b class='caret'></b>")#
					<ul class="dropdown-menu">
						<li>#linkto(text="Conference Announcements", controller="conference.announcements", action="index")#</li>
						<li>#linkto(text="Hosts", action="index", controller="conference.homes")#</li>
						<li>#linkto(text="Backup Tables", controller="conference.backups", action="list")#</li>
						<li>#linkto(text="Clear Session", controller="conference.options", action="clearsession")#</li>
						<li>#linkto(text="Mail List - People", controller="conference.people", action="mailList")#</li>
						<li>#linkto(text="Email List - People", controller="conference.people", action="emailList")#</li>
						<li>#linkto(text="Mail List - Churches", controller="handbook.organizations", action="download-member-churches	")#</li>
						<li>#linkto(text="Update multiple emails", controller="focus.registrants", action="updateEmail", params="tableName=Conferenceperson")#</li>
						<li>#linkto(text="Workshop Email List", controller="conference.families", action="badges", params="forWorkshops")#</li>
						<!--- <li>#linkto(text="Group Rate for 1", controller="conference.register", action="selectOptions", params="group=1&useoptionscount")#</li> --->
						<li>#linkto(text="Settings", controller="admin.settings", action="index", params="category=conference")#</li>
						<li>#linkto(text="Change to Previous Event", controller="conference.register", action="changeSessionSettingsToPreviousConference")#</li>
						<li>#linkto(text="Clear Temp Event", controller="conference.register", action="clearSessionSettingsForEvent")#</li>
						<!--- <li>#linkto(text="Show Childcare Prices in Price List", controller="admin.settings", action="showGraceKidsPrices")#</li>
						<li>#linkto(text="Hide Childcare Prices in Price List", controller="admin.settings", action="hideGraceKidsPrices")#</li> --->
						<li>
							#linkto(
								text="Mail List for Posters",
								controller="handbook.organizations",
								action="downloadMemberChurches",
								key="includecampusesandnewchurches"
								)#
						</li>

					</ul>
				</li>
			</ul>
		</div>
	</div>
	</div>
	</cfoutput>
	</div>
	<br style="clear:left"/>
</div>