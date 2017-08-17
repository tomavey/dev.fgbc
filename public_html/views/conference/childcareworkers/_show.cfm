<cfoutput>
					<p><span>Name: </span>
						#childcareworkers.fname# #childcareworkers.lname#</p>
				
					<p><span>Address: </span>
						#childcareworkers.address# <br/>
						#childcareworkers.city# #childcareworkers.stateid#, #childcareworkers.zip#
						</p>
				
					<p><span>Phone: </span>
						#childcareworkers.phone#</p>
				
					<p><span>Email: </span>
						#mailto(childcareworkers.email)#</p>
				
					<p><span>Parents Name: </span>
						#childcareworkers.parentsname#</p>
				
					<p><span>Parents phone: </span>
						#childcareworkers.parentsphone#</p>
				
					<p><span>Parents email: </span>
						#mailto(childcareworkers.parentsemail)#</p>
				
					<p><span>Church: </span>
						#childcareworkers.church#</p>
				
					<p><span>Age: </span>
						#childcareworkers.age#</p>
				
					<p><span>Experience: </span> <br />
						#childcareworkers.experience#</p>
				
					<p><span>Available: </span>
						#childcareworkers.available#</p>
				
					<p><span>Comments: </span> <br />
						#childcareworkers.comments#</p>
				
					<p><span>Created: </span>
						#dateformat(childcareworkers.createdAt)#</p>

</cfoutput>