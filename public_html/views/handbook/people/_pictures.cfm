
<cfoutput>
<div>
<!---how many pictures are connected to this person--->	
<cfset var isPictures=arraylen(handbookperson.handbookpictures)>
<!--- <cfset ddd(handbookperson.handbookpictures)> --->
<!---default switch for has a picture been shown--->
<cfset var pictureShown = false>
<cfset var noPicsList = "">

		<cftry>
   		<cfif isPictures>
				<cfloop from="1" to="#isPictures#" index="i">
					<cfset var thisPic = handbookperson.handbookpictures[i]>

					<!---Show one picture--->
					<cfif isPictures == 1 || (isDefined('thisPic.usefor') &&  thisPic.usefor == "default") && pictureExists(thisPic.file,"thumb_")>
						<cfif pictureExists(thisPic.file,"web_")>
							#linkTo(
									text=imageTag(source="/handbookpictures/thumb_#thisPic.file#"),
									href="/images/handbookpictures/web_#thisPic.file#")
									#
						<cfelse>
							#imageTag(source="/handbookpictures/thumb_#thisPic.file#")#
						</cfif>		
						<!---Switch on for a picture has been shown then break the loop--->		
						<cfset pictureShown = true>
						<cfbreak>
					<cfelse>
						<cfset noPicsList = noPicsList & ', ' & '#thisPic.file#'>
					</cfif>

				</cfloop>

				<!---If no picture has been shown, display a link to upload--->
				<cfset thisPic = handbookperson.handbookpictures[isPictures]>
				<cfif not pictureShown && pictureExists(thisPic.file,'thumb_')>
					#linkTo(
						text=imageTag(source="/handbookpictures/thumb_#thisPic.file#"),
						href="/images/handbookpictures/web_#thisPic.file#"
					)#
				<cfelse>
					<cfset noPicsList = noPicsList & '#thisPic.file#'>
				</cfif>

				<!---Show all the pictures--->
				<cfif isPictures GT 1 AND not isAjax()>
					#linkTo(text="<i class='icon-picture'></i>", controller="handbook.pictures", action="index", params="personid=#params.key#", class="tooltipside", title="Show more pictures of #handbookperson.fname#")#
				</cfif>

			</cfif>
				 
			<cfcatch>
				<cfif gotRights("office")>
					Missing picture(s) #isPictures# #noPicsList#
				<cfelse>
					*	
				</cfif>
			</cfcatch>

		</cftry>
    				<cfif !isAjax() && 
					(
							(
								isDefined("session.auth.handbook") AND isDefined("session.auth.handbook.people") 
								&& gotHandbookPersonRights(handbookperson.id)
							) 
							|| 
							gotrights("superadmin,office,agbmadmin,handbookedit") 
							|| 
							(
								isDefined("session.auth.handbook.people")
								&& 
								isMinistryStaff(session.auth.handbook.people)
							)
					)
							>
						#linkTo(text="<i class='icon-plus'></i>", controller="handbook.pictures", action="new", params="personid=#params.key#", class="tooltipside", title="Add a picture of #handbookperson.fname#")#
					</cfif>
</div>
</cfoutput>