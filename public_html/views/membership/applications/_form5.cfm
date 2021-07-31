<cfoutput>
	
	#ckeditor()#

	<fieldset>

		<legend>#editbutton('aboutchurch')##getQuestion("aboutchurch")#</legend>

			<div class="offset1">

						#textAreaQuestionWEditButton('questions_constitution')#
																
						<hr/>					

						#textFieldQuestionWEditButton('statement_of_faith')#

						<hr/>					

						#textAreaQuestionWEditButton('problems')#
																
						<hr/>					

				<cfloop list="agree,member_count,date_fee_sent" index="i">

						#textFieldQuestionWEditButton(i)#

						<hr/>					
					
				</cfloop>		

		</div>

	</fieldset>		

</cfoutput>