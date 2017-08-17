<cfoutput>

<span>
	  #linkto(text="#fname# #lname#", controller="handbook.people", action="show", key=id)#:
              #getPositionForHandbookReport(id)#
</span>
       <br>

</cfoutput>