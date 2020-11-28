<h1>Showing course/workshop</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>
			
				
		<p>#course.title#</p>

		<p><span>Type: </span>
			#Course.type# <cfif len(course.subtype)>- #course.subtype#</cfif></p>

<cfif len(course.descriptionShort)>
	<cfset description = course.descriptionShort>
<cfelse>
	<cfset description = course.descriptionLong>
</cfif>	

				
					<p><span>Description: </span>
						#description#</p>
				
					<p><span>Event on Agenda: </span>
						#course.agenda.selectName#</p>

					<p><span>Comment: </span> <br />
						#course.comment#</p>
				
					<p><span>Comment Public: </span> <br />
						#course.commentPublic#</p>
				
					<p><span>Date created: </span>
						#dateFormat(course.createdAt)#</p>
					
<div>
	Instructors for this course:
	<ul>
		<cfoutput query="instructors">
			<li>
				#linkto(text = "#fname# #lname#", controller="conference.instructors", action="show", key=instructorId)# - 
				#linkto(text="X", controller="conference.courseinstructors", action="delete", params="courseid=#courseid#&instructorid=#instructorid#")#
			</li>
		</cfoutput>
	</ul>
</div>

#linkTo(text="Return to the listing", action="index")# |
<cfif gotRights("superadmin,office")>
#linkTo(text="Edit this course", action="edit", key=course.id)# | #linkTo(text="Add an instructor to this course", controller="conference.courseinstructors", action="new", params="courseid=#params.key#")# |<br/>
 #linkTo(text="Post a question", controller="conference.coursequestions", action="new", params="courseid=#course.id#")# |
 </cfif>
  #linkTo(text="View all the questions", controller="conference.coursequestions", action="list", params="courseid=#course.id#")# |

 </cfoutput>
