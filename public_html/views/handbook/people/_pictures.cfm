<cfoutput>
<div>
<cfset isPictures=arraylen(handbookperson.handbookpictures)>

<cfset pictureShown = false>
        		<cfif isPictures>
					  <cfloop from="1" to="#ispictures#" index="i">
					  <cfif isPictures EQ 1 OR handbookperson.handbookpictures[i].usefor is "default">
        				#linkTo(
								text=imageTag(source="/handbookpictures/thumb_#handbookperson.handbookpictures[i].file#"),
								href="/images/handbookpictures/web_#handbookperson.handbookpictures[i].file#")
								#
						<cfset pictureShown = true>
						<cfbreak>
						</cfif>
						</cfloop>
						<cfif not pictureShown>
            				#linkTo(
    								text=imageTag(source="/handbookpictures/thumb_#handbookperson.handbookpictures[ispictures].file#"),
    								href="/images/handbookpictures/web_#handbookperson.handbookpictures[ispictures].file#")
    								#
						</cfif>
						<cfif isPictures GT 1 AND not isAjax()>
							#linkTo(text="<i class='icon-picture'></i>", controller="handbook.pictures", action="index", params="personid=#params.key#", class="tooltipside", title="Show more pictures of #handbookperson.fname#")#
						</cfif>
        		</cfif>
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