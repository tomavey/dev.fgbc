<cfoutput>

<span>
	  <u>#fname# #trim(lname)#<cfif len(suffix)>&nbsp;#trim(suffix)#</cfif></u>:#trim(getPositionForHandbookReport(id))#
</span>
       <br>

</cfoutput>