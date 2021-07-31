<cfparam name="format" default=true>

<cfif isDefined("params.noformat")>
  <cfset format=false>
</cfif>

<cfoutput>
  <cfif format>
    <p>Count = #cellPhoneNumbers.recordCount#</p>
    <p>SortBy: 
      #linkTo(text="Created", action="cellPhoneNumbers", params="sortBy=createdAt")# |
      #linkTo(text="Created Desc", action="cellPhoneNumbers", params="sortBy=createdAt&desc")# |
      #linkTo(text="Updated", action="cellPhoneNumbers", params="sortBy=updatedAt")# |
      #linkTo(text="Updated Desc", action="cellPhoneNumbers", params="sortBy=updatedAt&desc")# |
      #linkTo(text="Last Name", action="cellPhoneNumbers")# | 
      #linkTo(text="No Format", action="cellPhoneNumbers", params="noformat")# | 
    </p>
  </cfif>

</cfoutput>
<table>
  <tr>
    <cfif format>
      <th>Link</th>
    </cfif>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Cell Number</th>
    <th>Created</th>
    <th>Updated</th>
  </tr>
  <cfoutput query="cellPhoneNumbers">
    <tr>
      <cfif format>
        <td>#linkTo(text=">", controller="handbook.people", action="show", key=id, target="_new")#</td>  
      </cfif>
      <td>#fname#</td>
      <td>#lname#</td>
      <td>#phone2#</td>
      <td>#dateFormat(createdAt)#</td>
      <td>#dateFormat(updatedAt)#</td>
    </tr>
  </cfoutput>
</table>
