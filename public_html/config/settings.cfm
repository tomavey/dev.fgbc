<!---DSN for database--->
<cfscript>
	set(dataSourceName="fgbc_main_3")
	if (cgi.http_host is "localhost:8080" || cgi.http_host is "localhost:8888" || cgi.http_host is "fgbc:8080") {
		set(dataSourceUserName="root");
		set(dataSourcePassword="j11itbwtw"); 
	}
	else {
		set(dataSourceUserName="tomavey.fgbc");
		set(dataSourcePassword="J316fgsltw!"); 
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
	<cfif cgi.http_host is "localhost:8080" || cgi.http_host is "localhost:8888" || cgi.http_host is "fgbc:8080">
             	      <cfset set(URLRewriting="Off")>
	<cfelse>
	       <cfset set(URLRewriting="On")>
	       <cfset set(reloadPassword="charis")>
	</cfif>
	<cfset set(autologin=true)>

<!---Misc settings--->
	<cfset set(sendEmailOnError=false)>
	<cfset set(sendConferenceEmailOnError=false)>
	<cfset set(sendHandbookEmailOnError=false)>
	<cfset set(errorEmailAddress="tomavey@fgbc.org")>
	<cfset set(errorEmailSubject="fgbc.org error")>
	<cfset set(sendConferenceEmailOnError=true)>
	<cfset set(sendHandbookEmailOnError=true)>
	<cfset set(userAdminEmailAddress="tomavey@fgbc.org")>
	<cfset set(fileRef = "http://" & cgi.http_host & replace(cgi.script_name,"index.cfm","") & "files/")>
	<cfset addFormat(extension="js", mimeType="text/javascript")>
	<!---cfset set(obfuscateURLs=true)--->

<!---application.wheels Variables--->
	<cfset set(passwordKey="j316fgsltwj11itbwtwp16hwbagwiy")>
	<cfset set(oldself = "http://my.fgbc.org")>
	<cfset set(feedcount=9)>
	<cfset set(nominateYear = "2017")>
	<cfset set(nominateTerm = "2017-2022")>
	<cfset set(sortorderoptions = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,18,20,100,900,995,999")>
	<cfset set(registrarEmail="tomavey@fgbc.org,sandy@fgbc.org")>
    <cfset set(canSetMinistryStaff="'tomavey','hirwin'")>
	<cfset set(agbmDeadlineDate = "07-1-#year(now())#")>
	<cfset set(nonStaffSortOrder = 500)>
	<cfset set(churchStatusForHandbook = "1,4,8,9")>
	<cfset set(churchAndOrgStatusForHandbook = "1,4,8,9,10,11")>
	<cfset set(alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,W,Z")>
	<cfset set(delegateyear = "2016")>
	<cfset set(controllerlocation = "devwc.trunk.controllers.Controller")>
	<cfset set(memFee = 6.25)>
	<cfset set(lateMemFee = 6.75)>
	<cfset set(memFeeMax = 8000)>
	<cfset set(lateMemFeeMax = 8500)>
	<cfset set(memFeeDeadline = "2017-05-26")>

<!---used by handbook--->			 
	<cfset set(handbookRightsRequired = "handbook,office,superadmin,natmin,agbmadmin")>
	<cfset set(HandbookProfileSecretary="tomavey@fgbc.org")>
	<cfset set(showLinkToHandbookPageBefore = "11-1-#year(now())#")>
	<cfset set(sendHandbookDeadline = "November 16, 2016")>
	<cfset set(HandbookReviewSecretary = "Cassie Harris <harriscj@grace.edu>")>
	<cfset set(HandbookReviewSecretary2 = "Tom Avey <tomavey@fgbc.org>")>
	<cfset set(SendImmediatePersonUpdates = false)>

<!---Used by Focus MVC--->
	<cfset set(registrant="tomavey@fgbc.org,sandy@fgbc.org")>
	<cfset set(testAgents = "tomavey@fgbc.org,sandy@fgbc.org")>
	<cfset set(optionTypes = "Public,Discount,Office")>
	<cfset set(focusIsOpen = true)>
            <cfset set(focusMinistryAreas = "Lead Pastor, Executive Pastor, Worship Arts, Youth, Family, Children, Discipleship, Elder, Small Groups, Pastoral Care, Administration, Associate Pastor, Other")>

<!---Used by Conference Registration--->
	<cfset set(event="visionconference2017")>
	<cfset set(previousEvent = "visionconference2016")>
	<cfset set(nextEvent = "visionconference2017")>
	<cfset set(eventAsText = "Access2017")>
	<cfset set(webpage = "http://www.access2017.com")>
	<cfset set(discountTypes = "dollar,percent,maximum")>
	<cfset set(dollar = "USD")>
	<cfset set(nameForCourse = "Cohort/Excursion/Workshop")>	
	<cfset set(nameForCourses = "Cohorts/Excursions/Workshops")>
	<cfset set(typesOfCourses = "Cohorts, Excursions, Workshops, Celebration")>	
	<cfset set(subTypesOfCourses = "A,B,C")>	
	<cfset set(tracksOfCourses = listSort("Leadership Training,Church Planting,Integrated Ministry,Identity Initiative, Business Integration, Contemporary Theological Issues, Worship, Missional Living, Multi-site, France, Womens Studies, Prayer, Creativity,Other", "text"))>

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
	<cfset set(eventFirstDaysOptionsDate="2017-07-24")>
	<cfset set(eventCategories="Celebration,Workshop,Excursion,Roundtable,Network,Meal,ChildCare,Kids Konference,Reception,Board Meeting,Other,Office,Rehearsal,Exhibits,Prayer,Other-Public,Cohort")>

<!---email addresses used--->
	<cfset set(registrarEmail="tomavey@fgbc.org,sandy@fgbc.org")>
	<cfset set(requestInvoiceReceiptFrom = "sandy@fgbc.org")>
	<cfset set(registrarBackupEmail="tomavey9173@gmail.com")>
	<cfset set(housingCoordinatorEmail = "sandy@fgbc.org")>
	<cfset set(childcarenotifications = "tomavey@fgbc.org,sandy@fgbc.org")>
	<cfset set(workshopnotifications = "tomavey@fgbc.org")>

<!---What is open and what is not--->
	<cfset set(registrationIsOpen = false)>
	<cfset set(groupregistrationIsOpen = false)>
	<cfset set(convertGroupRegistrationIsOpen = false)>
	<cfset set(monitoring = false)>
	<cfset set(mealsregistrationIsOpen = false)>
	<cfset set(optionsregistrationIsOpen = false)>
	<cfset set(preregistrationIsOpen = false)>
	<cfset set(ccareregistrationIsOpen = false)>
	<cfset set(exhibitorsIsOpen = false)>
	<cfset set(regAccountIsOpen = false)>
	<cfset set(workshopsRegIsOpen = false)>
	<cfset set(workshopsEventsAreSet = false)>
	<cfset set(workshopNotificationsOpen = false)>
	<cfset set(showFacilitatorsWithCourse = false)>
	<cfset set(showSubTypesOfCourses = false)>

<!---For Facebook OAuth--->
	<cfif cgi.http_host is "localhost:8080" OR cgi.http_host is "localhost:8888">
		<cfset application.fbappid = "10152781512188290">
		<cfset application.fbsecret = "5a85ea243d25e86cf6d1ca335bb5e202">
		<cfset application.fbredirecturl = "http://localhost:8888/index.cfm/auth.users/facebooklogin">
	<cfelse>
		<cfset application.fbappid = "143684413289">
		<cfset application.fbsecret = "76738ed83f18239fcfb90f652813de25">
		<cfset application.fbredirecturl = "http://www.fgbc.org/auth.users/facebooklogin">
	</cfif>
            <cfset set(facebookloginisopen = true)>

<!---For Vision Conference Announcements--->

	<cfset set(useTestEmailList = false)>
	<cfset set(testEmailList = "tomavey@fgbc.org,tomavey9173@gmail.com,tomavey@comcast.net,sandy@fgbc.org")>
	<cfset set(emailNotList = "tomavey@test.net,caesar.die2self@gmail.com,graham.cochrane@td.com")>
