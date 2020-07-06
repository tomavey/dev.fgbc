<cfform action="#fbx(xfa.formaction)#" method="post">
<cfif isdefined("form.id")>
	<cfinput type="hidden" name="id" value="#url.id#">
</cfif>
<cfif isdefined("session.auth.email")>
	<cfinput type="hidden" name="author" value="#session.auth.email#">
</cfif>
<cfoutput>
      <table style="width:100%">
            <tr>
                  <td>Page Title</td>
                  <td><cfinput type="text" name="NAME" value="#form.NAME#" required="yes" message="Please provide a title for this page"></td>
            </tr>
            <tr>
                  <td>Menu Item</td>
                  <td><cfinput type="text" name="DESCRIPTION" value="#form.DESCRIPTION#" required="yes" message="Please provide a menu description for this page">(this is how this page will be listed on the main menu.)</td>
            </tr>
            <tr>
                  <td colspan="2" style="width:100%">
				  <textarea name="PARAGRAPH" rows="25" id="ckeditor" class="ckeditor">#form.PARAGRAPH#</textarea>
				  </td>
            </tr>

<cfif not isdefined("session.auth.email")>			
            <tr>
                  <td>Author </td>
                  <td><cfinput type="text" name="AUTHOR" value="#form.AUTHOR#">(hint: use your email address)</td>
            </tr>
</cfif>			
            <tr>
                  <td>Sortorder</td>
                  <td><cfinput type="text" name="SORTORDER" value="#val(form.SORTORDER)#"></td>
            </tr>
            <tr>
                  <td colspan="2" align="center"><cfinput type="submit" name="submit" value="Submit"></td>
            </tr>
						<cfif gotrights("superadmin")>
			<tr>
				<td colspan="2" align="center"><a href="?#cgi.QUERY_STRING#&edithtml=yes">Edit HTML</a></td>
			</tr>
			</cfif>			

      </table>
</cfoutput> 
</cfform>