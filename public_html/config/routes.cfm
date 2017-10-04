<!---
	Here you can add routes to your application and edit the default one.
	The default route is the one that will be called on your application's "home" page.
<cfset addRoute(name="home", pattern="", controller="home", action="index")>
	Routes are not cascading, the first pattern that applied is used.
	So put specific routes before "resource()" routes
--->
<cfscript>
	drawRoutes()

		.namespace("admin")
			.resources("announcements")
			.resources("blogs")
			.resources("contents")
			.resources("events")
			.resources("jobs")
			.resources("menus")
			.resources("messages")
			.resources("ministries")
			.resources("resources")
		.end()

		.namespace("auth")
			.post(name="CheckLogin", pattern="/users/checklogin/", controller="users", action="checklogin")
			.get(name='LogoutUser', pattern="/users/logout", controller="users", action="logout")
			.get(name='NewUser', pattern="/users/new", controller="users", action="new")
			.get(name='ForgotPassword', pattern="/users/get-email-for-change-password-link/", controller="users", action="get-email-for-change-password-link")
			.get(name="thankyou", pattern="/users/thankyou", controller="users", action="thankYou")
			.resources("users")
			.resources("groups")
			.resources("rights")
		.end()

		.namespace("handbook")
			.get(name="downloadmemberchurchesadmin", pattern="/admin/downloadmemberchurches/", controller="admin", action="downloadMemberChurches")
			.resources("admin")
			.resources("agbm")

			.get(name="addAGBMPayment", pattern="/agbminfo/add/[key]", controller="AgbmInfo", action="add")
			.get(name="agbmList", pattern="/agbmInfo/list/", controller="agbmInfo", action="list")
			.resources("agbmInfo")

			.get(name="districtsReport", pattern="/districts/report/", controller="districts", action="handbookreport")
			.resources("districts")
			.resources("groups")
			.resources("groupTypes")
			.resources("menus")
			.resources("notes")

			.get(name="handbookPagesEdit", pattern="/organizations/handbookpages/[key]", controller="organizations", action="handbookpages")
			.get(name="move", pattern="/organizations/move/", controller="organizations", action="move")
			.get(name="removeStaff", pattern="/organizations/removeStaff/[key]", controller="organizations", action="notStaff")
			.get(name="downloadguidelines", pattern="/organizations/downloadguidelines/", controller="organizations", action="downloadguidelines")
			.get(name="downloadmembers", pattern="/organizations/downloadmemberchurches/", controller="organizations", action="downloadMemberChurches")
			.get(name="downloadMemberChurchesForBrotherhoodPreview", pattern="/organizations/brotherhood/preview/", controller="organizations", action="downloadMemberChurchesForBrotherhood")
			.get(name="downloadMemberChurchesForBrotherhood", pattern="/organizations/brotherhood/[key]", controller="organizations", action="downloadMemberChurchesForBrotherhood")
			.get(name="downloadMemberChurchesForBrotherhood", pattern="/brotherhood/[key]", action="downloadMemberChurchesForBrotherhood")
			.get(name="updatelinks", pattern="/organizations/updatelinks/", controller="organizations", action="updatelinks")
			.get(name="yellowpages", pattern="/organizations/yellowpages/", controller="organizations", action="yellowpages")
			.get(name="prayerlist", pattern="/organizations/prayerlist/", controller="organizations", action="prayerlist")
			.get(name="distribution", pattern="/organizations/distribution/", controller="organizations", action="distribution")
			.resources("organizations")

			.get(name="addstaff", pattern="/people/addstaff/[key]", controller="people", action="addstaff")
			.get(name="viewperson", pattern="/people/[key]/view", controller="people", action="view")
			.get(name="setreview", pattern="/people/setreview/[key]", controller="people", action="setReview")
			.get(name="vcard", pattern="/people/vcard/[key]", controller="people", action="vcard")
			.get(name="bluepages", pattern="/people/bluepages/", controller="people", action="bluepages")
			.get(name="downloadagbm", pattern="/people/downloadagbm/", controller="people", action="downloadagbm")
			.get(name="distribution", pattern="/people/distribution/", controller="people", action="distribution")
			.get(name="birthdays", pattern="/people/dates", controller="people", action="dates")
			.get(name="datesByAge", pattern="/people/dates/byage/", controller="people", action="datesByYear")
			.get(name="sendEmailToPeople", pattern="/people/sendemail/", controller="people", action="sendToHandbookPeople")
			.resources("people")

			.resources("personUpdates")

			.get(name="setPictureAsDefault", pattern="/pictures/setdefault/[key]", controller="pictures", action="
			setpictureasdefault")
			.resources("pictures")

			.resources("prayers")
			.resources("profiles")

			.get(name="liststatistics", pattern="/handbook/stats/", controller="statistics", action="welcome")
			.get(name="deliquencies", pattern="/stats/deliquent/", controller="statistics", action="delinquent")
			.get(name="allCurrentKey", pattern="'stats/allCurrent/[key]", controller="statistics", action="allCurrent")
			.get(name="allCurrent", pattern="'stats/allCurrent/", controller="statistics", action="allCurrent")
			.resources("statistics")

			.get(name="Searchtags", pattern="/tags/search/", controller="tags", action="search")
			.get(name="removeTags", pattern="/tags/remove/", controller="tags", action="removeFromTag")
			.resources("tags")

			.get(name="deletesubscribe", pattern="/subscribes/[key]/delete/", controller="subscribes", action="delete")
			.get(name="subscribeMe", pattern="/subscribeme/", controller="subscribes", action="updates")
			.get(name="unSubscribeMe", pattern="/unsubscribeme/[key]", controller="subscribes", action="unsubscribe")
			.get(name="subscribeMeDates", pattern="/subscribemedates/", controller="subscribes", action="subscribeToDates")
			.get(name="sendTodaysDates", pattern="/subscribes/sendTodaysDates/[key]", controller="subscribes", action="sendTodaysDates")
			.get(name="sendTodaysPrayerReminders", pattern="/subscribes/sendTodaysPrayerReminders/[key]", controller="subscribes", action="sendTodaysPrayerReminders")
			.get(name="sendThisWeeksPrayerReminders", pattern="/subscribes/sendThisWeeksPrayerReminders/[key]", controller="subscribes", action="sendThisWeeksPrayerReminders")
			.resources("subscribes")

			.get(name="hits", pattern="/updates/hits/", controller="updates", action="hits")
			.resources("updates")

			.get(name="unlockLink", pattern="/unlock/", controller="welcome", action="welcome")
			.get(name="unlockLinkfor", pattern="/unlock/[key]", controller="welcome", action="welcome")
			.resources("welcome")

			.get(name="addstaffandposition", pattern="/positions/new/", controller="positions", action="new")
			.get(name="addnewposition", pattern="/positions/new/[key]", controller="positions", action="new")
			.post(name="createnewposition", pattern="/positions/create/", controller="positions", action="create")
			.resources("positions")

   			.get(name="handbookaddpayment", pattern="/handbook/add/[key]", controller="handbook.agbmInfo", action="add")
		.end()

		.namespace("focus")
			.resources("contents")
			.resources("invoices")
			.get(name="deleteitem", pattern="/items/[key]/delete/", controller="items", action="delete")
			.get(name="copyitem", pattern="/items/[key]/copy", controller="items", action="copy")
			.resources("items")
			.resources("main")
			.resources("registrants")
			.get(name="deleteregistration", pattern="/registrations/[key]/delete/", controller="registrations", action="delete")
			.get(name="deleteretreat", pattern="/retreat/[key]/delete/", controller="retreats", action="delete")
			.resources("registrations")
			.resources("retreats")
			.resources("shoppingcarts")
			.get(name="shoppingcartagent", pattern="/shoppingcarts/agent/[key]", controller="shoppingcarts", action="agent")
			.resources("testmonies")
			.get(name="showRetreat", pattern="/retreat/[key]", controller="main", action="retreat")
			.root(controller="main", action="welcome")
		.end()

		.namespace("conference")
			.resources("backups")
			.resources("contents")
			.resources("errors")
			.resources("events")

			.get(name="newexhibitform", pattern="/exhibit/", controller="exhibits", action="new")
			.get(name="deleteexhibits", pattern="/exhibits/[key]/delete", controller="exhibits", action="delete")
			.resources("exhibits")
			
			.resources("families")
			
			.get(name="showinvoice", pattern="/invoice/[key]", controller="invoices", action="show")
			.resources("invoices")
			.resources("locations")
			.resources("main")
			.resources("options")
			.resources("people")
			
			.get(name="registration", pattern="/registration/", controller="register", action="welcome")
			.get(name="register", pattern="/register/", controller="register", action="welcome")
			.get(name="deleteregistration", pattern="/registrations/[key]/delete", controller="registrations", action="delete")
			.get(name="showregistration", pattern="/registrations/[key]", controller="registrations", action="show")
			.resources("registrations")
			
			.resources("resources")

			.get(name="conferenceworkshops", pattern="/workshops/", controller="courses", action="workshops")
			.get(name="conferenceworkshopstable", pattern="/workshops/table/", controller="courses", action="workshopstable")
			.get(name="conferenceriscurions", pattern="/riscursions/", controller="courses", action="riskursions")
			.get(name="conferenceriskurions", pattern="/riskursions/", controller="courses", action="riskursions")
			.get(name="conferenceworkshopsrss", pattern="/workshops/rss/", controller="courses", action="rss")
			.get(name="selectworkshopperson", pattern="/select/[type]/", controller="courses", action="selectworkshops")
			.get(name="selectworkshop", pattern="/select/[type]/[personid]", controller="courses", action="selectworkshops")

			.get(name="addOptions", pattern="/register/addOptions/[key]", controller="register", action="startFamilyRegs")
			.get(name="payinvoice", pattern="/payinvoice", controller="register", action="payExistingInvoiceOnline")
			.get(name="selectregtype", pattern="/register/selectregtype/", controller="register", action="selectregtype")
			.get(name="selectoptions", pattern="/register/selectoptions/", controller="register", action="selectoptions")
			.post(name="createCartItemsFromForm", pattern="/register/createCartItemsFromForm/", controller="register", action="createCartItemsFromForm")
			.post(name="addPersonToRegCart", pattern="/register/addPersonToRegistrationCart/", controller="register", action="addPersonToRegistrationCart")
			.get(name="showRegs", pattern="/register/showregs/", controller="register", action="showregs")
			.get(name="registerPerson", pattern="/register/person/", controller="register", action="person")
			.get(name="postCarts", pattern="/register/postCarts/", controller="register", action="postCarts")
			.get(name="getAgent", pattern="/register/getAgent/", controller="register", action="getAgent")
			.post(name="saveAgent", pattern="/register/saveAgent/", controller="register", action="saveAgent")
			.get(name="payonline", pattern="/register/payonline/", controller="register", action="payonline")

			.get(name="survey", pattern="/survey/", controller="surveys", action="new")
			.get(name="surveyresults", pattern="/surveyresults/", controller="surveys", action="report")
			.get(name="comments", pattern="/comments/", controller="surveys", action="comments")

			.get(name="lodgingrequest", pattern="/lodgingrequest/[key]", controller="lodgingrequests", action="new")
			.get(name="lodgingrequest", pattern="/lodgingrequest/", controller="lodgingrequests", action="new")
			.get(name="lodgingrequests", pattern="/lodgingrequests/", controller="lodgingrequests", action="index")
		.end()

		.namespace("membership")
			.resources("applications")
			.resources("delegates")
			.get(name="newchurches", pattern="/newchurches/", controller="newchurches", action="index")
			.get(name="shownewchurch", pattern="/newchurch/[key]", controller="newchurches", action="show")
			.get(name="editnewchurch", pattern="/newchurch/[key]/edit", controller="newchurches", action="edit")
			.get(name="checkin", pattern="/newchurch/checkin/", controller="newchurches", action="checkin")
			.post(name="createBlankForm", pattern="/newchurches/createBlankForm/", controller="newchurches", action="createBlankForm")
			.get(name="emailSent", pattern="/newchurches/emailsent/", controller="newchurches", action="emailsent")
			.get(name="newministries", pattern="/newministries/", controller="newministries", action="index")
		.end()

		.namespace("forums")
			.get(name="login", pattern="/[groupcode]", controller="posts", action="login")
			.get(name="show", pattern="/page/[key]", controller="posts", action="show")
			.root(controller="posts", action="login")
		.end()

		.get(name="showpage", pattern="page/[key]", controller="contents", action="show")
		.get(name="contactus", pattern="/contactus", controller="messages", action="new")
		.get(name="questions", pattern="/questions", controller="messages", action="cci_new")
		.get(name="conferencereg", pattern="/conference", controller="conference.register", action="welcome")
        .get(name="conferencemyreg", pattern="/conference/myregs/", controller="conference.users", action="my-regs")
		.get(name="conferenceregsummary", pattern="/conference/summary/", controller="conference.registrations", action="summary")
		.get(name="handbook", pattern="/handbook", controller="handbook.welcome", action="index")
		.get(name="reviewhandbook", pattern="/reviewhandbook/[orgid]", controller="handbook.welcome", action="review")
		.get(name="myhandbook", pattern="/myhandbook/[key]", controller="handbook.welcome", action="welcome")
		.put(name="putreviewhandbook", pattern="/reviewhandbook/[orgid]", controller="handbook.welcome", action="review")
		.get(name="application", pattern="/application/[key]", controller="membership.applications", action="checkin")
		.get(name="application", pattern="/application", controller="membership.applications", action="checkin")
		.get(name="applications", pattern="/applications", controller="membership.applications", action="index")
		.get(name="page", pattern="/page/[key]", controller="contents", action="show")
		.get(name="delegate", pattern="/delegate", controller="membership.delegates", action="new")
		.get(name="delegates", pattern="/delegates", controller="membership.delegates", action="index")
		.get(name="senddelegates", pattern="/senddelegates/", controller="membership.delegates", action="submit")
		.get(name="sendmydelegates", pattern="/senddelegates/[key]", controller="membership.delegates", action="submit")
		.get(name="nominate", pattern="/nominate", controller="membership.nominations", action="new")
		.get(name="nominations", pattern="/nominations/", controller="membership.nominations", action="list")
		.get(name="showInvoice", pattern="/invoice/[key]", controller="conference.invoices", action="show")
		.get(name="showInvoiceByEmail", pattern="/invoice/", controller="conference.invoices", action="show")
		.get(name="agbm", pattern="/agbm/", controller="home", action="agbm")
		.get(name="agbminfo", pattern="/handbook-agbm/index/", controller="handbook.agbminfo", action="index")
		.get(name="sendhandbook", pattern="/sendhandbook/[key]", controller="handbook.people", action="sendhandbook")
		.get(name="about", pattern="/about/", controller="about", action="ourStory")
		.get(name="editnewchurch", pattern="/newchurch/[key]", controller="membership.newchurches", action="edit")
		.get(name="newchurch", pattern="/newchurch/", controller="membership.newchurches", action="checkin")
		.get(name="newchurches", pattern="/newchurches/", controller="membership.newchurches", action="index")
		.get(name="newministries", pattern="/newministries/", controller="membership.newministries", action="index")
		.get(name="newministry", pattern="/newministry/", controller="membership.newministries", action="new")
		.get(name="coopministry", pattern="/coopministry/", controller="membership.newministries", action="new")
		.get(name="sendstatspick", pattern="/sendstats/", controller="handbook.statistics", action="submit")
		.get(name="sendstats", pattern="/sendstats/[key]", controller="handbook.statistics", action="submit")
		.get(name="selectpersonselectworkshops", pattern="/selectworkshops/", controller="conference.courses", action="selectworkshops")
		.get(name="selectpersonselectcohorts", pattern="/selectcohorts/", controller="conference.courses", action="selectworkshops")
		.get(name="selectworkshops", pattern="/selectworkshops/[personid]", controller="conference.courses", action="selectWorkshops")
		.get(name="selectcohorts", pattern="/selectcohorts/[personid]", controller="conference.courses", action="selectCohorts")
		.get(name="mycohorts", pattern="/mycohorts/", controller="conference.courses", action="showSelectedWorkshops")
		.get(name="accesscohorts", pattern="/accesscohorts/", controller="conference.courses", action="listCohorts")
		.get(name="listcohorts", pattern="/listcohorts/", controller="conference.courses", action="listCohorts")
		.get(name="cohorts", pattern="/cohorts/", controller="conference.courses", action="listCohorts")
		.get(name="flinchconference", pattern="/flinchconference/", controller="conference.flinch", action="index")
		.get(name="agbmrss", pattern="/agbm/rss/", controller="handbook.agbm-info", action="rss")
		.get(name="agbmjson", pattern="/agbm/json/", controller="handbook.agbm-info", action="json")
		.get(name="jsonmeals", pattern="/api/conference/meals/", controller="conference.options", action="jsonmeals")
		.get(name="jsonmeal", pattern="/api/conference/meals/[id]", controller="conference.options", action="jsonmeals")
		.get(name="generalinfo", pattern="/api/conference/info/", controller="conference.events", action="generalInfo")
		.get(name="childcareworkers", pattern="/gracekidshelper/", controller="conference.childcareworkers", action="new")
		.get(name="agbmmembership", pattern="/agbm/membership/", controller="handbook.agbm-info", action="publiclist")
		.get(name="myhandbook", pattern="/myhandbook/", controller="handbook.welcome", action="myhandbook")
		.get(name="apiChurches", pattern="/api/churches/", controller="handbook.organizations", action="findChurches")
		.get(name="apiChurch", pattern="/api/church/[key]", controller="handbook.organizations",
		 action="findChurchWithStaff")
		.get(name="apiAgbmRegion", pattern="/api/agbmregions/[key]", controller="handbook.agbmregions",
		 action="agbmregionasjson")
		.get(name="apiAgbmRegions", pattern="/api/agbmregions/", controller="handbook.agbmregions",
		 action="agbmregionsasjson")
		.get(name="apiAgbmRegion", pattern="/api/agbmregions/[key]", controller="handbook.agbmregions",
		 action="agbmregionasjson")
		.get(name="apiAgbmRep", pattern="/api/agbmrep/[key]", controller="handbook.agbmregions",
		 action="agbmrep")
		.get(name="apiAgbmMembers", pattern="/api/agbmmembers/", controller="handbook.agbm-info",
		 action="json")
		.get(name="apiStaff", pattern="/api/staff/[key]", controller="handbook.people", action="findStaff")
		.get(name="apiAllStaff", pattern="/api/staff/", controller="handbook.people", action="findAllStaff")
		.get(name="apiMinistries", pattern="/api/ministries/", controller="handbook.organizations", action="findMinistries")
		.get(name="apiMinistry", pattern="/api/ministry/[key]", controller="handbook.organizations", action="findChurchWithStaff")
		.get(name="apiCourses", pattern="/api/courses/", controller="conference.courses", action="json")
		.get(name="apiAnnouncements", pattern="/api/announcements/", controller="conference.announcements", action="list")
		.get(name="apiAnnouncement", pattern="/api/announcements/[key]", controller="conference.announcements", action="list")
		.post(name="apiAnnouncementPost", pattern="/api/announcement/post", controller="conference.announcements", action="submit")
		.get(name="apiSchedule", pattern="/api/schedule/", controller="conference.events", action="listScheduleAsJson")
		.get(name="apiScheduleItem", pattern="/api/schedule/[ID]", controller="conference.events", action="listScheduleAsJson")
		.get(name="apiMeals", pattern="/api/meals/", controller="conference.options", action="jsonmeals")
		.get(name="apiMeal", pattern="/api/meals/[ID]", controller="conference.events", action="listMealsAsJson")
		.get(name="apiWorkshops", pattern="/api/workshops/", controller="conference.events", action="listMealsAsJson")
		.get(name="apiWorkshop", pattern="/api/workshops/[ID]", controller="conference.events", action="listMealsAsJson")
		.get(name="apiInstructors", pattern="/api/instructors/", controller="conference.instructors", action="listInstructorsAsJson")
		.get(name="apiInstructorsForThisCourse", pattern="/api/instructors/[courseid]", controller="conference.instructors", action="listInstructorsAsJson")
		.get(name="apiGeneralConferenceInfo", pattern="/api/conference/information/", controller="admin.contents", action="conferenceInformationAsJson")
		.get(name="apiSpeakers", pattern="/api/speakers/", controller="conference.instructors", action="listSpeakersAsJson")
		.get(name="apiSpeakers", pattern="/api/speakers/[ID]", controller="conference.instructors", action="listSpeakersAsJson")
		.get(name="apiCrudAnswer", pattern="/api/crud/[id]", controller="crud", action="showjson")
		.get(name="apiCrudAnswerEdit", pattern="/api/crud/[ID]/edit", controller="crud", action="edit")
		.get(name="apiCrudAnswers", pattern="/api/crud/", controller="crud", action="list")
		.post(name="apiCrudAnswerSubmit", pattern="/api/crud/", controller="crud", action="submit")
		.delete(name="apiCrudAnswerDelete", pattern="/api/crud/[id]", controller="crud", action="delete")
		.get(name="handbookdistricts", pattern="/handbook-districts/show/[key]", controller="handbook.districts", action="show")
		.get(name="handbook-subscribes", pattern="/handbook-subscribes/subscribeToDates", controller="handbook.subscribes", action="subscribeToDates")
		.get(name="handbook-people", pattern="/handbook-people/show/[key]", controller="handbook.people", action="show")
		.get(name="handbook-people", pattern="/handbook-welcome/welcome/[key]", controller="handbook.welcome", action="welcome")
		.get(name="handbook-people-index", pattern="/handbook-people/index", controller="handbook.welcome", action="welcome")
		.get(name="handbookindex", pattern="/handbook/index", controller="handbook.welcome", action="checkin")
		.get(name="homewelcome", pattern="/home/welcome", controller="home", action="index")
		.get(name="handbook-welcome", pattern="/handbook-welcome/checkin", controller="handbook.welcome", action="checkin")
		.get(name="handbook-loginform", pattern="/handbook-welcome/login-form", controller="handbook.welcome", action="login-form")
		.get(name="freelodging", pattern="/ifeelgood", controller="conference.lodgingrequests", action="new")
		.get(name="access2017", pattern="/access2017", controller="conference.register", action="welcome")
		.get(name="cci", pattern="/cci", controller="about", action="cci")
		.get(name="ccci", pattern="/ccci", controller="about", action="cci")
		.get(name="ccm", pattern="/ccm", controller="about", action="commonCommitment")
		.get(name="cccm", pattern="/cccm", controller="about", action="commonCommitment")
		.get(name="ouridentity", pattern="/ouridentity", controller="about", action="cci")
		.get(name="newname", pattern="/newname", controller="contents", action="newname")
		.get(name="newnameQA", pattern="/newnameQA", controller="contents", action="newnameQA")
		.get(name="statementoffaith", pattern="/statementoffaith", controller="contents", action="statementoffaith")
		.get(name="manualofprocedure", pattern="/manualofprocedure", controller="contents", action="manualofprocedure")
		.get(name="forAttendifyJson", pattern="/conference.attendify/schema", controller="conference.attendify", action="json")
		.get(name="constitution", pattern="/constitution", controller="contents", action="constitution")
		.get(name="churches", pattern="/churches", controller="churches", action="index")
		.root(controller="Home", action="index")
		.wildcard()

	.end();
</cfscript>
