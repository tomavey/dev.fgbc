<cfoutput>
<div class="container">
		<div id="instructions">
			#getcontent("blogs").content#

			<cfif gotrights("superadmin,office")>
			    <div id="addnew">
					#addTag(controller="admin.blogs")#
			    </div>
			</cfif>
		</div>
		
		<table valign="top">
			<tr>
				<td valign="top" width="50%" align="left" class="eachblog">
					
						#includePartial(partial="blogs")#
							
				</td>
			</tr>
		</table>
</div>
</cfoutput>
