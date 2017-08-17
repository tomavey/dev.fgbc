<cfoutput>
			<cfif isDefined("positions")>
				<div>
					<cfloop query="positions">
                        <p id="stafflist">#position# - 
                        <cfif gotrights("superadmin,office,handbook,agbmadmin")>
						          #linkto(
											text=name,
											controller="handbook.Organizations",
											action="show",
											class="tooltipbottom ajaxclickable",
											title="Click to show #name# in the center panel.",
											key=organizationid
											)#
                        <cfelse>
                            #selectNameCity2#
                        </cfif>                    
						<cfif gotrights("superadmin")>
							#deleteTag(controller="handbook.positions", action="delete", key=positionTypeId)#
						</cfif>
						</p>
					</cfloop>
					<cfif gotrights("office,handbookedit")>
					<p class="stafflist">#linkto(text="<i class='icon-plus'></i>", controller='handbook.positions', action="new", title="Add a new position for #handbookperson.fname#", key=params.key)#</p>
					</cfif>
				</div>
			</cfif>
</cfoutput>