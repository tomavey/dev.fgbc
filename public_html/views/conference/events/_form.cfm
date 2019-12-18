<cfoutput>
						#hiddenFieldTag(name="return", value=cgi.HTTP_REFERER)#

						#hiddenField(objectName="event", property="event")#

						#textField(objectName='event', property='description', label='Event Title: ')#

						#textField(objectName='event', property='descriptionschedule', label='Description for online schedules: ')#
						<p style="font-size:.8em; margin-top:-15px; margin-left:20px">Note: public schedules will use the description used in the registration option (ie: meal) instead of this one.</p>

						<!--- #textArea(objectName='event', property='descriptionprogram', label='Program description: ')# --->

						<!--- #textField(objectName='event', property='beo', label='BEO##: ', append="<br/><br/>")# --->

						#select(objectName='event', property='category', label='Category: ', options=eventCategories(), class="input-xl")#
						<p style="font-size:.8em; margin-top:-15px; margin-left:20px">Note: these categories will show in the online public schedules: #getSetting('eventCategoriesForJson')#</p>

						#textField(objectName='event', property='manager', label='Manager: ')#

						#select(objectName='event', property='locationid', label='Location: ', options=locations, textField="roomnumber", valueField="id", includeBlank="Select One...", class="input-xl")#

						#textField(objectName='event', property='newlocation', label='New Location:<br/> (Will create a new location) ')#

						#select(objectName='event', property='eventId', label='Registration Option (if applicable): ', options=events, includeBlank="Optional...")#
<!---
Was created to give a way to connect instructors with celebration events but there was already a better way
						#select(objectName='event', property='courseId', label='Course (if applicable): ', options=courses, textField="title", includeBlank="Optional...")#

						#textField(objectName='event', property='newCourseName', label='New Course/Cohort/Workshop:<br/> (Will create a new course - you can then add instructors/speakers to this new course.) ')#
--->
			<fieldset class="when">
				<legend>Day of event: </legend>
						<cfloop list="#eventDaysOptions()#" index="i">
							<cfset thislabel = i & ": ">
 								#radioButton(objectName='event', property="day", label=thislabel, tagvalue=i)#
							<div class="clear"></div>
						</cfloop>
			</fieldset>

			<fieldset class="when">
				<legend>Time of event: </legend>
							<span>Begins: </span> #timeSelect(objectName='event', property="timebegin", class="timepicker", order="hour,minute", minuteStep=15, twelveHour=false, prependToLabel="", append="")#<br/>
							<span>Ends: </span> #timeSelect(objectName='event', property="timeend", class="timepicker", order="hour,minute", minuteStep=15, twelveHour=false, prependToLabel="", append="")#<br/>

<!---
						<cfif isdefined("event.timebegin")>
							<span>Begins: </span> #textFieldTag(name='event.timebegin', class="timepicker", value=timeformat(event.timebegin))#<br/>
						<cfelse>
							<span>Begins: </span> #textFieldTag(name='[event]timebegin', class="timepicker")#<br/>
						</cfif>

						<cfif isdefined("event.timeend")>
							<span>Ends: </span>#textFieldTag(name='[event]timeend', class="timepicker", value=timeformat(event.timeend))#
						<cfelse>
							<span>Ends: </span>#textFieldTag(name='[event]timeend', class="timepicker")#
						</cfif>
 --->
			</fieldset>

						#textField(objectName='event', property='attending', label='Expected to attend:')#

						#textArea(objectName='event', property='equipment', label='Equipment')#

						#textArea(objectName='event', property='setup', label='Setup')#

						#textField(objectName='event', property='link', label='Link (use full url)')#

						#textField(objectName='event', property='setup', label='Image (use full url')#

						#textArea(objectName='event', property='comment', label='Comments')#
</cfoutput>