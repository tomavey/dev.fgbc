<div class="well span10" id="yellowpages">
<cfparam name="organization">
<cfset previousId = 0>
<cfset previousSortOrder = 0>

<cfoutput>

<ul>
		  <li>
		  	  <h2>
		  		<cfif len(organization.listed_as_city)>
					#organization.listed_as_city#
				<cfelse>
					#organization.org_city#
				</cfif>			  
					  </h2></li>
		  <li>#organization.name# #linkTo(text="[edit]", action="edit", key=params.key)#</li>
		  <li>#organization.address1#</li>
    	  <cfif len(organization.address2)>
    		<li>#organization.address2#</li>
    	  </cfif>
		  <li>#organization.org_city#, #organization.handbookstate.state_mail_abbrev#, #organization.zip#</li>
		  <cfif len(organization.email)>
		  	<li>#organization.email#</li>
		  </cfif>
		  <cfif len(organization.phone)>
		  	<li>#organization.phone#</li>
		  </cfif>
		  <cfif len(organization.website)>
		  	<li>#organization.website#</li>
		  </cfif>
		  <cfloop query="positions">
		  <cfset nextperson = getNextPerson(id)>
		  <li>&middot;#fname# #lname#: #position# 
		  		<span> 	  
		  		<cfif previousid>	  
		  		#linkto(text='<i class="icon-arrow-up"></i>', action="move", params="personid=#id#&sortorder=#sortorder#&otherID=#previousid#&otherSortOrder=#previousSortOrder#&orgid=#organization.id#", class="tooltipside", title="Move #fname# Up")#
				</cfif>				
				   
				<cfif isStruct(nextperson)>
		  		#linkto(text='<i class="icon-arrow-down"></i>', action="move", params="personid=#id#&sortorder=#sortorder#&otherID=#nextperson.id#&otherSortOrder=#nextperson.sortorder#&orgid=#organization.id#", class="tooltipside", title="Move #fname# Down")#
				</cfif>
		  		#linkto(text='[remove]', action="notStaff", key=id, class="tooltipside", title="Remove #fname# from staff list", onclick="return confirm('Are you sure you want to remove #fname# from your staff list?')")#
		  		#linkto(text='[edit]', controller="Handbook-people", action="edit", key=id, class="tooltipside", title="Edit #fname#")#
				</span>
		  </li>
		  
		  <cfset previousid = id>
		  <cfset previousSortOrder = sortorder>			  		  
		  </cfloop>
		  </ul>
</cfoutput>
</div>