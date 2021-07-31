<cfoutput>
	
	#ckeditor()#

	<fieldset>

		<legend>#editbutton('aboutchurch')##getQuestion("aboutchurch")#</legend>

			<div class="offset1">

				<cfloop list="relationship,cooperation,why_membership" index="i">

						#textAreaQuestionWEditButton(i)#

						<hr/>					

				</cfloop>

		</div>

	</fieldset>		

</cfoutput>