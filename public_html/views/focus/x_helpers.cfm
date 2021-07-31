<!--- Place helper functions here that should be available for use in all view pages of your application --->

<cffunction name="addTag">
	<cfreturn "#linkTo(text='#imageTag('/add-icon.png')#', action='new', title="Add New")#">
</cffunction>

<cffunction name="deleteTag">
	<cfreturn "#linkTo(text='#imageTag('/delete-icon.png')#', action='delete', key=ID, title="delete", class="ajaxdeleterow")#">
</cffunction>

<cffunction name="showTag">
	<cfreturn "#linkTo(text="#imageTag('/view-icon.png')#", action='show', key=ID, title="show")#">
</cffunction>

<cffunction name="copyTag">
	<cfreturn "#linkTo(text="#imageTag('/copy-icon.png')#", action='copy', key=ID, title="copy")#">
</cffunction>

<cffunction name="editTag">
	<cftry>
		<cfreturn "#linkTo(text='#imageTag("/edit-icon.png")#', controller=params.controller, action='edit', key=id, title='edit')#">
	<cfcatch>
		<cfreturn "edit tag not working">
	</cfcatch>
	</cftry>
</cffunction>

<cffunction name="inPageEditTag">
<cfargument name="id" required="true">	
	<cfif not isnumeric('arguments.id')>
		<cfset arguments.id = model("content").findOne(where="name='#arguments.id#'").id>
	</cfif>
		<cftry>
			<cfreturn "#linkTo(text='#imageTag("/edit-icon.png")#', controller="contents", action='edit', key=arguments.id, title='edit')#">
		<cfcatch>
			<cfreturn "edit tag not working">
		</cfcatch>
		</cftry>
</cffunction>

<cffunction name="linkToData">
<cfset var loc=structNew()>	
	<cfloop list="#structKeylist(arguments)#" index="i">
		<cfset loc[replace(i,"_","-","all")] = arguments[i]>
	</cfloop>
	<cfreturn linkTo(argumentCollection=loc)>
</cffunction>

<cffunction name="dateText">
<cfargument name="begin" required="yes" type="string">	
<cfargument name="end" required="yes" type="string">	
<cfset var datetext = "">
	<cfif datepart("m",arguments.begin) is datepart("m",arguments.end)>
       <cfset datetext = "#dateformat(arguments.begin,"MMM")# #dateformat(arguments.begin,"dd")# - #dateformat(arguments.end,"dd")#, #dateformat(arguments.begin,"yyyy")#">
    <cfelse>
       <cfset datetext = "#dateformat(arguments.begin,"MMM")# #dateformat(arguments.begin,"dd")# - #dateformat(arguments.end,"MMM")# #dateformat(arguments.end,"dd")#, #dateformat(arguments.begin,"yyyy")#">
    </cfif>
<cfreturn datetext>

</cffunction>

<cffunction name="ckeditor">
<cfreturn '<script type="text/javascript" src="/focus/files/plugins/richtext/ckeditor/ckeditor.js">
</script>'>
</cffunction>