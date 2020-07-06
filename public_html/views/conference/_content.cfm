<cfoutput>
<cftry>
<div class="equip_content">
<cfif listLen(cgi.path_info,"/") gte 2>
#getContent("/main/index").content#
<cfelse>
#getContent(cgi.path_info).content#
</cfif>
</div>
<cfif gotRights("superadmin")>
<div class="contentEditLink">	
	#linkto(text="#imageTag('edit-icon.png')#", controller="contents", action="edit", key="#getContent(cgi.path_info).id#")#
</div>	
</cfif>
<cfcatch>Content not available</div></cfcatch></cftry>
</cfoutput>
