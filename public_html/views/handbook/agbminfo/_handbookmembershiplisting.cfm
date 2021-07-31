<cfoutput>

<span>
	  <u>#alias('fname',fname,personid)# #alias('lname',lname,personid)#<cfif len(suffix)>&nbsp;#trim(suffix)#</cfif></u>:#trim(getPositionForHandbookReport(personid))# <cfif len(agbmlifememberAt)>*</cfif>
</span>
       <br>

</cfoutput>