<cfform action="#fbx(xfa.formaction)#" method="post">
<cfif isdefined("form.id")>
	<cfinput type="hidden" name="id" value="#url.id#">
</cfif>
<cfif form.description is "">
	<cfset form.description = "">
</cfif>    
<cfif isdefined("session.auth.email")>
	<cfinput type="hidden" name="author" value="#session.auth.email#">
</cfif>
<cfinput type="hidden" name="author" value="#session.auth.email#">
<cfinput type="hidden" name="sortorder" value="15">
<cfoutput>
      <table style="width:100%">
            <tr>
                  <td>Title:</td>
                  <td><cfinput type="text" name="DESCRIPTION" id="DESCRIPTION" value="#form.DESCRIPTION#" required="yes" message="Please provide a menu description for this page">(this is how this page will be listed on the main menu.)</td>
            </tr>
            <tr>
                <td colspan="2"><textarea name="PARAGRAPH" rows="15" <cfif not isdefined("url.editHtml")>id="ckeditor" class="ckeditor"</cfif>>#form.PARAGRAPH#</textarea></td>
            </tr>
            <tr>
                  <td colspan="2" align="center"><cfinput type="submit" name="submit" value="Submit"></td>
            </tr>
      </table>
</cfoutput> 
</cfform>