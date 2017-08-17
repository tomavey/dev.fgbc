<h1>Upload a Picture</h1>

<cfoutput>
<p>#linkto(text=handbookperson.fullname, controller="handbook.people", action="show", key=handbookperson.id)#</p>
		<cfif handbookpictures.recordcount>
		<ul class="thumbnails">
			<cfloop query="handbookpictures">
			<cftry>
			<li class="thumbnail">
				<cfset picHref = replace(cgi.script_name,"index.cfm","")>
				<cfset picHref = replace(cgi.script_name,"rewrite.cfm","")>
				#linkTo(text=imageTag(source="/handbookpictures/thumb_#file#"), href="#picHref#images/handbookpictures/web_#file#", title="View larger Image", class="tooltip2")#<br/>
				#deleteTag(title="Delete This Image", class="tooltip2")#
        			<cfif useFor is "default">
        			  #linkTo(text="<br/>This is the <br/>default image", href="##", class="tooltipside", title="This is the default image")#
        			<cfelse>  			
                      #linkTo(text='<i class="icon-ok"></i>', controller="handbook.pictures", action='setPictureAsDefault', key=ID, class="tooltipside", title="Set this picture as the default")#
        			</cfif>  
			</li>		
				<cfcatch>#deleteTag()#</cfcatch>
				</cftry>
			</cfloop>
		</ul>	
		</cfif>		

			#errorMessagesFor("handbookpicture")#
	
			#startFormTag(action="create", multipart="true")#
		
				
						#hiddenField(objectName='handbookpicture', property='personid')#
						
						<cfif not isdefined("params.personid")>
							#textField(objectName='handbookpicture', property='name', label='Name: ')#
						</cfif>
					
						#fileField(objectName='handbookpicture', property='file', label='Maximum size is 300kb: ', class='maxfilesize')#

<!---					
						#select(objectName='handbookpicture', property='type', label='Type', options="Regular,Thumbnail")#
						#textArea(objectName='handbookpicture', property='description', label='Description')#

--->					
					
						#hiddenField(objectName='handbookpicture', property='createdBy')#
					

				#submitTag("Upload")#
				
			#endFormTag()#

<cfif gotRights("superadmin")>
	<p>#linkTo(text="New Picture", action="new", class="btn")#</p>
</cfif>
			
</cfoutput>
