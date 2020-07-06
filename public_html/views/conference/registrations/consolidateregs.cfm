<div class="container">
<h3>Consolidate Regs</h3>
<p class="well">
The temp person is the persons regs that you want to consolidate into the target person. For example:  you want regs that belong to person B (the temp person) to belong to person B (the target person).
</p>
<cfoutput>
#startFormTag(action="consolidateregsGo")#
<p>
<cfif isDefined("params.targetpersonid")>
Target Person = #targetPerson.fullnamelastfirstID#<br/>
#hiddenFieldTag(name="targetpersonid", value=params.targetpersonid)#
<cfelse>
#selectTag(name="targetpersonid", options=people, includeBlank="---Target Person---")#
</cfif>
</p>
<p>
<cfif isDefined("params.temppersonid")>
Temp Person = #tempPerson.fullnamelastfirstID#<br/>
#hiddenFieldTag(name="temppersonid", value=params.temppersonid)#
<cfelse>
#selectTag(name="temppersonid", options=people, includeBlank="---Temp Person---")#
</cfif>
</p>
#submitTag(value="Post", class="btn")#
#endFormTag()#
</cfoutput>
</div>