<cfparam name="nextSortOrder" default="1">
<cfparam name="showAll" default = false>
<cfif isDefined("params.showAll")>
	<cfset showAll = true>
</cfif>

<cfoutput>

	<div class="row">
		<div class="span9 offset1">
			#linkTo(text="This information is all correct", class="btn tooltipside", title="Click this to let us know when the following information is correct", action="setReview", key=params.key)#</br>
			<cfif len(organization.reviewedat)>
			Last reviewed on #dateformat(organization.reviewedat)# by #organization.reviewedby#.
			</cfif>
		</div>
		<div class="span2">
			#linkTo(text="Need help?", href="http://vimeo.com/73854099")#
		</div>
	</div>

	<div>&nbsp;</div>

	<div class="row">
	<div class="well span10 offset1" id="yellowpages">
	<cfif isNatOrg(organization.statusid)>
				<p>Each National and Cooperating Ministry has it's own page and is not listed in the yellow pages of the handbook.  However, this report is provided to help update the staff information.</p>
	<cfelse>
			<cfif showAll>
				<h3>Your church listing PLUS (yellow pages in the handbook):</h3>
				This list includes everyone who will be listed in the blue pages (staff section) of the handbook if they are connected with your church - even if they will not be listed in your churches (yellow pages) listing.
				#linkto(text="Show only staff to be listed in the yellow pages (churches section)", controller="handbook.organizations", action="handbookpages", key=#params.key#, class="pull-right")#
			<cfelse>
				<h3>Your church listing (yellow pages in the handbook):</h3>
				#linkto(text="Show All", controller="handbook.organizations", action="handbookpages", key=#params.key#, params="showAll", class="pull-right")#
			</cfif>
	</cfif>

	</cfoutput>


<p>&nbsp;</p>

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
  		  <li>#organization.name# <span>#linkTo(text="[edit]", action="edit", key=params.key, class="tooltipside", title="Edit #organization.name#")#</span></li>
  		  <li>#organization.address1#</li>
      	  <cfif len(organization.address2)>
      		<li>#organization.address2#</li>
      	  </cfif>
  		  <li>#organization.org_city#, #organization.handbookstate.state_mail_abbrev#, #organization.zip#</li>
  		  <cfif isDefined('organization.meetingplace') && len(organization.meetingplace)>
					Meeting at: #organization.meetingplace#
				</cfif>
				<cfif len(organization.email)>
  		  	<li>#organization.email#</li>
  		  </cfif>
  		  <cfif len(organization.phone)>
  		  	<li>#organization.phone#</li>
  		  </cfif>
  		  <cfif len(organization.website)>
  		  	<li>#organization.website#</li>
  		  </cfif>
				<cfif !isDefined("params.sortByLname")>
					<p class="sortByLname">#linkto(text="Sort staff by last name", action="handbookpages", key=params.key, params="sortByLname")#<p>
				<cfelse>
					<p class="sortByLname">#linkto(text="Sort staff by pecking order", action="handbookpages", key=params.key, params="")#<p>
				</cfif>
  		  <cfloop query="positions">
      		  <cfset nextposition = $getNextPosition(handbookpositionid)>
						<li>&middot;#alias('fname',fname,id)# #alias('lname',lname,id)#: #left(position,75)#
							<cfif p_sortorder GTE getNonStaffSortOrder()>*</cfif>
								<span> 	  
								<cfif !isDefined("params.sortByLname") && !showAll>
									<cfif previousid>	  
										#linkto(
											text='<i class="icon-arrow-up"></i>',
											controller=params.controller,
											action=params.action,
											params="move=1&positionid=#handbookpositionid#&sortorder=#p_sortorder#&otherID=#previousid#&otherSortOrder=#previousSortOrder#&orgid=#organization.id#&key=#organization.id#", 
											class="tooltipside", 
											title="Move #fname# Up"
											)#
									</cfif>				
									
									<cfif isStruct(nextposition) && !showAll>
										#linkto(
											text='<i class="icon-arrow-down"></i>', 
											controller=params.controller,
											action=params.action, 
											params="move=1&positionid=#handbookpositionid#&sortorder=#p_sortorder#&otherID=#nextposition.id#&otherSortOrder=#nextposition.sortorder#&orgid=#organization.id#&key=#organization.id#", 
											class="tooltipside", 
											title="Move #fname# Down"
											)#
									</cfif>

								</cfif>
								
								<cfif !showAll>
									#linkto(text='[remove]', route="handbookremoveStaff", key=handbookpositionid, class="tooltipside", title="Remove #fname# from staff list", onclick="return confirm('Are you sure you want to remove #fname# from your staff list?')")#
								</cfif>
  	    		  		#linkto(text='[edit]', controller="Handbook.people", action="edit", key=id, class="tooltipside", title="Edit #fname#")#
  	    				</span>
      		  </li>
      		  <cfset previousid = handbookpositionid>
      		  <cfset previousSortOrder = p_sortorder>		
			  <cfset nextSortOrder = p_sortorder + 1>	  		  
				</cfloop>
				<cfif showAll>
					* = will not be listed in yellow pages
				</cfif>
  
	  </ul>
	  #linkTo(text="Add a new staff member", route="handbookAddstaff", key=params.key, params="SortOrder=#nextSortOrder#&organizationid=#params.key#", class="btn")#
  </cfoutput>
</div>
</div>

<div class="row">
  <div class="well span10 offset1" id="bluepages">
    <h3>Your staff's personal listing (blue pages in the handbook):</h3>
    <p>&nbsp;</p>
   
      <cfoutput query="positionsalpha">
  	
  	#includePartial(partial="/_shared/handbookinfo")#
  	
  	  <p class="extraprofile">Extra Profile information (will not be printed in handbook):
  		 <ul>
    		 <li>Birthday: #BirthDayAnniversary(id).birthday#</li>
    		 <li>Anniversary: #BirthDayAnniversary(id).anniversary#</li>

    		 <cfif hasPictures(personid)>
      		 <li>#linkto(text="View or edit images of #fname#", controller="handbook.pictures", action="new", params="personid=#personid#")#</li>
    		 <cfelse>
      		 <li>#linkto(text="Upload an image of #fname#", controller="handbook.pictures", action="new", params="personid=#personid#")#</li>
    		 </cfif>		 
  		 </ul>
      </p>
      #linkto(text='[edit]', controller="Handbook.people", action="edit", key=id, class="tooltipside", title="Edit #fname#")#
      <hr/>
      </cfoutput>
  </div>
</div>

<div class="offset1">
<cfoutput>
#linkTo(text="View Unformated Blue Page Info for #organization.name# staff", controller="handbook.people", action="handbookinfo", key=params.key, class="btn")#<br/>
#linkTo(text="View Unformated Yellow Page Info for #organization.name#", controller="handbook.organizations", action="yellowpages", key=params.key, class="btn")#
</cfoutput>
</div>

<cfif not isDefined("cookie.handbookpageshown")>

<script type="text/javascript">
alert('Use this page to edit your churches and staff handbook information. Use the links in the blue and yellow sections to make changes. When everything is correct, use the "This Information is All Correct" button at the top to confirm. Thanks so much for your help!');
</script>

<cfcookie name="handbookpageshown" value="yes">

</cfif>