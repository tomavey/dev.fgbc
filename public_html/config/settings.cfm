<!---DSN for database--->
<cfscript>
	set(dataSourceName="fgbc_main_3")
	if (cgi.http_host is "localhost:8080" || cgi.http_host is "localhost:8888" || cgi.http_host is "fgbc:8080" || cgi.http_host is "fgbc:8888") {
		set(dataSourceUserName="root");
		set(dataSourcePassword="j11itbwtw"); 
		set(OnLocalhost = "true");
	}
	else {
		set(dataSourceUserName="tomavey.fgbc");
		set(dataSourcePassword="Nd0pqKnihX6vhtw"); 
	}
</cfscript>

<!---Defaults for form helpers--->
	<cfset set(functionName="textField", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="passwordField", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="fileField", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="textArea", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="textFieldTag", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="checkBoxTag", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="radioButtonTag", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="selectTag", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="select", labelPlacement="before", prependToLabel="<p>", append="</p>")>
	<cfset set(functionName="timeSelect", labelPlacement="before", prependToLabel="<p>", append="</p>")>

<!---Settings for rewriting, reloading and errors--->
	<cfif cgi.http_host contains ":8080" || cgi.http_host contains ":8888">
        	<cfset set(URLRewriting="Off")>
	<cfelse>
	       <cfset set(URLRewriting="On")>
	       <cfset set(reloadPassword="mack")>
	</cfif>
	<cfset set(autologin=true)>

<!---Misc settings--->
	<cfset set(sendEmailOnError=false)>
	<cfset set(sendConferenceEmailOnError=false)>
	<cfset set(sendHandbookEmailOnError=false)>
	<cfset set(errorEmailAddress="tomavey@charisfellowship.us")>
	<cfset set(errorEmailSubject="charisfellowship.us error")>
	<cfset set(sendConferenceEmailOnError=true)>
	<cfset set(sendHandbookEmailOnError=true)>
	<cfset set(userAdminEmailAddress="tomavey@charisfellowship.us")>
	<cfset set(fileRef = "http://" & cgi.http_host & replace(cgi.script_name,"index.cfm","") & "files/")>
	<cfset addFormat(extension="js", mimeType="text/javascript")>
	<cfset set(goEMerchantId = "fellowshipofgracen")>
	<!---cfset set(obfuscateURLs=true)--->

