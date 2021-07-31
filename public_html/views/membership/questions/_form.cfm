<cftry>
<cfset questionInEnglish = getQuestion(fieldname=membershipappquestion.field, language="English")>
<cfif questionInEnglish is "No Question" OR membershipappquestion.language is "English">
	<cfset showenglish = false>
<cfelse>	
	<cfset showenglish = true>
</cfif> 
	<cfcatch>
		<cfset showenglish = false>
	</cfcatch>
</cftry>

<cfoutput>
#ckeditor()#
						#textField(objectName='membershipappquestion', property='field', label='Field')#

						<div style="font-size:.8em;font-color:gray" class="well">Application Fieldnames: #fieldnames#</div>

						#select(objectName='membershipappquestion', property='language', label='Language', options="English,French,Spanish")#

						<cfif showenglish>
						Text in English...	
							<div class="well">
								#questioninEnglish#
							</div>	
						</cfif>
																
						#textArea(objectName='membershipappquestion', property='question', label='Translation', class="ckeditor")#

</cfoutput>