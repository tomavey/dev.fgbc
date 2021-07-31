<cfoutput>
<div id="addoptions" class="container">

	#startFormTag(action=formaction, spamProtection=true)#

	<cfif isdefined("params.return")>
		#hiddenFieldTag(name="return", value=params.return)#
	</cfif>

	#hiddenFieldTag(name="person", value=params.key)#
	#hiddenFieldTag(name="familyid", value=thisperson.family.id)#


	#includePartial(partial="selectoptions")#

	#submitTag(submitvalue)#
	#endFormTag()#

</div>
</cfoutput>

