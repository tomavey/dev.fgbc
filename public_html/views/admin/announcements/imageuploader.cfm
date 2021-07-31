<cfoutput>
<h3>Upload picture here:</h3>	
   			
  #startFormTag(controller="announcements", action="uploadImage", multipart="true")#
      						
  #fileFieldTag(name='image', label='Image:')#
      							
  #submitTag(value="Upload")#
    						
#endFormTag()#
</cfoutput>