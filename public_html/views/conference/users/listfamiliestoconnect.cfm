<div class="eachItemShown">

<cfparam name="families" type="query">
<cfoutput>
	#startFormTag(controller="conference.users", action="connectFamilyToUser")#

	#hiddenTag(name="userid", value=params.key)#

	#selectTag(name="familyid", options=families, includeBlank="---select one---", textField="fullNameLastFirstID", valueField="id")#

	#submitTag()#

	#endformTag()#
</cfoutput>
</div>