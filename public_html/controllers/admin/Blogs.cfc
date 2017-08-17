<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="index,edit,show,new,delete")>
		<cfset filters(through="setReturn", only="index,list")>
		<cfset usesLayout("/layoutadmin")>
	</cffunction>
	
	<!--- blogs/index --->
	<cffunction name="index">
		<cfset blogs = model("Mainblog").findAll()>
	</cffunction>
	
	<cffunction name="list">
		<cfset blogs = model("Mainblog").findAll(where="active='yes'", order="createdAt DESC")>
		<cfif isdefined("url.items")>
			<cfset nitems = url.items>
		<cfelse>
			<cfset nitems = 4>
		</cfif>
	</cffunction>
	
	<!--- blogs/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset blog = model("Mainblog").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(blog)>
	        <cfset flashInsert(error="blog #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- blogs/new --->
	<cffunction name="new">
		<cfset blog = model("Mainblog").new()>
	</cffunction>
	
	<!--- blogs/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset blog = model("Mainblog").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(blog)>
	        <cfset flashInsert(error="blog #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- blogs/create --->
	<cffunction name="create">

		<cfset blog = model("Mainblog").new(params.blog)>
		
		<!--- Verify that the blog creates successfully --->
		<cfif blog.save()>
			<cfset flashInsert(success="The blog was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the blog.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- blogs/update --->
	<cffunction name="update">
		<cfset blog = model("Mainblog").findByKey(params.key)>
		
		<!--- Verify that the blog updates successfully --->
		<cfif blog.update(params.blog)>
			<cfset flashInsert(success="The blog was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the blog.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- blogs/delete/key --->
	<cffunction name="delete">
		<cfset blog = model("Mainblog").findByKey(params.key)>
		
		<!--- Verify that the blog deletes successfully --->
		<cfif blog.delete()>
			<cfset flashInsert(success="The blog was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the blog.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
	<cffunction name="undelete">
		<cfif isdefined("params.key")>
			<cfset blog = model("Mainblog").findByKey(params.key)>
			<cfset blog.deletedAt = "null">
			<cfset blog.update(params.key)>
		<cfelse>
			<cfset model("Mainblog").unDeleteAll()>
		</cfif>					
		<cfset redirectTo(action="index")>
	</cffunction>
	
	<cffunction name="insertsql">
		<cfset useslayout("/layout_naked")>
		<cfset blogs = model("Mainblog").findall()>
		<cfset fieldslist = "">
		<cfloop list="#blogs.columnList#" index="i">
			<cfset fieldslist = fieldslist & "','" & i>
		</cfloop>
		<cfset fieldslist = replace(fieldslist,"',","","one")& "'">
		<cfset columnlist = blogs.columnlist>
	</cffunction>
	
</cfcomponent>
