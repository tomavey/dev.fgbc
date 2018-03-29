<!---
	Here you can add routes to your application and edit the default one.
	The default route is the one that will be called on your application's "home" page.
<cfset addRoute(name="home", pattern="", controller="home", action="index")>
	Routes are not cascading, the first pattern that applied is used.
	So put routes with [key] before the same route without.
	So put specific routes before "resource()" routes
--->
<cfscript>
	drawRoutes()

		.namespace("admin")
			.get(name="copy", pattern="/announcement/[key]/copy/", controller="announcements", action="copy")
			.get(name="rss", pattern="/announcements/rss/", controller="announcements", action="rss")
			.resources("announcements")

			.resources("blogs")
			.resources("contents")

			.get(name="copySettings", pattern="/settings/copy/[key]", controller="settings", action="copy")
			.resources("settings")

			.controller("events")
				.get(name="copyEvent", pattern="/copy/[key]", action="copy")
				.end()
			.resources("events")
			.resources("jobs")
			.resources("menus")
			.resources("messages")
			.resources("settings")

			.get(name="listMinistries", pattern="/ministries/list/", controller="ministries", action="list")
			.get(name="simpleListMinistries", pattern="/ministries/simplelist/", controller="ministries", action="simplelist")
			.resources("ministries")
			.resources("resources")
		.end()

		.namespace("auth")
			.post(name="CheckLogin", pattern="/users/checklogin/", controller="users", action="checklogin")
			.get(name='LogoutUser', pattern="/users/logout", controller="users", action="logout")
			.get(name='NewUser', pattern="/users/new", controller="users", action="new")
			.get(name='ForgotPassword', pattern="/users/get-email-for-change-password-link/", controller="users", action="get-email-for-change-password-link")
			.get(name="thankyou", pattern="/users/thankyou", controller="users", action="thankYou")
			.get(name="loginAsUser", pattern="users/loginAsUser", controller="users", action="loginAsUser")
			.get(name="emailSent", pattern="/users/emailSent", controller="users", action="emailSent")
			.get(name="changePassword", pattern="/users/changePassword/[key]", controller="users", action="changePassword")
			.post(name="getPassword", pattern="/users/EmailChangePasswordLink/", controller="users", action="EmailChangePasswordLink")
			.post(name="searchUsers", pattern="/users/search/", controller="users", action="search")
			.get(name="loginAsUaser", pattern="/users/loginAsUser/", controller="users", action="loginAsUser")
			.post(name="addToGroup", pattern="/users/addToGroup/[key]", controller="users", action="addToGroup")
			.put(name="addToGroup", pattern="/users/addToGroup/[key]", controller="users", action="addToGroup")
			.get(name="addToGroup", pattern="/users/addToGroup/[key]", controller="users", action="addToGroup")
			.get(name="removeFromGroup", pattern="/users/removeFromGroup/", controller="users", action="removeFromGroup")
			.get(name="reCheckLogin", pattern="/users/checkLogin/", controller="users", action="loginform")
			.resources("users")

			.post(name="addARight", pattern="/groups/addARight/[key]", controller="groups", action="addARight")
			.get(name="removeRight", pattern="/groups/removeRight/", controller="groups", action="removeRight")
			.resources("groups")

			.resources("rights")
		.end()

		.namespace("handbook")
			.get(name="downloadmemberchurchesadmin", pattern="/admin/downloadmemberchurches/[key]", controller="admin", action="downloadMemberChurches")
			.get(name="downloadmemberchurchesadmin", pattern="/admin/downloadmemberchurches/", controller="admin", action="downloadMemberChurches")
			.resources("admin")
			.resources("agbm")

			.get(name="addAGBMPayment", pattern="/agbminfo/add/[key]", controller="AgbmInfo", action="add")
			.get(name="agbmList", pattern="/agbmInfo/list/", controller="agbmInfo", action="list")
			.get(name="list", pattern="/agbmInfo/handbook/", controller="agbmInfo", action="handbook")
			.get(name="dashboard", pattern="/agbmInfo/dashboard/", controller="agbmInfo", action="dashboard")
			.get(name="pastorsNotAgbm", pattern="/agbmInfo/pastorsnotagbm/", controller="agbmInfo", action="pastorsnotagbm")
			.get(name="AgbmDelinquent", pattern="/agbmInfo/delinquent/", controller="agbmInfo", action="delinquent")
			.get(name="AgbmRss", pattern="/agbmInfo/rss/", controller="agbmInfo", action="rss")
			.get(name="MembershipReport", pattern="/agbmInfo/handbookMembershipReport/", controller="agbmInfo", action="handbookMembershipReport")
			.get(name="setYear", pattern="/agbmInfo/setyear/[key]", controller="agbmInfo", action="setyear")
			.get(name="AgbmRegions", pattern="/agbmregions/", controller="agbmregions", action="index")
			.post(name="searchAgbm", pattern="/agbminfo/list/", controller="agbmInfo", action="list")
			.get(name="agbmLogout", pattern="/agbmInfo/logout/",controller="agbmInfo", action="logout")
			.get(name="publicList", pattern="/agbm/", controller="agbmInfo", action="publicList")
			.resources("agbmInfo")

			.resources("agbmregions")

			.get(name="districtsReport", pattern="/districts/report/", controller="districts", action="handbookreport")
			.get(name="districtChurches", pattern="/districts/churches", controller="districts", action="listChurches")
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
			.get(name="organiztionDistribution", pattern="/organizations/distribution/", controller="organizations", action="distribution")
			.get(name="grouproster", pattern="/grouproster/", controller="organizations", action="groupRoster")
			.get(name="pages", pattern="/pages/[key]", controller="organizations", action="show")
			.get(name="organizationsReview", pattern="/organizations/review/", controller="organizations", action="handbookReviewOptions")
			.get(name="memberList", pattern="/membershipList/", controller="organizations", action="memberChurches")
			.resources("organizations")

			.get(name="addstaff", pattern="/people/addstaff/[key]", controller="people", action="addstaff")
			.get(name="viewperson", pattern="/people/[key]/view", controller="people", action="view")
			.get(name="setreview", pattern="/people/setreview/[key]", controller="people", action="setReview")
			.get(name="vcard", pattern="/people/vcard/[key]", controller="people", action="vcard")
			.get(name="bluepages", pattern="/people/bluepages/", controller="people", action="bluepages")
			.get(name="downloadagbm", pattern="/people/downloadagbm/", controller="people", action="downloadagbm")
			.get(name="peopleDistribution", pattern="/people/distribution/", controller="people", action="distribution")
			.get(name="birthdays", pattern="/people/dates", controller="people", action="dates")
			.get(name="datesByAge", pattern="/people/dates/byage/", controller="people", action="datesByYear")
			.get(name="sendEmailToPeople", pattern="/people/sendemail/", controller="people", action="sendToHandbookPeople")
			.get(name="peopleReview", pattern="/people/review/", controller="people", action="handbookReviewOptions")
			.get(name="clearSendHandbook", pattern="/people/clearSendHandbook/", controller="people", action="clearSendHandbooks")
			.get(name="focusMailingList", pattern="/people/focus/[key]", controller="people", action="focus")
			.resources("people")

			.resources("personUpdates")

			.get(name="setPictureAsDefault", pattern="/pictures/setdefault/[key]", controller="pictures", action="
			setpictureasdefault")
			.get(name="getPerson", pattern="/pictures/getperson", controller="pictures", action="getperson")
			.resources("pictures")

			.resources("prayers")
			.resources("profiles")

			.get(name="liststatistics", pattern="/handbook/stats/", controller="statistics", action="welcome")
			.get(name="deliquencies", pattern="/stats/deliquent/", controller="statistics", action="delinquent")
			.get(name="allCurrent", pattern="/stats/allCurrent/", controller="statistics", action="allCurrent")
			.get(name="allCurrentKey", pattern="/stats/allCurrent/[key]", controller="statistics", action="allCurrent")
			.get(name="allCurrentNotPaid", pattern="/stats/allCurrentNotPaid/", controller="statistics", action="allCurrentNotPaid")
			.get(name="emailAllCurrentNotPaid", pattern="/stats/emailAllCurrentNotPaid/", controller="statistics", action="emailAllCurrentNotPaid")
			.get(name="statsSummary", pattern="/statistics/getSummary/[key]", controller="statistics", action="getSummary")
			.get(name="churchGrowth", pattern="/statistics/churchgrowth/", controller="statistics", action="churchgrowth")
			.get(name="statsHistory", pattern="/statistics/history/", controller="statistics", action="stathistory")
			.get(name="statusChanged", pattern="/status/changed/", controller="statistics", action="closedshurches")
			.get(name="statsProjection", pattern="/stats/projection/", controller="statistics", action="getfee")
			.get(name="statsSize", pattern="/statistics/size/[key]", controller="statistics", action="sizeByPercent")
			.get(name="getChurchId", pattern="/statistics/getChurchid/", controller="statistics", action="getChurchid")
			.post(name="paystatsonline", pattern="/statistics/payonline/", controller="statistics", action="payonline")
			.get(name="paystatsonline2", pattern="/statistics/payonline/", controller="statistics", action="payonline")
			.get(name="confirmPayment", pattern="/statistics/confirm/", controller="statistics", action="confirm")
			.get(name="failedPayment", pattern="/statistics/paymentfailed/", controller="statistics", action="paymentfailed")
			.post(name="feeProjection", pattern="/statistics/projection/", controller="statistics", action="getFeeTotal")
			.resources("statistics")

			.get(name="Searchtags", pattern="/tags/search/", controller="tags", action="search")
			.post(name="Searchtags", pattern="/tags/search/", controller="tags", action="search")
			.get(name="removeFromTag", pattern="/tags/remove/", controller="tags", action="removeFromTag")
			.get(name="removeTag", pattern="/tag/remove/[key]", controller="tags", action="removeTag")
			.get(name="downloadTag", pattern="/tag/download/[key]", controller="tags", action="download")
			.get(name="duplicateTag", pattern="/tag/duplicate/[key]", controller="tags", action="duplicateTag")
			.post(name="changeTag", pattern="/tag/change/", controller="tags", action="changeTag")
			.post(name="shareTag", pattern="/tag/share/", controller="tags", action="shareTag")
			.post(name="tagSearchResults", pattern="/tagthissearch/", controller="tags", action="search")
			.resources("tags")

			.get(name="subscribeMe", pattern="/subscribeme/", controller="subscribes", action="updates")
			.get(name="unSubscribeMe", pattern="/unsubscribeme/[key]", controller="subscribes", action="unsubscribe")
			.get(name="subscribeMeDates", pattern="/subscribemedates/", controller="subscribes", action="subscribeToDates")
			.get(name="sendTodaysDates", pattern="/subscribes/sendTodaysDates/", controller="subscribes", action="sendTodaysDates")
			.get(name="sendTodaysPrayerReminders", pattern="/subscribes/sendTodaysPrayerReminders/", controller="subscribes", action="sendTodaysPrayerReminders")
			.get(name="sendThisWeeksPrayerReminders", pattern="/subscribes/sendThisWeeksPrayerReminders/", controller="subscribes", action="sendThisWeeksPrayerReminders")
			.get(name="sendYesterdaysUpdates", pattern="/sendYesterdaysUpdates/", controller="subscribes", action="sendYesterdaysUpdates")
			.get(name="sendVerificationToAdmin", pattern="/sendVerificationToAdmin/", controller="subscribes", action="sendVerificationToAdmin")
			.resources("subscribes")

			.get(name="hits", pattern="/updates/hits/", controller="updates", action="hits")
			.resources("updates")

			.get(name="unlockLink", pattern="/unlock/", controller="welcome", action="welcome")
			.get(name="unlockLinkfor", pattern="/unlock/[key]", controller="welcome", action="welcome")
			.get(name="logout", pattern="/logout/", controller="welcome", action="logout")
			.get(name="login", pattern="/login/", controller="welcome", action="loginForm")
			.post(name="sendlink", pattern="/sendLink/", controller="welcome", action="sendLink")
			.get(name="help", pattern="/help/", controller="welcome", action="help")
			.resources("welcome")

			.get(name="addstaffandposition", pattern="/positions/new/", controller="positions", action="new")
			.get(name="addnewposition", pattern="/positions/new/[key]", controller="positions", action="new")
			.get(name="listPeople", pattern='/positions/listpeople/', controller="positions", action="listpeople")
			.post(name="createnewposition", pattern="/positions/create/", controller="positions", action="create")
			.resources("positions")

   			.get(name="handbookaddpayment", pattern="/handbook/add/[key]", controller="handbook.agbmInfo", action="add")
		.end()

		.namespace("focus")
			.resources("contents")

			.get(name="payonline", pattern="/payonline/[key]", controller="invoices", action="payonline")
			.get(name="agent", pattern="/agent/", controller="invoices", action="agent")
			.get(name="confirm", pattern="/confirm/", controller="invoices", action="confirm")
			.get(name="thankyou", pattern="/thankyou/[key]", controller="invoices", action="thankyou")
			.resources("invoices")
			
			.get(name="deleteitem", pattern="/items/[key]/delete/", controller="items", action="delete")
			.get(name="copyitem", pattern="/items/[key]/copy", controller="items", action="copy")
			.resources("items")
			
			.get(name="deleteregistration", pattern="/registrations/[key]/delete/", controller="registrations", action="delete")
			.get(name="whoIsComing", pattern="/registrations/whoiscoming/[key]", controller="registrations", action="whoiscoming")
			.get(name="summary", pattern="/registrations/summary/", controller="registrations", action="summary")
			.get(name="list", pattern="/registrations/list/", controller="registrations", action="list")
			.resources("registrations")
						
			.resources("registrants")
			
			.get(name="showRetreat", pattern="/retreat/[key]", controller="main", action="retreat")
			.get(name="deleteretreat", pattern="/retreat/[key]/delete/", controller="retreats", action="delete")
			.resources("retreats")
			
			.get(name="shoppingcartagent", pattern="/shoppingcarts/agent/[key]", controller="shoppingcarts", action="agent")
			.post(name="checkout", pattern="/shoppingcarts/checkout/[key]", controller="shoppingcarts", action="checkout")
			.resources("shoppingcarts")
			
			.resources("testmonies")

			.get(name="thisRetreat", pattern="/[key]", controller="main", action="retreat")
			.get(name="welcome", pattern="", controller="main", action="welcome")
			.get(name="about", pattern="/about/", controller="main", action="about")
			.resources("main")

		.end()

		.namespace("conference")
			.resources("backups")
			.resources("contents")
			.resources("errors")
			.resources("events")
			.resources("age_ranges")

			.get(name="newexhibitform", pattern="/exhibit/", controller="exhibits", action="new")
			.get(name="deleteexhibits", pattern="/exhibits/[key]/delete", controller="exhibits", action="delete")
			.get(name="exhibitsinfo", pattern="/exhibits/info/", controller="exhibits", action="info")
			.get(name="exhibitsthankyou", pattern="/exhibits/thankyou/[key]", controller="exhibits", action="thankyou")
			.resources("exhibits")
			
			.resources("families")
			
			.get(name="showinvoice", pattern="/invoice/[key]", controller="invoices", action="show")
			.resources("invoices")
			.resources("locations")
			.resources("main")
			
			.get(name="copyOption", pattern="/options/copy/[key]", controller="options", action="copy")
			.resources("options")
			.resources("people")

			.get(name="sendAnnouncement", pattern="/announcements/send/[key]", controller="announcements", action="sendAnnouncement")
			.resources("announcements")

			.controller("courses")
				.get(name="showAllSelected", pattern="showallselectedcohorts", controller="courses", action="showallselectedcohorts")
			.end()	
			.resources("courses")

			.get(name="listcoursequestions", pattern="/coursequestions/list/", controller="coursequestions", action="list")
			.resources("coursequestions")

			.get(name="sendEditEmail", pattern="/courseresources/sendEditEmail", controller="courseresources", action="sendEditEmail")
			.resources("courseresources")
			
			.get(name="registration", pattern="/registration/", controller="register", action="welcome")
			.get(name="register", pattern="/register/", controller="register", action="welcome")
			.get(name="changeSessionSettingsToPreviousConference", pattern="/changeSessionSettingsToPreviousConference/", controller="register", action="changeSessionSettingsToPreviousConference")
			.get(name="clearSessionSettingsForEvent", pattern="/clearSessionSettingsForEvent/", controller="register", action="clearSessionSettingsForEvent")

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
			.put(name="convertGroupRegToSingle", pattern="/register/groupRegConvertToSingle/", controller="register", action="groupRegConvertToSingle")
			.get(name="survey", pattern="/survey/", controller="surveys", action="new")
			.get(name="surveyresults", pattern="/surveyresults/", controller="surveys", action="report")
			.get(name="comments", pattern="/comments/", controller="surveys", action="comments")

			.get(name="lodgingrequest", pattern="/lodgingrequest/[key]", controller="lodgingrequests", action="new")
			.get(name="lodgingrequest", pattern="/lodgingrequest/", controller="lodgingrequests", action="new")
			.get(name="lodgingrequests", pattern="/lodgingrequests/", controller="lodgingrequests", action="index")
		.end()

		.namespace("membership")
			.get(name="step1", pattern="/step1/", controller="applications", action="step1")
			.get(name="step2", pattern="/step2/", controller="applications", action="step2")
			.get(name="step3", pattern="/step3/", controller="applications", action="step3")
			.get(name="step4", pattern="/step4/", controller="applications", action="step4")
			.get(name="step5", pattern="/step5/", controller="applications", action="step5")
			.get(name="step6", pattern="/step6/", controller="applications", action="step6")
			.get(name="step7", pattern="/step7/", controller="applications", action="step7")
			.get(name="about", pattern="/about/", controller="applications", action="about")
			.resources("applications")
			.resources("delegates")
			.get(name="newchurches", pattern="/newchurches/", controller="newchurches", action="index")
			.get(name="shownewchurch", pattern="/newchurch/[key]", controller="newchurches", action="show")
			.get(name="editnewchurch", pattern="/newchurch/[key]/edit", controller="newchurches", action="edit")
			.get(name="checkin", pattern="/newchurch/checkin/", controller="newchurches", action="checkin")
			.post(name="createBlankForm", pattern="/newchurches/createBlankForm/", controller="newchurches", action="createBlankForm")
			.get(name="emailSent", pattern="/newchurches/emailsent/", controller="newchurches", action="emailsent")
			.get(name="newministries", pattern="/newministries/", controller="newministries", action="index")
			.resources("questions")
			.resources("resources")
			.get(name="listAppResources", pattern="/listappresources/[key]", controller="resources", action="index")
			.delete(name="deleteAppResource", pattern="/deleteAppResource/[key]", controller="resources", action="delete")
			.get(name="nominateThankYou", pattern="/thankyou/[key]", controller="nominations", action="thankyou")
			.resources("nominations")
			.resources('newchurches')
			.get(name="nominationsClosed", pattern="nominationsclosed", controller="nominations", action="closed")
		.end()

		.namespace("forums")
			.get(name="login", pattern="/[groupcode]", controller="posts", action="login")
			.get(name="show", pattern="/page/[key]", controller="posts", action="show")
			.root(controller="posts", action="login")
		.end()

		.get(name="showpage", pattern="/page/[key]", controller="contents", action="show")
		.get(name="contactus", pattern="/contactus", controller="messages", action="new")
		.get(name="questions", pattern="/questions", controller="messages", action="cci_new")
		.get(name="conferencereg", pattern="/conference", controller="conference.register", action="welcome")
		.get(name="conferencereg2", pattern="/conference", controller="conference.-register", action="welcome")
		.get(name="conferencereg3", pattern="/conference.register", controller="conference.register", action="welcome")
        .get(name="conferencemyreg", pattern="/conference/myregs/", controller="conference.users", action="my-regs")
		.get(name="conferenceregsummary", pattern="/conference/summary/", controller="conference.registrations", action="summary")
		.get(name="handbook", pattern="/handbook", controller="handbook.welcome", action="index")
		.get(name="reviewhandbook", pattern="/reviewhandbook/[orgid]", controller="handbook.welcome", action="review")
		.get(name="myhandbook", pattern="/myhandbook/[key]", controller="handbook.welcome", action="welcome")
		.put(name="putreviewhandbook", pattern="/reviewhandbook/[orgid]", controller="handbook.welcome", action="review")
		.get(name="application", pattern="/application/[key]", controller="membership.applications", action="checkin")
		.get(name="application", pattern="/application", controller="membership.applications", action="checkin")
		.get(name="applications", pattern="/applications", controller="membership.applications", action="index")
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
		.get(name="fellowshipCouncilPages", pattern="/api/fellowshipcouncil/pages/", controller="fellowshipcouncil.Pages", action="index")
		.get(name="fellowshipCouncilPage", pattern="/api/fellowshipcouncil/page/[key]", controller="fellowshipcouncil.Pages", action="index")
		.get(name="handbookdistricts", pattern="/handbook-districts/show/[key]", controller="handbook.districts", action="show")
		.get(name="handbookpages", pattern="/handbookpages/[key]", controller="handbook.organizations", action="show")
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
		.get(name="access2018", pattern="/access2018", controller="conference.register", action="welcome")
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
		.get(name="newName", pattern="newname", controller="charis", action="rebranding")
		.root(controller="Home", action="index")
		.wildcard()

	.end();
</cfscript>
