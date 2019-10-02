<cfoutput>

	<!--- <cfif gotRights("office")>	
<p>
You are logged in! Entering one of these email addresses will result in a registration mark "paid" without going through the online payment system.
<ul>
	<cfloop list="#getsetting('testagents')#" index='i'>
	<li>
		#i#
	</li>
	</cfloop>
</ul>
</p>	
</cfif> --->

<div id="getagent">

		<cfif NOT flashIsEmpty()>
			<div id="flash-messages" class="alert">
				<cfif flashKeyExists("error")>
					<h3 class="errorMessage">
						#flash("error")#
					</h3>
				</cfif>
			</div>
		</cfif>

			#startFormTag(action="checkout", key=params.key)#

			#textFieldTag(name="agent", label="Who do you want a receipt sent to? ", value='#agentemail#')#
			#submitTag('Submit')#
				
			#endFormTag()#
			<p><sup>#message#</sup><p>			
</div>
</cfoutput>