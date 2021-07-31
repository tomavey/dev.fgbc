<table>
      <tr>
            <th> NAME </th>
            <th> DESCRIPTION </th>
            <th> AUTHOR </th>
            <th> SORTORDER </th>
            <th> DATETIME </th>
			<th> <a href="<cfoutput>#fbx('addnewcontent')#</cfoutput>">add new</a></th>
      </tr>
<cfoutput query="content">
      <tr>
            <td> #NAME# </td>
            <td> #DESCRIPTION# </td>
            <td> #AUTHOR# </td>
            <td> #SORTORDER# </td>
            <td> #dateformat(DATETIME)# </td>
			<td> <a href="#fbx('editcontent')#&id=#id#">edit</a> <a href="#fbx('deletecontent')#&id=#id#">delete</a></td>
      </tr>
</cfoutput>
</table>
<p><a href="<cfoutput>#fbx('addnewcontent')#</cfoutput>">add new</a></p>