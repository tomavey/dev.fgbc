<div class="eachItemShown">
<h1>Create a new equip option</h1>

<cfoutput>

			<div>#errorMessagesFor("option")#
	
			#startFormTag(action="create")#
				
				#includePartial("form")#
			
				#submitTag()#
				
			#endFormTag()#
			
<p class="addnew">
#linkTo(text="#imageTag('list-icon.png')#", action="index", title="See List")#
</p>

</cfoutput>
</div>