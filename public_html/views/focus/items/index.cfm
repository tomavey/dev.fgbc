<cfoutput>

<cfif isDefined("params.retreatid")>
	<h1>Use this page to create registration options for #getRetreatRegId(params.retreatId)#</h1>
	<p>#linkTo(text="New item", action="new", params="retreatId=#params.retreatid#")#</p>
<cfelse>
	<h1>Use this page to create registration options for each retreat...</h1>
	<p>#linkTo(text="New item", action="new")#</p>
</cfif>



<table class="table table-striped">
	<tr>
		<th>
			Name
		</th>
		<th>
			Retreat
		</th>
		<th>
			Description
		</th>
		<th>
			Price
		</th>
		<th>
			Category
		</th>
		<th>
			Sort Order
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
	<cfoutput query="items">
		<tr>
			<td>
				#name#
			</td>
			<td>
				#regid#
			</td>
			<td>
				#description#
				<cfif len(popup)>
					<a href="" title="#popup#" class="tooltipside"><i class="icon-info-sign"></i></a>
				</cfif>
			</td>
			<td>
				#price#
			</td>
			<td>
				#category#
			</td>
			<td>
				#sortOrder#
			</td>
			<td>
				#editTag()# #deleteTag()# #showTag()# #copyTag()# #linkTo(text="<i class='icon-list'></i>", controller="focus", action="registrations", params="itemid=#id#")#				
			</td>
		</tr>
	</cfoutput>
	
</table>	

<cfif isDefined("params.retreatid")>
	<p>#linkTo(text="New item", action="new", params="retreatId=#params.retreatid#")#</p>
<cfelse>
	<p>#linkTo(text="New item", action="new")#</p>
</cfif>

</cfoutput>
