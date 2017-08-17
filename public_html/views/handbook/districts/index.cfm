<div class="spann11">
<cfif gotRights("superadmin,office")>
	<cfoutput>
		#linkTo(text="Add new", action="new", class="btn")#
		#linkTo(text="Report", action="report", class="btn")#
	</cfoutput>
</cfif>
</div>
<table class="table span11">
  <cfoutput>
  <thead>
    <tr>
      <th>
	      #linkTo(text="District", params="sortby=district")#
      </th>
      <th>
      	  #linkTo(text="FC Region", params="sortby=region")#
      </th>
      <th>
          AGBM Region
      </th>
      <th>
      	  Updated
      </th>
      <th>
	      Reviewed
      </th>
      <th>
      	  &nbsp;
      </th>
      <th>
      	  &nbsp;
      </th>
    </tr>
  </thead>
  </cfoutput> 
  <tbody>
  <cfoutput query="districts">
    <tr>
      <td>
	      #linkTo(text=district, action="show", key=districtid)#
      </td>
      <td>
      	  #region#
      </td>
      <td>
          #name#
      </td>
      <td>
      	  by #mailTo(updatedBy)# on #dateformat(updatedAt)#
      </td>
      <td>
	  	  <cfif len(reviewedBy)>
      	  by #mailTo(reviewedBy)#
		  </cfif>
		  <cfif len(reviewedAt)>
		   on #dateformat(reviewedAt)#
		   </cfif>
      </td>
      <td>
      	  #showTag(districtid)# #editTag(districtid)#

          <cfset message = urlencode("Greetings! - We are updating district information for the FGBC online handbook.  Can you review the #district# district information for me?  This week? #urlFor(route="handbookDistrict", key=districtid, onlyPath="false")# Be sure to click the 'This information is correct' button when you are finished. If you are not the correct person to provide this information, please forward this email. Thanks so much!")>
          <cfset subject = urlEncode("Please review the FGBC Handbook listing for #district#")>
          <cfset sendToEmail = "">
          <cfif isDefined("updatedBy") and isDefined("reviewedBy")>
            <cfset sendToEmail = trim(updatedBy) & ";" & trim(reviewedBy)>
          </cfif>
          <cfif isDefined("updatedBy") and NOT isDefined("reviewedBy")>
            <cfset sendToEmail = trim(updatedBy)>
          </cfif>  
          <cfif isDefined("reviewedBy") and NOT isDefined("updatedBy")>
            <cfset sendToEmail = trim(reviewedBy)>
          </cfif>  
		 	#mailTo(
				name='<i class="icon-envelope"></i>',
				emailaddress='#sendToEmail#?subject=#subject#&body=#message#',
				alt="e")#
      </td>
    </tr>
    
  </cfoutput>
  </tbody>
</table>
