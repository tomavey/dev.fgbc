<cfoutput>

<span>
	  <u>#alias('fname',fname,id)# #alias('lname',lname,id)#<cfif len(suffix)>&nbsp;#trim(suffix)#</cfif></u>:#trim(getPositionForHandbookReport(id))#
</span>
       <br>

</cfoutput>