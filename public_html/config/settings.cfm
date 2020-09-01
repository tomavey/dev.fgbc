<cfscript>

	// DSN for database
	set(dataSourceName="fgbc_main_3")
		if ( isLocalMachine() ) {
			set(dataSourceUserName="root")
			set(dataSourcePassword="j11itbwtw") 
			set(OnLocalhost = "true")
		}
		else {
			set(dataSourceUserName="tomavey.fgbc")
			set(dataSourcePassword="Nd0pqKnihX6vhtw") 
		}

	// Defaults for form helpers
	set(functionName="textField", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="passwordField", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="fileField", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="textArea", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="textFieldTag", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="checkBoxTag", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="radioButtonTag", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="selectTag", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="select", labelPlacement="before", prependToLabel="<p>", append="</p>")
	set(functionName="timeSelect", labelPlacement="before", prependToLabel="<p>", append="</p>")

	// Settings for rewriting, reloading and errors
	if ( isLocalMachine() ) {
		set(URLRewriting="On")
	} else {
		set(URLRewriting="On")
		set(reloadPassword="mack")
	}
	set(autologin=true)

	// Misc settings
	set(sendEmailOnError=false)
	set(sendConferenceEmailOnError=false)
	set(sendHandbookEmailOnError=false)
	set(errorEmailAddress="tomavey@charisfellowship.us")
	set(errorEmailSubject="charisfellowship.us error")
	set(sendConferenceEmailOnError=true)
	set(sendHandbookEmailOnError=true)
	set(userAdminEmailAddress="tomavey@charisfellowship.us")
	set(fileRef = "http://" & cgi.http_host & replace(cgi.script_name,"index.cfm","") & "files/")
	addFormat(extension="js", mimeType="text/javascript")
	set(goEMerchantId = "fellowshipofgracen")

	// cfset set(obfuscateURLs=true)
	set(allowUserAccountCreation = false)
	set(requireUserCreateCodeConfirm = true)
	set(logViews = false)

	// application.wheels Variables
	set(passwordKey="j316fgsltwj11itbwtwp16hwbagwiy")

	// PasswordKey is not accessible via getSetting()
	set(oldself = "http://my.charisfellowship.us")
	set(feedcount=9)
	set(nominateYear = "2018")
	set(nominateTerm = "2018-2023")
	set(sortorderoptions = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,18,20,100,900,995,999")
	set(ministryStaffAdmin="'tomavey','hirwin','skoontz','sharmion'")
	set(agbmDeadlineDate = "07-1-#year(now())#")
	set(agbmLastPaymentYearsAgo = 1)
	set(nonStaffSortOrder = 500)
	set(churchStatusForHandbook = "1,4,8,9")
	set(churchAndOrgStatusForHandbook = "1,4,8,9,10,11")
	set(alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z")
	set(delegateyear = "2016")
	set(controllerlocation = "devwc.trunk.controllers.Controller")
	set(memFee = 6.45)
	set(lateMemFee = 6.95)
	set(memFeeMax = 8300)
	set(lateMemFeeMax = 8500)
	set(memFeeDeadline = "2018-05-15")
	set(delegatesSubmitDeadline = "07-20")

	// Current Year
	// used by handbook
	set(handbookRightsRequired = "handbook,office,superadmin,natmin,agbmadmin")
	set(HandbookProfileSecretary="tomavey@charisfellowship.us")
	set(showLinkToHandbookPageBefore = "11-1-#year(now())#")
	set(sendHandbookDeadline = "January 5, 2018")
	set(HandbookReviewSecretary = "Cassie Rayl <raylcassie@gmail.com>")
	set(HandbookReviewSecretary2 = "Tom Avey <tomavey@charisfellowship.us>")
	set(HandbookStatsReviewer = "tomavey@charisfellowship.us")
	set(SendHandbookStatsReminderCopyTo = "tomavey@fgbc.org")
	set(SendHandbookStatsReminderCopy = true)
	set(SendImmediatePersonUpdates = false)
	set(ChurchHandbookReviewGreeting = "It's Time to Update the Charis Fellowship Handbook!")
	set(PersonHandbookReviewGreeting = "It's Time to Update the Charis Fellowship Handbook!")
	set(StatForm = "https://charisfellowship.us/files/FGBCStatCard2019-20.pdf")
	set(churchReviewDeadline = "October 20")
	set(personReviewDeadline = "October 20")
	set(allowHandbookAuthByCookie = false)
	set(allowHandbookOrgUpdate = true)
	set(superAdminUserName = "tomavey")
	set(testEmailsForHandbookReview = "tomavey@fgbc.org,tomavey@outlook.com")

	// used at users.cfc login to give access to FC pages
	set(alias = {
			"652":{"lname":"B."},
			"1037":{"lname":"B.","fname":"M.","spouse":"B."},
			"1033":{"lname":"B"},
			"423":{"lname":"C."},
			"1712":{"lname":"C."},
			"4023":{"lname":"C."},
			"3299":{"lname":"D.","fname":"M.","spouse":"E."},
			"3762":{"lname":"F."},
			"2593":{"lname":"F."},
			"1073":{"lname":"F."},
			"3214":{"lname":"H."},
			"3523":{"lname":"H.","fname":"A."},
			"1495":{"lname":"P."},
			"3610":{"lname":"R.","fname":"B.","spouse":"A."},
			"3215":{"lname":"S."},
			"1043":{"lname":"W.","fname":"J.","spouse":"D."},
			"3615":{"lname":"Y."},
			"1754":{"lname":"B."}
		})
	set(emailUpdateMessageFromBluepages = "We are updating information in the online Charis Fellowship handbook which == used each year for the printed handbook. Can you review this for me?  Today?  Be sure to click the 'This information == correct' button when you are finished. Thanks so much!")
	set(emailUpdateSubjectFromBluepages = "Please review your personal Charis Fellowship Handbook listing")

	// Used by Focus MVC
	set(registrant = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")
	set(testAgents = "tomavey@charisfellowship.us,sharmion@charisfellowship.us,tomavey@fgbc.org")
	set(mainregistrar = "sharmion@charisfellowship.us")
	set(optionTypes = "Public,Discount,Office")
	set(focusIsOpen = true)
	set(focusMinistryAreas = "Lead Pastor, Executive Pastor, Worship Arts, Youth, Family, Children, Discipleship, Elder, Small Groups, Pastoral Care, Administration, Associate Pastor, Other")
	set(byPassWords = "manual,comp,pending,paid")
	set(includeWomen = true)
	set(yearsago = 5)

	// Used by Conference Registration
	set(event="visionconference2018")
	set(previousEvent = "visionconference2017")
	set(nextEvent = "visionconference2019")
	set(eventAsText = "Access2018")
	set(previouseventAsText = "Access2017")
	set(webpage = "http://www.access2018.com")
	set(discountTypes = "dollar,percent,maximum")
	set(dollar = "USD")
	set(nameForCourse = "Cohort/Excursion/Workshop")
	set(nameForCourses = "Cohorts/Excursions/Workshops")
	set(typesOfCourses = "Cohorts, Excursions, Workshops, Celebration")
	set(subTypesOfCourses = "A,B,C,D")
	set(tracksOfCourses = listSort("Leadership Training,Church Planting,Integrated Ministry,Identity Initiative, Business Integration, Contemporary Theological Issues, Worship, Missional Living, Multi-site, France, Womens Studies, Prayer, Creativity,Other", "text"))
	set(possibleAgentCodes = listSort("Comp,Manual,Prepaid,Test","text"))
	set(sendEmailBeforePayment = false)
	set(maxCohorts = 3)
	set(requiredToken = "nDIyfwSXltprRbwmgc2V")
	set(requireRegForBadge = false)

	// options used in dropdowns and menus
	set(typeOfOptions=listsort("Registration-Couple,Registration-Single,Registration-Group,Registration-Staff,Workshop,Meal,TouristOption,GraceKids-Nursery,GraceKids-Preschool,GraceKids-Elementary,GraceKidsSegments,GraceKidsExcursions,Other,Discount,AutoDiscount,InActive,preRegistration","text"))
	set(typeOfRegOptions=listsort("Registration-Couple,Registration-Single,Registration-staff","text"))
	set(typeOfAddRegOptions="'Registration-Couple','Registration-Single'")
	set(typeOfPeople = "Adult,Spouse,ChildCare,KidsKonference")
	set(sortOrdersAvailable = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27")
	set(optionsCountAvailable = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30")
	set(preRegCountAvailable = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30")
	set(groupCountAvailable = "5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30")
	set(eventDaysOptions="Monday,Tuesday,Wednesday,Thursday")
	set(eventFirstDaysOptionsDate="2018-07-23")
	set(eventCategories="Celebration,Workshop,Excursion,Roundtable,Network,Meal,ChildCare,Kids Konference,Reception,Board Meeting,Other,Office,Rehearsal,Exhibits,Prayer,Other-Public,Cohort")
	set(eventCategoriesForJson="'meal','celebration','workshop','excursion','reception','prayer','other-public'")
	set(ministryCategories=listSort("Church Planting Ministries, Communication, Districts, Doing Good, Leadership Training Ministries, none","text"))
	set(inspireCategories = "1,2,3")
	set(inspireCommissions = "by a local church, in process of ordination, as a missionary, as a miltary chaplain")
	set(aboutItemsForFooter = [
					{
						name: 'Our Common Identity',
						link: 'https://charisfellowship.us/cci'
					},
					{
						name: 'Position Statements',
						link: 'https://charisfellowship.us/page/positionstatements'
					},
					{
						name: 'Our Common Identity',
						link: 'https://charisfellowship.us/cci'
					},
					{
						name: 'Our Common Mission',
						link: 'https://charisfellowship.us/page/ccm-en'
					},
					{
						name: 'Resolutions 2020',
						link: 'https://charisfellowship.us/page/resolutions2020'
					},
					{
						name: 'Graphical Resources',
						link: 'https://charisfellowship.us/page/charisgraphics'
					},
					{
						name: 'Other Resources',
						link: 'https://charisfellowship.us/resources'
					},
					{
						name: 'the Fellowship Council',
						link: 'https://charisfellowship.us/page/fellowshipcouncil'
					},
					{
						name: 'Online Handbook',
						link: 'https://charisfellowship.us/handbook'
					},
					{
						name: 'Constitution',
						link: 'https://charisfellowship.us/page/constitution'
					},
					{
						name: 'Manual of Procedure',
						link: 'https://charisfellowship.us/page/manualofprocedure'
					},
					{
						name: 'Contact Us',
						link: 'https://charisfellowship.us/messages/new/'
					}
				]
			)
	// email addresses used
	set(registrarEmail="sharmion@charisfellowship.us")
	set(registrarEmailBackup="tomavey@charisfellowship.us")
	set(requestInvoiceReceiptFrom = "sharmion@charisfellowship.us")
	set(registrarBackupEmail="sharmion@charisfellowship.us")
	set(housingCoordinatorEmail = "sharmion@charisfellowship.us")
	set(childcarenotifications = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")
	set(workshopnotifications = "tomavey@charisfellowship.us")
	set(sendJobNoticesTo = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")
	set(sendContactUsTo = "tomavey@charisfellowship.us,sharmion@charisfellowship.us")

	set(focusForFinancialHelp="sharmion@charisfellowship.us")

	// What is open and what is not for conference
	set(registrationIsOpen = false)
	set(regOpenPromiseDate = "2018-02-20")
	set(groupregistrationIsOpen = true)
	set(convertGroupRegistrationIsOpen = true)
	set(monitoring = false)
	set(mealsregistrationIsOpen = false)
	set(optionsregistrationIsOpen = false)
	set(preregistrationIsOpen = false)
	set(ccareregistrationIsOpen = false)
	set(exhibitorsIsOpen = false)
	set(regAccountIsOpen = true)
	set(workshopsRegIsOpen = false)
	set(workshopsEventsAreSet = false)
	set(workshopNotificationsOpen = false)
	set(showFacilitatorsWithCourse = false)
	set(showSubTypesOfCourses = false)
	set(delegatesSubmitIsOpen = false)
	set(videoStoriesIsOpen = false)
	set(isConferenceHomesTesting = true)
	set(conferenceHomesIsOpen = false)
	set(prayerWallIsOpenBefore="2020-07-01")
	set(covidPageIsOpenBefore="2020-06-01")
	set(forceMainPageBannerOpen = false)
	// For Facebook OAuth
	if ( cgi.http_host == "localhost:8080" || cgi.http_host == "localhost:8888" ) {
		application.fbappid = "10152781512188290"
		application.fbsecret = "5a85ea243d25e86cf6d1ca335bb5e202"
		application.fbredirecturl = "http://localhost:8888/index.cfm/auth.users/facebooklogin"
	} else {
		application.fbappid = "143684413289"
		application.fbsecret = "76738ed83f18239fcfb90f652813de25"
		application.fbredirecturl = "http://www.charisfellowship.us/auth.users/facebooklogin"
	}
	set(facebookloginisopen = true)
	// For Vision Conference Announcements
	set(useTestEmailList = false)
	set(testEmailList = "tomavey@charisfellowship.us,tomavey@fgbc.org")
	set(emailNotList = "tomavey@test.net,caesar.die2self@gmail.com,graham.cochrane@td.com,guypelay@verizon.net,Crazyfox65@gmail.com")

</cfscript>
