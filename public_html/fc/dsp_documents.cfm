   
<table id="Xdatatable">
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
      <cfif fileExists(Expandpath("documents/" & filename))>
            <tr>
                  <td>
                  <a href="http://charisfellowship.us/fc/documents/#FILENAME#" id="doclink">http://charisfellowship.us/fc/documents/#FILENAME#</a><br/> 
                  </td>
                  <td> #DESCRIPTION# </td>
                  <td> #dateformat(DATETIME)# </td>
                  <td> <a href="mailto:#scramble(AUTHOR)#">#author#</a> </td>
                  <td> <a href="#fbx('deletedocument')#&id=#id#" onclick="if(confirm('Are you sure you want to delete #description#?')) window.location('#fbx('deletedocument')#&id=#id#');return false", class="ajaxdeleterow">delete</a> <a href="mailto:?body=http://www.fgbc.org/fc/documents/#urlEncodedFormat(FILENAME)#">Send</a></td>
            </tr>
      </cfif>
</cfoutput>
	<tbody>
</table>
<cfif !isDefined("url.showall")>
      <a href="index.cfm?fuseaction=abstracts&showall&showall">Show All</a>
<cfelse>
      <p style="text-align:center;font-size:1.5em;margin-top:30px">all files in the documents directory - even if not listed in the docs database</p>
      <cfdirectory directory = "#Expandpath("./")#/documents/" action = "list" name = "filelist" recurse=true>
      <table>
            <tr>
                  <th>File</th>
                  <th>Date</th>
            </tr>
        <cfoutput query="filelist">
            <tr>
                  <cfif GetDirectoryFromPath(directory) EQ "documents">
                        <td><a href="/fc/documents/#name#">#left(name,30)#@@</a></td>
                  <cfelse>
                        <td><a href="/fc/documents/temp/#name#">#left(name,30)#</a></td>
                  </cfif>
                  <td>#dateformat(dateLastModified)#</td>
            </tr>
        </cfoutput>
      </table>
</cfif>