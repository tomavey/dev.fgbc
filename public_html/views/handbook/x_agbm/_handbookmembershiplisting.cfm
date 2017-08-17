<cfoutput>

<span>
	  #linkto(text="#fname# #lname#", controller="handbook-people", action="show", key=id)#:
	  #gbcIt(name)#;
	  	<cfif len(unRepeatCity(org_city,name))>
	  		#unRepeatCity(org_city,name)#,
		</cfif> 
	  #getState(Handbookorganizationstateid)#</span> <br>
</cfoutput>