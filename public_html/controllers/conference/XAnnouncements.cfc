component extends="Controller" output="false" {

	public function config() {
		usesLayout("/conference/adminlayout");
		//  <cfset filters(through="officeOnly", except="list,newest,announcementcount,view,postFromJson,httpTest,httpHeaders")>
		filters(through="isAuthorized", except="list,newest,announcementcount,view,postFromJson,httpTest,httpHeaders");
		filters(through="setAccessControlHeaders", only="postFromJsonX");
	}
	// Filters-

	function isAuthorized() {
         if ( !gotrights("office,conferenceEditor")) {
             renderText("You do not have permission to see this page!!!")
             abort
         }
     }

// -------------------------------
// ------------CRUD---------------
// -------------------------------
    
    //  announcements/index 
    public function index() {
		setReturn();
		if ( isDefined("params.showNotApproved") ) {
			announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#' && approved='no'", order="postAt DESC, createdAt DESC");
		} else {
			announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#'", order="postAt DESC, createdAt DESC");
		}
    }
    
    //  announcements/list 
	public function view() {
		setReturn();
		if ( isDefined("params.showNotApproved") ) {
			announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#' && approved='no'", order="postAt DESC, createdAt DESC");
		} else {
			announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#'", order="postAt DESC, createdAt DESC");
		}
		setReturn();
    }
    
	//  announcments/show/key 
	public function show() {
		//  Find the record 
		announcement = model("Conferenceannouncement").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(announcement) ) {
			flashInsert(error="announcement #params.key# was !found");
			redirectTo(action="index");
		}
    }
    
	//  announcements/new 
	public function new() {
		announcement = model("Conferenceannouncement").new();
    }
    
	//  announcements/edit/key 
	public function edit() {
		//  Find the record 
		announcement = model("Conferenceannouncement").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(announcement) ) {
			flashInsert(error="announcement #params.key# was !found");
			redirectTo(action="index");
		}
    }
    
	// announcements/copy/key
	public function copy() {
		announcement = model("Conferenceannouncement").findByKey(params.key);
		announcement.postAt = now();
		//  Check if the record exists 
		if ( !IsObject(announcement) ) {
			flashInsert(error="announcement #params.key# was !found");
			redirectTo(action="index");
		}
    }
    
	//  announcements/create 
	public function create() {
		announcement = model("Conferenceannouncement").new(params.announcement);
		announcement.event = getEvent();
		if ( announcement.author == "tomavey@fgbc.org" ) {
			announcement.approved = "yes";
		}
		//  Verify that the announcement creates successfully 
		if ( announcement.save() ) {
			flashInsert(success="The announcement was created successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the announcement.");
			renderView(action="new");
		}
	}

    //  announcements/update 
	public function update() {
		announcement = model("Conferenceannouncement").findByKey(params.key);
		//  Verify that the announcement updates successfully 
		if ( announcement.update(params.announcement) ) {
			flashInsert(success="The announcement was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the announcement.");
			renderView(action="edit");
		}
	}

    //  announcements/delete/key 
	public function delete() {
		announcement = model("Conferenceannouncement").findByKey(params.key);
		//  Verify that the announcement deletes successfully 
		if ( announcement.delete() ) {
			flashInsert(success="The announcement was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the announcement.");
			redirectTo(action="index");
		}
	}
// -------------------------------
// ------------END OF CRUD---------------
// -------------------------------





