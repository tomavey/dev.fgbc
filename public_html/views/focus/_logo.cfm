<cfoutput>
<div class="row">

<div class="span4 well">
#imageTag("/focus/apprentice2017b.jpg")#
</div>
<div class="span7 well">
		<h1 id="logoheader">#getFocusContent("MainTitle")#</h1>
		<h2 id="logoheader2">#getFocusContent("mainTitleText")#<br />
        <div class="listofretreats">
        <cfloop query="retreats">
				<p>#linkTo(controller="focus.main", action="retreat", key=id, text="#menuname#:<br/>#dateText(startat,endat)#")#</p>
        </cfloop>
        </div>
</div>

</div>
</cfoutput>
