<cfcomponent extends="Model" output="false">

    <cffunction name="init">
        <cfset table("equipannouncements")>
        <cfset property(name="datePosted", sql="DATE_FORMAT(equipannouncements.postAt,'%b %d %Y %h:%i %p')")>
        <cfset property(name="uuid", defaultValue="#createUUID()#")>
    </cffunction>

    <cffunction name="findAllAnnouncements">
    <cfargument name="params" default="">
    <cfset var loc=structNew()>
    <cfset loc = arguments.params>
            <cfif not isDefined("loc.postAt")>
                <cfset loc.postAt = now()>
            </cfif>
            <cfif not isDefined("loc.page")>
                <cfset loc.page = 1>
            </cfif>
            <cfif not isDefined("loc.perPage")>
                <cfset loc.perPage = 10000000>
            </cfif>
            <cfset loc.selectString = "id,subject,author,content,createdAt,datePosted,postAt,link">
            <cfset loc.event = getEvent()>
            <cfset loc.whereString = "event='#getEvent()#' AND approved = 'yes' AND postAt < '#loc.postAt#'">
            <cfif isDefined("loc.id")>
                <cfset loc.whereString = loc.whereString & " AND id=#loc.id#">
                <cfset loc.selectString = loc.selectString & ",content">
            </cfif>
            <cfif isDefined("loc.key")>
                <cfset loc.whereString = loc.whereString & " AND id=#loc.key#">
                <cfset loc.selectString = loc.selectString & ",content">
            </cfif>
                <cfset loc.announcements = findall(select=loc.selectString, where=loc.whereString, order="postAt DESC, id DESC", page=loc.page, perPage=loc.perPage)>
                <cfreturn loc.announcements>
      </cffunction>

      <cffunction name="findAllAnnouncementsAsJson">
      <cfargument name="params" default="">
      <cfset var loc=structNew()>
            <cfset loc.announcements = findAllAnnouncements(params)>
                <cfset loc.announcements = queryToJson(loc.announcements )>
                <cfreturn loc.announcements >
        </cffunction>

            <cffunction name="findOneAnnouncementAsJson">
            <cfargument name="id" required="true" type="numeric">
            <cfset var loc=structNew()>
            <cfset loc = arguments>
                <cfset  loc.announcement = findAll(where="id=#loc.id#")>
                <cfset loc.return = queryToJson(loc.announcement)>
                <cfreturn loc.return>
     </cffunction>


    <cffunction name="findRegEmails">
    <cfset var loc=structNew()>
        <cfset loc.emaillist = "">
        <cfset loc.emails = model("Conferenceperson").findAll(select="email, deletedAt", where="event = '#getEvent()#' AND email <> 'parent'", order="email", include="registration(option)")>
        <cfquery dbtype="query" name="loc.emails">
            SELECT distinct email
            FROM loc.emails
        </cfquery>
        <cfloop query="loc.emails">
            <cfif isValid("email",email) AND (listContains(loc.emaillist, email) is 0)>
                <cfset loc.emaillist = loc.emaillist & ", " & email>
            </cfif>
        </cfloop>
        <cfset loc.emaillist = loc.emaillist & ", " & "tomavey9173@gmail.com, tomavey.comcast.net">
        <cfset loc.emaillist = replace(loc.emaillist,",","","one")>
        <cfreturn loc.emaillist>
    </cffunction>

    <cffunction name="trimemail">
        <cfset this.author = trim(this.author)>
    </cffunction>

</cfcomponent>