<!---application.wheels Variables--->
	<cfset set(passwordKey="j316fgsltwj11itbwtwp16hwbagwiy")>
	<cfset set(oldself = "http://my.charisfellowship.us")>
	<cfset set(feedcount=9)>
	<cfset set(nominateYear = "2018")>
	<cfset set(nominateTerm = "2018-2023")>
	<cfset set(sortorderoptions = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,18,20,100,900,995,999")>
	<cfset set(registrarEmail="tomavey@charisfellowship.us,sharmion@charisfellowship.us")>
    <cfset set(ministryStaffAdmin="'tomavey','hirwin','skoontz'")>
	<cfset set(agbmDeadlineDate = "07-1-#year(now())#")>
	<cfset set(nonStaffSortOrder = 500)>
	<cfset set(churchStatusForHandbook = "1,4,8,9")>
	<cfset set(churchAndOrgStatusForHandbook = "1,4,8,9,10,11")>
	<cfset set(alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z")>
	<cfset set(delegateyear = "2016")>
	<cfset set(controllerlocation = "devwc.trunk.controllers.Controller")>
	<cfset set(memFee = 6.45)>
	<cfset set(lateMemFee = 6.95)>
	<cfset set(memFeeMax = 8300)>
	<cfset set(lateMemFeeMax = 8500)>
	<cfset set(memFeeDeadline = "2018-05-15")>

<!---used by handbook--->			 
	<cfset set(handbookRightsRequired = "handbook,office,superadmin,natmin,agbmadmin")>
	<cfset set(HandbookProfileSecretary="tomavey@charisfellowship.us")>
	<cfset set(showLinkToHandbookPageBefore = "11-1-#year(now())#")>
	<cfset set(sendHandbookDeadline = "January 5, 2018")>
	<cfset set(HandbookReviewSecretary = "Cassie Rayl <raylcassie@gmail.com>")>
	<cfset set(HandbookReviewSecretary2 = "Tom Avey <tomavey@charisfellowship.us>")>
	<cfset set(SendImmediatePersonUpdates = false)>
	<cfset set(ChurchHandbookReviewGreeting = "It's Time to Update the Charis Fellowship Handbook!")>
	<cfset set(PersonHandbookReviewGreeting = "It's Time to Update the Charis Fellowship Handbook!")>

<!---Used by Focus MVC--->
	<cfset set(registrant = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")>
	<cfset set(testAgents = "tomavey@charisfellowship.us,sharmion@charisfellowship.us,tomavey@fgbc.org")>
	<cfset set(mainregistrar = "sharmion@charisfellowship.us")>
	<cfset set(optionTypes = "Public,Discount,Office")>
	<cfset set(focusIsOpen = true)>
    <cfset set(focusMinistryAreas = "Lead Pastor, Executive Pastor, Worship Arts, Youth, Family, Children, Discipleship, Elder, Small Groups, Pastoral Care, Administration, Associate Pastor, Other")>
	<cfset set(byPassWords = "manual, comp, pending, paid")>

<!---Used by Conference Registration--->
	<cfset set(event="visionconference2018")>
	<cfset set(previousEvent = "visionconference2017")>
	<cfset set(nextEvent = "visionconference2019")>
	<cfset set(eventAsText = "Access2018")>
	<cfset set(previouseventAsText = "Access2017")>
	<cfset set(webpage = "http://www.access2018.com")>
	<cfset set(discountTypes = "dollar,percent,maximum")>
	<cfset set(dollar = "USD")>
	<cfset set(nameForCourse = "Cohort/Excursion/Workshop")>	
	<cfset set(nameForCourses = "Cohorts/Excursions/Workshops")>
	<cfset set(typesOfCourses = "Cohorts, Excursions, Workshops, Celebration")>	
	<cfset set(subTypesOfCourses = "A,B,C,D")>
	<cfset set(tracksOfCourses = listSort("Leadership Training,Church Planting,Integrated Ministry,Identity Initiative, Business Integration, Contemporary Theological Issues, Worship, Missional Living, Multi-site, France, Womens Studies, Prayer, Creativity,Other", "text"))>
	<cfset set(possibleAgentCodes = listSort("Comp,Manual,Prepaid,Test","text"))>
	<cfset set(sendEmailBeforePayment = false)>

<!---options used in dropdowns and menus--->
	<cfset set(typeOfOptions=listsort("Registration-Couple,Registration-Single,Registration-Group,Registration-Staff,Workshop,Meal,TouristOption,GraceKids-Nursery,GraceKids-Preschool,GraceKids-Elementary,GraceKidsSegments,GraceKidsExcursions,Other,Discount,AutoDiscount,InActive,preRegistration","text"))>
	<cfset set(typeOfRegOptions=listsort("Registration-Couple,Registration-Single,Registration-staff","text"))>
	<cfset set(typeOfAddRegOptions="'Registration-Couple','Registration-Single'")>
	<cfset set(typeOfPeople = "Adult,Spouse,ChildCare,KidsKonference")>
	<cfset set(sortOrdersAvailable = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27")>
	<cfset set(optionsCountAvailable = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30")>
	<cfset set(preRegCountAvailable = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30")>
	<cfset set(groupCountAvailable = "5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30")>
	<cfset set(eventDaysOptions="Monday,Tuesday,Wednesday,Thursday")>
	<cfset set(eventFirstDaysOptionsDate="2018-07-23")>
	<cfset set(eventCategories="Celebration,Workshop,Excursion,Roundtable,Network,Meal,ChildCare,Kids Konference,Reception,Board Meeting,Other,Office,Rehearsal,Exhibits,Prayer,Other-Public,Cohort")>
	<cfset set(eventCategoriesForJson="'meal','celebration','workshop','excursion','reception','prayer','other-public'")>
	<cfset set(ministryCategories=listSort("Church Planting Ministries, Communication, Districts, Doing Good, Leadership Training Ministries, none","text"))>

<!---email addresses used--->
	<cfset set(registrarEmail="sharmion@charisfellowship.us")>
	<cfset set(registrarEmailBackup="tomavey@charisfellowship.us")>
	<cfset set(requestInvoiceReceiptFrom = "sharmion@charisfellowship.us")>
	<cfset set(registrarBackupEmail="sharmion@charisfellowship.us")>
	<cfset set(housingCoordinatorEmail = "sharmion@charisfellowship.us")>
	<cfset set(childcarenotifications = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")>
	<cfset set(workshopnotifications = "tomavey@charisfellowship.us")>
	<cfset set(sendJobNoticesTo = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")>
	<cfset set(sendContactUsTo = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")>
<cfscript>
	set(focusForFinancialHelp="sharmion@charisfellowship.us")
</cfscript>

<!---What is open and what is not--->
	<cfset set(registrationIsOpen = false)>
	<cfset set(regOpenPromiseDate = "2018-02-20")>	
	<cfset set(groupregistrationIsOpen = true)>
	<cfset set(convertGroupRegistrationIsOpen = true)>
	<cfset set(monitoring = false)>
	<cfset set(mealsregistrationIsOpen = false)>
	<cfset set(optionsregistrationIsOpen = false)>
	<cfset set(preregistrationIsOpen = false)>
	<cfset set(ccareregistrationIsOpen = false)>
	<cfset set(exhibitorsIsOpen = false)>
	<cfset set(regAccountIsOpen = true)>
	<cfset set(workshopsRegIsOpen = false)>
	<cfset set(workshopsEventsAreSet = false)>
	<cfset set(workshopNotificationsOpen = false)>
	<cfset set(showFacilitatorsWithCourse = false)>
	<cfset set(showSubTypesOfCourses = false)>
	<cfset set(delegatesSubmitIsOpen = false)>
	<cfset set(videoStoriesIsOpen = false)>
	

<!---For Facebook OAuth--->
	<cfif cgi.http_host is "localhost:8080" OR cgi.http_host is "localhost:8888">
		<cfset application.fbappid = "10152781512188290">
		<cfset application.fbsecret = "5a85ea243d25e86cf6d1ca335bb5e202">
		<cfset application.fbredirecturl = "http://localhost:8888/index.cfm/auth.users/facebooklogin">
	<cfelse>
		<cfset application.fbappid = "143684413289">
		<cfset application.fbsecret = "76738ed83f18239fcfb90f652813de25">
		<cfset application.fbredirecturl = "http://www.charisfellowship.us/auth.users/facebooklogin">
	</cfif>
            <cfset set(facebookloginisopen = true)>

<!---For Vision Conference Announcements--->

	<cfset set(useTestEmailList = false)>
	<cfset set(testEmailList = "tomavey@charisfellowship.us,tomavey@fgbc.org")>
	<cfset set(emailNotList = "tomavey@test.net,caesar.die2self@gmail.com,graham.cochrane@td.com")>


