<cfoutput>
<div class="row">

<div class="span4 well">
#imageTag("/focus/forward.jpg")#
</div>

<div class="span7 well">
		<h1 id="logoheader">#getFocusContent("MainTitle")#</h1>
		<h2 id="logoheader2">#getFocusContent("mainTitleText")#<br />
        <div class="listofretreats">
          <cfif retreats.recordCount>
            <cfloop query="retreats">
              <p>#linkTo(controller="focus.main", action="retreat", key=id, text="#menuname#:<br/>#dateText(startat,endat)#")#</p>
            </cfloop>
          <cfelse>
              <p>#linkto(text="Future retreats", controller="events", action="index", params="search=focus", class="btn", target="_blank")#</p>
          </cfif>
        </div>
</div>

</div>
</cfoutput>
