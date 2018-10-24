<cfoutput>

<span>
	  <u>#fname# #lname#
    <cfif len(suffix)>
    &nbsp;#suffix#
     </cfif>
    </u>:
              #getPositionForHandbookReport(id)#
</span>
       <br>

</cfoutput>