<h1>Edit my story...</h1>

<div>
<cfoutput>

#ckeditor()#

#startFormTag(action="update")#

#hiddenField(objectName="testimony", property="id")#

#putFormTag()#

#includePartial(partial="form")#

#submitTag()#

#endFormTag()#

</cfoutput>
</div>