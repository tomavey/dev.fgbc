<cfoutput>
<div class="row-fluid well contentStart contentBg">
    <div class="span3">
        #includePartial(partial="sidebar", selected="home")#
    </div>

    <div class="span9">

		<div id="instructions">
			#getcontent("blogs").content#

			<cfif gotrights("superadmin,office")>
			    <div id="addnew">
					#addTag()#
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
</div>
</cfoutput>
