<h1>Showing instructor</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p>#instructor.fname# #instructor.lname#</p>
				
					<p><span>Pedigree: </span> 
						#instructor.pedigree#</p>
				
					<p><span>Phone: </span> 
						#instructor.phone#</p>
				
					<p><span>Email: </span> 
						#mailto(instructor.email)#</p>
				
				<div class="well">
					<p><span>Bio Web: </span> <br />
						#instructor.bioWeb#</p>
				
					<p><span>Bio Print: </span> <br />
						#instructor.bioPrint#</p>
				
					<p><span>Bio Original: </span> <br />
						#instructor.bioOriginal#</p>
				</div>		
				
				<div class="well">
				<p>Images need to be uploaded to /images/conference/instructors/</p>
				<cfif FileExists(ExpandPath("/images/conference/instructors/#instructor.picBig#"))>
					<p><span>Pic Big: </span>
						<a href="/images/conference/instructors/#instructor.picBig#">#instructor.picBig#</a>
					</p>
				</cfif>		
				
				<cfif FileExists(ExpandPath("/images/conference/instructors/#instructor.picThumb#"))>
					<p><span>Pic thumbnail: </span>
						<a href="/images/conference/instructors/#instructor.picThumb#">#imageTag(source="/conference/instructors/#instructor.picThumb#")#</a></p>
				<cfelse>		
					<p><span>Pic Thumb: </span> 
						#instructor.picThumb#</p>
				</cfif>

				<cfif FileExists(ExpandPath("/images/conference/instructors/#instructor.pic120x120#"))>
					<p><span>Pic 120x120 for Mobile App: </span>
						<a href="/images/conference/instructors/#instructor.pic120x120#">#imageTag(source="/conference/instructors/#instructor.pic120x120#")#</a></p>
				<cfelse>		
					<p><span>Pic 120x120 for Mobile App: </span> 
						#instructor.pic120x120#</p>
				</cfif>
				</div>

					<p><span>Comment: </span> <br />
						#instructor.comment#</p>
				
					<p><span>Tags: </span>#instructor.tags#</p>

					<p><span>Created: </span> 
						#dateFormat(instructor.createdAt)#</p>

<ul>				
	<cfoutput query="courses">
		<li>
			#linkto(text=title, controller="conference.courses", action="show", key=courseid)# - 
			#linkto(text="X", controller="conference.courseinstructors", action="delete", params="courseid=#courseid#&instructorid=#instructorid#")#
		</li>
	</cfoutput>
</li>

			
#linkTo(text="Return to the listing", action="index")#
<cfif gotRights("superadmin,office")>
 | #linkTo(text="Edit this instructor", action="edit", key=instructor.id)# | #linkTo(text="New Course for this instructor", controller="conference.courseinstructors", action="new", params="instructorid=#params.key#")#
</cfif>
</cfoutput>
