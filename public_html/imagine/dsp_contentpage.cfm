<cfif isdefined("url.originalid")>
	<cfset attribute.editable = "no">
<cfelse>
	<cfset attribute.editable = "yes">
</cfif>
		
    <cfoutput>
	<cfif not attribute.editable>
	<p><h2>History: #dateformat(content.datetime)# by #content.author# (not editable)</h2></p>
	</cfif>
	<cfif attribute.editable>
   		<p id="editlink"><a href="#fbx('editcontent')#&id=#id#"><img src="/images/edit.png"></a></p>
	</cfif>
  		#content.paragraph#</cfoutput>
	<cfif attribute.editable>	
		<cfform action="#fbx('editcontent')#&id=#id#" id="editbutton"><cfinput type="submit" name="submit" value="Edit This Page"></cfform>
	</cfif>
   <cfif isdefined("url.code")><a id="buttonOne">Click here to Add this Page to Favourites</a></cfif> 
	<cfif attribute.editable and history.recordcount>
	<p id="history">History:<cfoutput query="history"><a href="#fbx('content')#&id=#id#&originalid=#content.id#">#dateformat(datetime)# by #author#</a>
	</cfoutput></p>
	</cfif>
