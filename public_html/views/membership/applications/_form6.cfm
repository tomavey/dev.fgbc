<cfset optionslist = queryNew("display,value")>
<cfset queryAddRow(optionslist)>
<cfset querySetCell(optionsList,"display",stripTags(getQuestion('iscomplete')))>
<cfset querySetCell(optionsList,"value","yes")>
<cfset queryAddRow(optionslist)>
<cfset querySetCell(optionsList,"display",stripTags(getQuestion('isnotcomplete')))>
<cfset querySetCell(optionsList,"value","no")>

<cfoutput>
	
	#ckeditor()#

	<fieldset>

		<legend>#editbutton('onemore')##getQuestion("onemore")#</legend>

			<div class="offset1">

				#selectYesNoQuestionWEditButton('completed')#

			</div>

	</fieldset>		

</cfoutput>