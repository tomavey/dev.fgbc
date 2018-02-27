<cfcomponent extends="Controller" output="false">

    <cffunction name="init">
        <cfset usesLayout("/conference/adminlayout")>
        <cfset filters(through="officeOnly", except="list")>
    </cffunction>

<!------------------------------------->
<!---------------CRUD------------------>
<!------------------------------------->

    <!--- announcements/index --->
    <cffunction name="index">
        <cfset setReturn()>
        <cfif isDefined("params.showNotApproved")>
            <cfset announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#' AND approved='no'", order="postAt DESC, createdAt DESC")>
        <cfelse>
            <cfset announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#'", order="createdAt DESC")>
        </cfif>
    </cffunction>

    <!--- announcments/show/key --->
    <cffunction name="show">

        <!--- Find the record --->
        <cfset announcement = model("Conferenceannouncement").findByKey(params.key)>

        <!--- Check if the record exists --->
        <cfif NOT IsObject(announcement)>
            <cfset flashInsert(error="announcement #params.key# was not found")>
            <cfset redirectTo(action="index")>
        </cfif>

    </cffunction>

    <!--- announcements/new --->
    <cffunction name="new">
        <cfset announcement = model("Conferenceannouncement").new()>
    </cffunction>

    <!--- announcements/edit/key --->
    <cffunction name="edit">

        <!--- Find the record --->
        <cfset announcement = model("Conferenceannouncement").findByKey(params.key)>

        <!--- Check if the record exists --->
        <cfif NOT IsObject(announcement)>
            <cfset flashInsert(error="announcement #params.key# was not found")>
            <cfset redirectTo(action="index")>
        </cfif>

    </cffunction>

    <!--- announcements/create --->
    <cffunction name="create">
        <cfset announcement = model("Conferenceannouncement").new(params.announcement)>
        <cfset announcement.event = getEvent()>

        <cfif announcement.author is "tomavey@fgbc.org">
            <cfset announcement.approved = "yes">
        </cfif>

        <!--- Verify that the announcement creates successfully --->
        <cfif announcement.save()>
            <cfset flashInsert(success="The announcement was created successfully.")>
            <cfset redirectTo(action="index")>
        <!--- Otherwise --->
        <cfelse>
            <cfset flashInsert(error="There was an error creating the announcement.")>
            <cfset renderPage(action="new")>
        </cfif>
    </cffunction>

    <!--- announcements/update --->
    <cffunction name="update">
        <cfset announcement = model("Conferenceannouncement").findByKey(params.key)>

        <!--- Verify that the announcement updates successfully --->
        <cfif announcement.update(params.announcement)>
            <cfset flashInsert(success="The announcement was updated successfully.")>
            <cfset redirectTo(action="index")>
        <!--- Otherwise --->
        <cfelse>
            <cfset flashInsert(error="There was an error updating the announcement.")>
            <cfset renderPage(action="edit")>
        </cfif>
    </cffunction>

    <!--- announcements/delete/key --->
    <cffunction name="delete">
        <cfset announcement = model("Conferenceannouncement").findByKey(params.key)>

        <!--- Verify that the announcement deletes successfully --->
        <cfif announcement.delete()>
            <cfset flashInsert(success="The announcement was deleted successfully.")>
                        <cfset redirectTo(action="index")>
        <!--- Otherwise --->
        <cfelse>
            <cfset flashInsert(error="There was an error deleting the announcement.")>
            <cfset redirectTo(action="index")>
        </cfif>
    </cffunction>

