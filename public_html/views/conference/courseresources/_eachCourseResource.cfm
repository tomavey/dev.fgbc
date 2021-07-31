	<cfoutput>
    <div class="eachcourseresourced">
		<h2>#linkto(text=title, action="list", params="courseid=#courseid#")#</h2>
		#linkto(text='Create a New Resource for #title#', action="new", params="courseid=#courseid#", class="courseresourcenewlink")#
		<cfoutput>
			<div class="eachcourseresource">

					<cfif isDefined("link") && len(link)>
					<p class="courseresourcelink">
						<span>Link: </span>
						#linkto(text=fixWebSite(link), href=$nameHref(link))#</p>
					</cfif>	
				
					<cfif isDefined("uploaded_file") && len(uploaded_file)>
					<p class="courseresourcefile"><span>Uploaded File: </span>
						#linkTo(text=uploaded_file, href="/files/courseresources/#uploaded_file#")#</p>
					</cfif>

					<cfif isDefined("comment") and len(comment)>
					<div class="courseresourcecomment">
						#comment#
					</div>
					</cfif>

					<p  class="courseresourceauthor"><span>Posted by </span>
						#author# (#mailto(author_email)#) on #dateformat(createdAt)# at #TimeFormat(createdAt)#
					</p>

			</div>
		</cfoutput>
					<p class="courseresourcenew">
						#linkto(text="Create a new resource for #title#", action="new", params="courseid=#courseid#", class="btn btn-block")#	
					</p>
	</div>
</cfoutput>