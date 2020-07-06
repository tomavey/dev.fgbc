<div id="content">
<table class="documents">	
<cfform method="POST" action="#fbx(xfa.formaction)#" enctype="multipart/form-data">
<cfif isdefined("session.auth.username")>
	<cfinput type="hidden" name="username" value="#session.auth.username#">
<cfelse>
	<cfinput type="hidden" name="username" value="anonymous">
</cfif>
<cfif isdefined("url.edit")>
	<cfinput type="hidden" name="edit" value="yes">
</cfif>
<cfif isdefined("url.id")>
	<cfinput type="hidden" name="id" value="#url.id#">
</cfif>
<cfif isdefined("form.rights")>
	<cfinput type="hidden" name="rights" value="#form.rights#">
</cfif>
<cfif isdefined("form.sortorder")>
	<cfinput type="hidden" name="sortorder" value="#form.sortorder#">
</cfif>
<cfinput type="hidden" name="rights" value="natminprog">
<tr>
<td>Description:</td><td><cfinput type="text" name="description" size="60" value="#form.description#"></td>
</tr>
<cfif not isdefined("url.edit")>
<tr>
<td>Filename:</td><td><cfinput type="file" name="filename" size="60" ></td>
</tr>
<tr>
<td colspan="2"><p style="font-size:smaller;text-align:center">use browse button to select file"</p></td>
</tr>
<tr>
<td colspan="2" align="center"><cfinput type="submit" name="submit" value="Upload"></td>
</tr>
<cfelse>
<tr>
<td colspan="2" align="center"><cfinput type="submit" name="submit" value="Update"></td>
</tr>
</cfif>
</cfform>		
</table>       
</div>
