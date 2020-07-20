<cfoutput>
  Count = #cellPhoneNumbers.recordCount#
</cfoutput>
<table>
  <tr>
    <th>Link</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Cell Number</th>
  </tr>
  <cfoutput query="cellPhoneNumbers">
    <tr>
      <td>#linkTo(text=">", controller="handbook.people", action="show", key=id, target="_new")#</td>  
      <td>#fname#</td>
      <td>#lname#</td>
      <td>#phone2#</td>
    </tr>
  </cfoutput>
</table>
