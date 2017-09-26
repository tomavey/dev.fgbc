<cfoutput>
<h2>Two options:</h2>
<div class="well text-center">##1 - Add someone show is already listed in the handbook to your staff...
#startFormTag(route='handbookaddnewposition', method="get")#
<select name="key">
        <option value="">----Select One----</option>

    <cfoutput query="allHandbookPeople" group="id">
        <option value=#id#>#selectname#</option>
    </cfoutput>
<select>
#hiddenFieldTag(name="organizationid", value=organizationid)#
#hiddenFieldTag(name="sortOrder", value=sortorder)#
<br/>#submitTag(value="Use this person", class="btn")#
#endFormTag()#
</div>
<h2>OR</h2>
<div class="well text-center">##2 - #linkTo(text="OR Add a whole new person to the handbook!", controller="handbook.people", action="new", params="organizationid=#organizationid#&sortorder=#sortorder#", class="btn")#
</div>
</cfoutput>