// --------------------------------
// -----OTHER VIEW CONTROLLERS---------------------------
// --------------------------------

    //  announcements/rss 
	public function rss() {
		announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#' && approved='yes'", order="createdAt DESC");
		renderView(template="rss.cfm", layout="rsslayout");
	}

	public function approve() {
		announcement  = model("Conferenceannouncement").findByKey(params.key);
		announcement.update(approved="yes");
		returnBack();
	}

	public function list() {
		data = model("Conferenceannouncement").findAllAnnouncementsAsJson(params);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function newest() {
		loc.postAt = now();
		var whereString = "event='#getEvent()#' && approved = 'yes' && postAt < '#loc.postAt#'";
		data = model("Conferenceannouncement").findOne(where=whereString, order="id DESC", returnAs="query");
		data = queryToJson(data);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function announcementcount() {
		var loc = StructNew();
		loc.postAt = now();
		var whereString = "event='#getEvent()#' && emailonly <> 'yes' && approved = 'yes' && postAt < '#loc.postAt#'";
		data = model("Conferenceannouncement").findAll(where=whereString, order="id DESC", returnAs="query").recordcount;
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function submit() {
		if ( isDefined("params.test") ) {
			requestBody =  '{ "author":"tomavey@fgbc.org", "content":"Workshops will be Friday, Saturday && Sunday during Flinch: Conference. Sign up before they fill up!", "subject":"test subject", "postAt":"Jul 1 2015", "link":"www.charisfellowship.us", "approved":"yes"}';
		} else {
			requestBody = toString(getHttpRequestData().content);
		}
		params.announcement = jsonToStruct(requestBody);
		if ( !isDefined("params.announcement.subject") ) {
			params.announcement.subject = "";
		}
		params.announcement.event = getEvent();
		announcement = model("Conferenceannouncement").new(params.announcement);
		if ( announcement.save() ) {
			data = true;
		} else {
			data = false;
		}
		try {
			notification(announcement.id);
		} catch (any cfcatch) {
		}
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function notification(numeric id) {
		if ( isDefined("params.id") ) {
			arguments.id = params.id;
		}
		announcement = model("Conferenceannouncement").findByKey(arguments.id);
		sendEmail(template="notification", from=announcement.author, to="tomavey@fgbc.org", subject="An announcement for Margins2016.", layout="/layout_naked");
		sendEmail(template="receipt", to=announcement.author, from="tomavey@fgbc.org", subject="Your announcement for Margins2016.", layout="/layout_naked");
	}

	public function sendAnnouncement(dontsendto="") {
		var args = arguments;
		announcement = model("Conferenceannouncement").findByKey(params.key);
		if ( !useTestEmailList() ) {
			announcement.sentAt = now();
			announcement.update();
		}
		if ( useTestEmailList() ) {
			thissubject="TEST: #getEventAsTextA()# Announcement: #announcement.subject#";
		} else {
			thissubject="#getEventAsTextA()# Announcement: #announcement.subject#";
		}
		if ( isDefined("announcement.dontsendto") ) {
			args.dontsendto = announcement.dontsendto;
		}
		args.useThisEmailList = $regEmailLessNotList(args.dontsendto);
		for ( i in args.useThisEmailList ) {
			if ( isValid("email",trim(i)) ) {
				if ( application.wheels.environment == "Production" ) {
					sendEmail(template="announcementemail2", from=announcement.author, to=trim(i), subject=thissubject, layout="/conference/layout_for_email");
				}
			}
		}
		showThisEmailList = args.useThisEmailList;
		if ( application.wheels.environment == "Development" ) {
			renderView(layout="/conference/layout_for_email", template="announcementemail2");
		}
	}
// --------------------------------
// -----END OF OTHER VIEW CONTROLLERS---------------------------
// --------------------------------




// ---------------------------
// ---------CONTROLLER SERVICES------------------
// ---------------------------

	private function $regEmailLessNotList(dontsendtothese="") {
		var emaillist = "";
		for ( i in $regEmails() ) {
			if ( !listFindNoCase($emailnotList(arguments.dontsendtothese),trim(i)) && isValid("email",trim(i)) ) {
				emaillist = emaillist & ", " & trim(i);
			}
		}
		emaillist = replace(emaillist,", ","");
		emaillist = removeDuplicatesFromList(emaillist,', ','nocase');
		return emaillist;
	}

	private function $regEmails() {
		var loc = structNew();
		if ( useTestEmailList() ) {
			loc.emails = application.wheels.testEmailList;
		} else {
			loc.emails = model("Conferenceannouncement").findRegEmails();
		}
		return loc.emails;
	}

	private function $emailNotList(dontsendtothese="") {
		var returnthis = application.wheels.emailnotList;
		if ( ListLen(arguments.dontsendtothese) ) {
			returnthis = returnthis & "," & arguments.dontsendtothese;
		}
		returnThis= replace(returnthis," ","","all");
		return returnthis;
	}
	// --------------------------------
	// ----TESTS DURING DEVELOPMENT-----------------------
	// --------------------------------

	public function testemailNotList() {
		writeDump( var=emailNotList('tomavey@fgbc.org,sharmion@charisfellowship.us,sandiavey@gmail.com') );
		abort;
	}

	public function useTestEmailList() {
		if ( application.wheels.useTestEmailList || isDefined("params.test") ) {
			return true;
		} else {
			return false;
		}
    }
// ---------------------------
// ---------END OF CONTROLLER SERVICES------------------
// ---------------------------





// --------------------------------
//  These methods WERE being used to test post from another site 
// --------------------------------
    // public function getHttpHeaders() {
	// 	savecontent variable="results" {
	// 		x = GetHttpRequestData();
	// 		cfoutput(  ) {
	// 			for (  in "" ) {

	// 				writeOutput("#http_item#: #StructFind(x.headers, http_item)# <br/>");
	// 			}

	// 			writeOutput("request_method: #x.method#<br/> 
    //     server_protocol: #x.protocol#<br/> 
    //     http_content --- #x.content#<br/>
    //     #isStruct(x.content)#<br/>");
	// 			testJson = '{"subject":"Foundeo","name":"Pete Freitag"}';

	// 			writeOutput("#testJson#
    //     #deserializeJSON( testJson ).subject#<br/>");
	// 		}
	// 	}
	// 	return results;
	// }

	// public function httpHeaders() {
	// 	cfoutput(  ) {

	// 		writeOutput("#getHttpHeaders()#");
	// 	}
	// 	abort;
	// }

	// function postFromJson () {
    //     // setAccessControlHeaders();
    //     var response = getPageContext().getResponse();
    //     response.setHeader("Access-Control-Allow-Origin","*");
    //     response.setHeader("Access-Control-Allow-Headers","Content-Type");
    //     response.setHeader("Content-Type","application/json");

    //     try {
    //         if (isDefined('params.test')) {
    //             requestBodyParams = {
    //                 subject: 'test subject',
    //                 content: 'test content',
    //                 author: 'test author',
    //                 postAt: '2017-07-18 20:00',
    //                 approved: 'no'
    //             };
    //         } else {
    //             requestBodyParams = deserializeJSON(getHttpRequestData().content);
    //         };

    //         announcement = model("Conferenceannouncement").new(requestBodyParams);
    //         if (announcement.save()) {
    //             data = serializeJson(announcement);
    //         } else {
    //             data = 'false'
    //         }
    //     } catch (any e) { data = cfcatch.message }
    //         renderView(template="/json", layout="/layout_json_no_headers", hideDebugInformation=true);
    // }
	// //  End of cross site testing methods

}
