<h1>Thank you for submitting this request for hospitality.  We will contact you soon!</h1>

<cfoutput>

					<p>
						#home.lname#, #home.fname# <cfif len(home.sname)>and #home.sname#</cfif></p>
				
					<p>
						#home.address#, #home.city# #home.state# #home.zip#</p>
				
					<br/>
					<p><span>Home Phone:</span> 
						#home.hphone#</p>

					<p><span>Cell Phone:</span>
						#home.cphone#</p>
				
					<p><span>Email:</span>
						#home.email#</p>

					<br/>				
					<p><span>Dates needed:</span>
						#home.dates#</p>
				
						<p><span>Age Range:</span>
						#home.agerange#</p>

					<br/>				
					<p><span>Children's Names:</span>
						#home.children#</p>
				
					<p><span>Children's Ages:'</span>
						#home.ages#</p>
				
					<p><span>Children's Gender:</span>
						#home.gender#</p>
				
					<p><span>Cribs? </span>
						#home.cribs#</p>
				
					<br/>				
					<p><span>Allergies:</span>
						#home.allergies#</p>
				
					<p><span>Special Needs:</span><br/>
						#home.special#</p>
				
					<br/>				
					<p><span>Missionary?</span>
						#home.missionary#</p>
				
					<p><span>International? </span>
						#home.national#</p>
				
					<p><span>Local Church: </span>
						#home.delegate#</p>
				
					<p><span>Pastor? </span>
						#home.pastor#</p>
				
					<br/>				
					<p><span>Submitted: </span>
						#dateformat(home.createdAt,"medium")#</p>
				

</cfoutput>
