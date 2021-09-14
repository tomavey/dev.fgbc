<!--- <cfoutput>#data.ColumnList#</cfoutput> --->
<table>
    <tr>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Membership Fee</th>
      <th>Membership Year</th>
      <th>Category</th>
      <th>Status</th>
      <th>Person Id</th>
      <th>Comments</th>
    </tr>

  <cfoutput query="data">
    <tr>
      <td>
        #fname#
      </td>
      <td>
        #lname#
      </td>
      <td>
        #dollarformat(MEMBERSHIPFEE)#
      </td>
      <td>
        #MEMBERSHIPFEEYEAR#
      </td>
      <td>
        #category#
      </td>
      <td>
        #statuss#
      </td>
      <td>
        #inspireId(personid,lname)#
      </td>
      <td>
        #comments#
      </td>
    </tr>

  </cfoutput>
</table>
<cfoutput>
  <p>
    Record Count: #data.recordcount#
  </p>
</cfoutput>