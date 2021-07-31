<cfoutput query="option">
<div class="eachItemShown show">

					<p><span>Id: </span>
						#option.Id#</p>

					<p><span>Name: </span>
						#option.name#</p>

					<p><span>Button Description: </span> <br />
						#option.buttondescription#</p>

					<p><span>Description: </span> <br />
						#option.description#</p>

					<p><span>Cost: </span>
						#numberformat(option.cost, "$9999.99")#</p>

					<p><span>Type: </span>
						#option.type#</p>

					<p><span>Button Type: </span>
						#option.buttontype#</p>

					<p><span>Event: </span>
						#option.event#</p>

					<p><span>Discount Depends on: </span>
						#option.discountDependsOn#</p>

					<p><span>Qualifies for Family Discount: </span>
						#option.qualifiesforfamilydiscount#</p>

					<p><span>Comment: </span> <br />
						#option.comment#</p>

					<p><span>Ad: </span> <br />
						#option.ad#</p>

					<p><span>Image: </span>
						#option.image#</p>

					<p><span>Link: </span>
						#option.link#</p>

					<p><span>Sortorder: </span>
						#option.sortorder#</p>

					<p><span>Created: </span>
						#dateformat(option.createdat, "medium")#</p>

					<p><span>Updated: </span>
						#dateformat(option.updatedat, "medium")#</p>


</div>

</cfoutput>
<cfoutput>
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this option", action="edit", key=option.Id)#</cfoutput>