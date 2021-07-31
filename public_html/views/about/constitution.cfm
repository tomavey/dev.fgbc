<cfoutput>

<div class="row-fluid well contentStart contentBg container">
	<div class="span3">
		#(partial="whoweare", selected="constitution")#
	</div>
	<div class="span9">
		<h3 class="addBottomBorder">#variables.content.name#</h3>
		<div class="row-fluid">
			<div class="postbox" id="#params.controller##params.action#">
				#variables.content.content#
				
				<cfif gotrights("superadmin,office")>
					#variables.content.author#
					<p>Updated: #dateformat(variables.content.updatedAt)#</p>
					<p>Created: #dateformat(variables.content.createdAt)#</p>
					<cfif gotrights("superadmin")>			
						#listTag()# | #editTag(variables.content.id)#
					</cfif>
				</cfif>
		
				<p>Link to this page: #linkTo(controller="about", action="constitution", onlyPath=false)#</p>
		
			</div>
		</div>
	</div>
</div>

</cfoutput>