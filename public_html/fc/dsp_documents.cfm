   
<table id="datatable">
      <thead>
      <tr>
	        <th> FILENAME </th>
            <th> DESCRIPTION </th>
            <th> DATETIME </th>
            <th> AUTHOR </th>
			<th>&nbsp; </th>
      </tr>
	  </thead>
	  <tbody>
<cfoutput query="documents">
      <tr>
            <td> <a href="http://www.fgbc.org/fc/documents/#FILENAME#" id="doclink">http://www.fgbc.org/fc/documents/#FILENAME#</a><br/> </td>
            <td> #DESCRIPTION# </td>
            <td> #dateformat(DATETIME)# </td>
            <td> <a href="mailto:#scramble(AUTHOR)#">#author#</a> </td>
            <td> <a href="#fbx('deletedocument')#&id=#id#" onclick="if(confirm('Are you sure you want to delete #description#?')) window.location('#fbx('deletedocument')#&id=#id#');return false", class="ajaxdeleterow">delete</a> <a href="mailto:?body=http://www.fgbc.org/fc/documents/#urlEncodedFormat(FILENAME)#">Send</a></td>
      </tr>
</cfoutput>
	<tbody>
</table>