<!-------------------------------------->
<!--------OTHER VIEW CONTROLLERS------------------------------>
<!-------------------------------------->

    <!--- announcements/rss --->
    <cffunction name="rss">
            <cfset announcements = model("Conferenceannouncement").findAll(where="event = '#getevent()#' AND approved='yes'", order="createdAt DESC")>
		    <cfset renderPage(template="rss.cfm", layout="rsslayout")>
    </cffunction>

    <cffunction name="approve">
        <cfset announcement  = model("Conferenceannouncement").findByKey(params.key)>
        <cfset announcement.update(approved="yes")>
        <cfset returnBack()>
    </cffunction>

    <cffunction name="list">
        <cfset data = model("Conferenceannouncement").findAllAnnouncementsAsJson(params)>
        <cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
    </cffunction>

    <cffunction name="submit">
        <cfif isDefined("params.test")>
            <cfset requestBody =  '{ "author":"tomavey@fgbc.org", "content":"Workshops will be Friday, Saturday and Sunday during Flinch: Conference. Sign up before they fill up!", "subject":"test subject", "postAt":"Jul 1 2015", "link":"www.charisfellowship.us", "approved":"yes"}'>
        <cfelse>
            <cfset requestBody = toString(getHttpRequestData().content)>
         </cfif>
        <cfset params.announcement = jsonToStruct(requestBody)>
        <cfif !isDefined("params.announcement.subject")>
            <cfset params.announcement.subject = "">
        </cfif>
        <cfset params.announcement.event = getEvent()>
        <cfset announcement = model("Conferenceannouncement").new(params.announcement)>
        <cfif announcement.save()>
            <cfset data = true>
        <cfelse>
            <cfset data = false>
        </cfif>
        <cftry>
        <cfset notification(announcement.id)>
        <cfcatch></cfcatch></cftry>
        <cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
    </cffunction>

    <cffunction name="notification">
    <cfargument name="id" required="false" type="numeric">
    <cfif isDefined("params.id")>
        <cfset arguments.id = params.id>
    </cfif>
        <cfset announcement = model("Conferenceannouncement").findByKey(arguments.id)>
        <cfset sendEmail(template="notification", from=announcement.author, to="tomavey@fgbc.org", subject="An announcement for Margins2016.", layout="/layout_naked")>
        <cfset sendEmail(template="receipt", to=announcement.author, from="tomavey@fgbc.org", subject="Your announcement for Margins2016.", layout="/layout_naked")>
    </cffunction>

    <cffunction name="sendAnnouncement">
    <cfargument name="dontsendto" default="">
    <cfset var args = arguments>
        <cfset announcement = model("Conferenceannouncement").findByKey(params.key)>
        <cfif !useTestEmailList()>
            <cfset announcement.sentAt = now()>
            <cfset announcement.update()>
        </cfif>
        <cfif useTestEmailList()>
            <cfset thissubject="TEST: #getEventAsTextA()# Announcement: #announcement.subject#">
        <cfelse>
            <cfset thissubject="#getEventAsTextA()# Announcement: #announcement.subject#">
        </cfif>
        <cfdump var="#thissubject#"><cfabort>
        <cfif isDefined("announcement.dontsendto")>
            <cfset args.dontsendto = announcement.dontsendto>
        </cfif>    
        <cfset args.useThisEmailList = $regEmailLessNotList(args.dontsendto)>
        <cfloop list="#args.useThisEmailList#" index="i">
            <cfif isValid("email",trim(i))>
                <cfif application.wheels.environment is "Production">
                    <cfset sendEmail(template="announcementemail2", from=announcement.author, to=trim(i), subject=thissubject, layout="/conference/layout_for_announcements")>
                </cfif>
            </cfif>
        </cfloop>
        <cfset showThisEmailList = args.useThisEmailList>
        <cfif application.wheels.environment is "Development">
            <cfset renderpage(layout="/conference/layout_for_announcements", template="announcementemail2")>
        </cfif>
    </cffunction>

<!--------------------------------->
<!------------CONTROLLER SERVICES--------------------->
<!--------------------------------->

    <cffunction name="$regEmailLessNotList" access="private">
    <cfargument name="dontsendtothese" default="">
    <cfset var emaillist = "">

        <cfloop list="#$regEmails()#" index="i">
            <cfif not listFindNoCase($emailnotList(arguments.dontsendtothese),trim(i)) and isValid("email",trim(i))>
                <cfset emaillist = emaillist & ", " & trim(i)>
            </cfif>
        </cfloop>

        <cfset emaillist = replace(emaillist,", ","")>
        <cfset emaillist = removeDuplicatesFromList(emaillist,', ','nocase')>
        <cfreturn emaillist>
    </cffunction>

    <cffunction name="$regEmails" access="private">
    <cfset var loc = structNew()>
        <cfif useTestEmailList()>
            <cfset loc.emails = application.wheels.testEmailList>
        <cfelse>
            <cfset loc.emails = model("Conferenceannouncement").findRegEmails()>
        </cfif>
        <cfreturn loc.emails>
    </cffunction>

    <cffunction name="$emailNotList" access="private">
    <cfargument name="dontsendtothese" default="">
    <cfset var returnthis = application.wheels.emailnotList>
    <cfif ListLen(arguments.dontsendtothese)>
        <cfset returnthis = returnthis & "," & arguments.dontsendtothese>
    </cfif>
        <cfset returnThis= replace(returnthis," ","","all")>    
        <cfreturn returnthis>
    </cffunction>

<!-------------------------------------->
<!-------TESTS DURING DEVELOPMENT-------------------------->
<!-------------------------------------->

    <cffunction name="testemailNotList">
        <cfdump var="#emailNotList('tomavey@fgbc.org,sandy@fgbc.org,sandiavey@gmail.com')#">
        <cfabort>
    </cffunction>

    <cffunction name="useTestEmailList">
        <cfif application.wheels.useTestEmailList OR isDefined("params.test")>
            <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>

</cfcomponent>
