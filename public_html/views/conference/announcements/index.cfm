<div data-role="content">
<h1>Listing announcements</h1>

<cfoutput>#includePartial("showFlash")#
#linkto(text="View", action="view")#
</cfoutput>

<cfoutput>
    <p>#linkTo(text="New equip_announcement", action="new")#</p>
    <cfif not isDefined("params.shownotapproved")>
        <p>#buttonTo(text="Show Not Approved", params="shownotapproved=true")#</p>
    </cfif>
</cfoutput>

<div class="table">
<cftable query="announcements" colHeaders="true" HTMLTable="true">

                    <cfcol header="Subject" text="#left(subject,40)#" />

                    <cfcol header="Author" text="#mailto(author)#" />

                    <cfcol header="OK?" text="#approved#" />

                    <cfcol header="Post At" text="#datetimeformat(postAt,"short")#" />

                    <cfcol header="Created At" text="#dateformat(createdAt,"mm-dd")#" />


    <cfcol header="" text="#linkTo(text='Show', action='show', key=id, params="admin=true", data_icon="search", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true")#" />
    <cfcol header="" text="#linkTo(text='Edit', action='edit', key=id, params="admin=true", data_icon="edit", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true")#" />
    <cfcol header="" text="#linkTo(text='Copy', action='copy', key=id, params="admin=true", data_icon="edit", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true")#" />
    <cfcol header="" text="#linkTo(text='Delete', controller="conference.announcements", action='delete', key=id, confirm='Are you sure?',params="admin=true", data_icon="delete", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true")#" />
    <cfcol header="" text="#linkTo(text='Approve', action='approve', key=id, params="admin=true", data_icon="check", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true")#" />
    <cfif len(sentAt)>
        <cfcol header="" text="<span style='font-size:.8em'>Sent: #dateformat(sentAt)# at #timeFormat(sentAt,"short")#</span>" />
    </cfif>
        <cfcol header="" text="#linkTo(text='Send', action='sendAnnouncement', key=id, params="admin=true", data_icon="forward", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true", onClick="confirm('Are you sure?')")#" />
        <cfcol header="" text="#linkTo(text='Send Test', action='sendAnnouncement', key=id, params="admin=true&test=true", data_icon="forward", data_role="button", data_iconpos="notext", data_theme="b", data_inline="true", onClick="confirm('Are you sure?')")#" /></cftable>
</div>
</div>
