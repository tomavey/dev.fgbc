<div class="offset1" id="showinfo">
<h2>FGBC Group Roster</h2>
<cfoutput query="rosterChurches">
<p>
#linkto(text=selectname, controller="handbook.organizations", action="show", key=id)#&nbsp;&nbsp;&nbsp;  FEIN##-#fein#
</p>
</cfoutput>
<cfoutput>
  Count: #rosterChurches.recordCount#
</cfoutput>
</div>