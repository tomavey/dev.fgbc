<h1>Showing Invoice</h1>
<cfoutput>
#linkToList(text="Return to the listing", action="index")# 

<div class="eachItemShown show">

<div class="eachinvoice">
					<p><span>ID: </span> 
						#invoice.ID#</p>
				
					<p><span>Order Id: </span> 
						#invoice.ccOrderId#</p>
				
					<p><span>Amount: </span>
						#numberformat(invoice.ccAmount, "$9999.99")#</p>
				
					<p><span>Status: </span>
						#paystatus(invoice.ccStatus)#</p>
				
					<p><span>Name: </span>
						#invoice.ccName#</p>
				
					<p><span>Email: </span> 
						#invoice.ccEmail#</p>
				
					<p><span>Agent: </span>
						#invoice.agent#</p>
				
					<p><span>Created: </span> 
						#dateformat(invoice.createdat, "medium")#</p>
				
					<p><span>Updated: </span> 
						#dateformat(invoice.updatedat, "medium")#</p>

#linkTo(text="#imageTag("edit-icon.png")#", action="edit", key=invoice.ID)#

</div>				

	<cfloop query="registration">
		<div class="eachRegistration">
					<p><span>Person: </span>
						#linkTo(text='#fname# #lname#', controller='peoples', action='show', key=peopleID)#</p>
				
					<p><span>Course/Options:</span>
						#linkTo(text='#COURSESTITLE#', controller='courses', action='show', key=coursesID)#
							#linkTo(text='#name#', controller='options', action='show', key=optionsID)#</p>
				
					<p><span>Invoice: </span>
						#linkTo(text='#ccorderid#', controller='invoices', action='show', key=invoicesID)#</p>
				
					<p><span>Quantity: </span>
						#quantity#</p>
				
					<p><span>Cost: </span>
						#cost#</p>
					#linkTo(text="#imageTag("edit-icon.png")#", controller="registrations", action="edit", key=ID)#
					

		</div>
	</cfloop>

</div>


</cfoutput>
