<cfparam name="instructors" type="query">
<cfoutput query="instructors">
<div class="well" style="overflow:auto">
<h3>#fname# #lname#</h3>

    <cfif gotRights("superadmin,office,pageEditor")>
        #linkto(text="edit", controller="conference.instructors", action="edit", key=id)#
    </cfif>	

<cfif FileExists(ExpandPath("/images/conference/instructors/#picThumb#"))>
    <p style="float:left; margin-right:20px">#linkto(text=imageTag(source="/conference/instructors/#picThumb#"), href="/images/conference/instructors/#picBig#")#</p>
</cfif>

<p><cfif isDefined("bioweb")>
        #bioWeb#
    <cfelse>
        #bioPrint#
    </cfif>
</p>
<cfif gotRights("office")>
    #linkTo(text="link", controller="conference.instructors", action="list", key=#id#)#<br/>
    #mailTo(email)#
</cfif>

</div>
</cfoutput>