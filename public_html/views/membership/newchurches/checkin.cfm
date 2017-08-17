<cfoutput>

<cfif NOT flashIsEmpty()>
<h2>#flashMessages()#</h2>
</cfif>
	<fieldset>
		<legend>Let's get started:</legend>

			<div class="offset1">
				#startFormTag(action=formaction)#
		
						#textField(
							objectName='newchurch', 
							property='email', 
							label="What is your email address?", class="input-xlarge"
							)#
																
				#submitTag("Start the form for a new church.")#
					
				#endFormTag()#
			</div>				

	</fieldset>	
	<div class="well">
		When you send us your email address, we will send you a link to start a new form that asks:
		<ul>
			<li>Your contact information.</li>
			<li>Name and location of the new church.</li>
			<li>Names of five families in the new church.</li>
			<li>When and how your group committed to become a church.</li>
		</ul>
	</div>
</cfoutput>