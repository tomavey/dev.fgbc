<cfoutput>
  <p>Count = #cellPhoneNumbers.recordCount#</p>
  <p>SortBy: 
    #linkTo(text="Created", action="cellPhoneNumbers", params="sortBy=createdAt")# |
    #linkTo(text="Created Desc", action="cellPhoneNumbers", params="sortBy=createdAt&desc")# |
    #linkTo(text="Updated", action="cellPhoneNumbers", params="sortBy=updatedAt")# |
    #linkTo(text="Updated Desc", action="cellPhoneNumbers", params="sortBy=updatedAt&desc")# |
    #linkTo(text="Last Name", action="cellPhoneNumbers")#
  </p>

</cfoutput>
<table>
  <tr>
    <th>Link</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Cell Number</th>
    <th>Created</th>
    <th>Updated</th>
  </tr>
  <cfoutput query="cellPhoneNumbers">
    <tr>
      <td>#linkTo(text=">", controller="handbook.people", action="show", key=id, target="_new")#</td>  
      <td>#fname#</td>
      <td>#lname#</td>
      <td>#phone2#</td>
      <td>#dateFormat(createdAt)#</td>
      <td>#dateFormat(updatedAt)#</td>
    </tr>
  </cfoutput>
</table>
