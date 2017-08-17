<cfoutput>
<fieldset class="well">
<legend>Dates, Social Media and Ministry:</legend>

						#hiddenField(objectName='handbookperson', association='handbookprofile', property='personid')#
						
						#hiddenField(objectName='handbookperson', association='handbookprofile', property='createdby')#
						
					<p>Birthday:
						#select(options=getMonthsQuery(), objectName='handbookperson', association='handbookprofile', property='birthdayMonthNumber', label="", includeBlank="----Month---", class="input-small", prependToLabel="", appendToLabel="", prepend="", append="")#
						#select(options=getDaysInMonth(), objectName='handbookperson', association='handbookprofile', property='birthdayDayNumber', label="", includeBlank="----Day---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
						#select(options=getYearsList(), objectName='handbookperson', association='handbookprofile', property='birthdayYear', label="", includeBlank="----Year---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
					</p>	
					
					<p>Spouses' Birthday:
						#select(options=getMonthsQuery(), objectName='handbookperson', association='handbookprofile', property='wifesBirthdayMonthNumber', label="", includeBlank="----Month---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
						#select(options=getDaysInMonth(), objectName='handbookperson', association='handbookprofile', property='wifesBirthdayDayNumber', label="", includeBlank="----Day---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
						#select(options=getYearsList(), objectName='handbookperson', association='handbookprofile', property='wifesBirthdayYear', label="", includeBlank="----Year---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
					</p>	

					<p>Anniversary:
						#select(options=getMonthsQuery(), objectName='handbookperson', association='handbookprofile', property='anniversaryMonthNumber', label="", includeBlank="----Month---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
						#select(options=getDaysInMonth(), objectName='handbookperson', association='handbookprofile', property='anniversaryDayNumber', label="", includeBlank="----Day---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
						#select(options=getYearsList(), objectName='handbookperson', association='handbookprofile', property='anniversaryYear', label="", includeBlank="----Year---", class="input-small", prependToLabel="", appendToLabel="", appendToLabel="", prepend="", append="")#
					</p>	

						#textField(objectName='handbookperson', property='web', label='Web address: ')#
					
						#textField(objectName='handbookperson', association='handbookprofile', property='facebook', label='Facebook Address: ')#
					
						#textField(objectName='handbookperson', association='handbookprofile', property='twitter', label='Twitter Address: ')#
					
						#textField(objectName='handbookperson', association='handbookprofile', property='linkedin', label='Linkedin Address: ')#
					
						#textField(objectName='handbookperson', association='handbookprofile', property='othersocial', label='Other Social Media: ')#
						
						#select(objectName='handbookperson', association='handbookprofile', property='ministrystartat', label='When did you begin ministry in a Grace Brethren Church?', options=licensedOrOrdainedAtOptions(), includeBlank="---")#
						
						#textArea(objectName='handbookperson', association='handbookprofile', property='currentministry', label='How did you get started? Where have you served and when? If you are in training, what are your goals? (200 words or less)', class="ckeditor", rows="5", cols="400")#

						#select(objectName='handbookperson', association='handbookprofile', property='licensedOrOrdained', options="No,Yes", label='Licensed or Ordained? ', class="input-small")#

						#select(objectName='handbookperson', association='handbookprofile', property='licensedOrOrdainedAt', label="When?", options=licensedOrOrdainedAtOptions(), class="input-small", includeBlank="---", order="year")#</p>

</fieldset>
</cfoutput>
