<cfparam name="instructors" type="query">
<cfoutput query="instructors">
<div class="well" style="overflow:auto">
<h3>#fname# #lname#</h3>

<cfif FileExists(ExpandPath("/images/conference/instructors/#picThumb#"))>
    <p style="float:left; margin-right:20px">#imageTag(source="/conference/instructors/#picThumb#")#</p>
</cfif>

<p><cfif isDefined("bioweb")>
        #bioWeb#
    <cfelse>
        #bioPrint#
    </cfif>
</p>

<cfif gotRights("superadmin,office,pageEditor")>
    <p class="pull-right">#editTag()#</p>
</cfif>	


</div>
</cfoutput>