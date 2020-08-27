<cfoutput>
	
	#ckeditor()#

	<fieldset>

		<legend>#editbutton('aboutchurch')##getQuestion("aboutchurch")#</legend>

			<div class="offset1">

				<cfloop list="definition_of_a_church,history,strategic_plans,questions_history" index="i">

						#textAreaQuestionWEditButton(i)#

						<hr/>					

				</cfloop>

		</div>

	</fieldset>		

</cfoutput>