<table id="datatable">
   	<thead>
      <tr>
            <th> FILENAME </th>
            <th> DESCRIPTION </th>
            <th> DATETIME </th>
            <th> AUTHOR </th>
			<th> &nbsp;</th>
      </tr>
	 </thead>
	 <tbody> 
<cfoutput query="documents">
      <tr>
            <td> <a href="http://www.fgbc.org/docs/#FILENAME#" id="doclink">http://www.fgbc.org/docs/#FILENAME#</a><br/> </td>
            <td> #DESCRIPTION# </td>
            <td> #dateformat(DATETIME,"yy-mm-dd")# </td>
            <td> <a href="mailto:#scramble(AUTHOR)#">#author#</a> </td>
            <td> <a href="#fbx('editdocument')#&id=#id#">edit</a> <a href="#fbx('deletedocument')#&id=#id#" onclick="if(confirm('Are you sure you want to delete #description#?')) window.location('#fbx('deletedocument')#&id=#id#');return false">delete</a> <a href="mailto:?body=http://www.fgbc.org/docs/#FILENAME#">Send</a></td>
      </tr>
</cfoutput>
	</tbody>
</table>

