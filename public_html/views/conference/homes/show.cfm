<div class="container">

<h1>Showing home</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<!--- <cfdump var="#home.properties()#"><cfabort> --->

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#home.id#</p>
				
					<p><span>Name</span> <br />
						#home.name#</p>
				
					<p><span>Phone</span> <br />
						#home.phone#</p>
				
					<p><span>Email</span> <br />
						#home.email#</p>
				
					<p><span>Available</span> <br />
						#home.available#</p>
				
					<p><span>How Many?</span> <br />
						#home.howmany#</p>
				
					<p><span>For Families</span> <br />
						#home.forFamilies#</p>
				
					<p><span>For Couples</span> <br />
						#home.forCouples#</p>
				
					<p><span>For Singles</span> <br />
						#home.forSingles#</p>
				
					<p><span>Bedrooms</span> <br />
						#home.bedrooms#</p>
				
					<p><span>Beds</span> <br />
						#home.beds#</p>
				
					<p><span>Bathrooms</span> <br />
						#home.bathrooms#</p>
				
					<p><span>Arrangements</span> <br />
						#home.arrangements#</p>
				
					<p><span>Describe</span> <br />
						#home.description#</p>
				
					<p><span>Other</span> <br />
						#home.other#</p>
				
					<p><span>Airconditioning</span> <br />
						#home.airconditioning#</p>
				
					<p><span>Towels</span> <br />
						#home.towels#</p>
				
					<p><span>Linens</span> <br />
						#home.linens#</p>
				
					<p><span>Tv</span> <br />
						#home.tv#</p>
				
					<p><span>Wifi</span> <br />
						#home.wifi#</p>
				
					<p><span>Kitchen</span> <br />
						#home.kitchen#</p>
				
					<p><span>Breakfast</span> <br />
						#home.breakfast#</p>
				
					<p><span>Refrigerator</span> <br />
						#home.refrigerator#</p>
				
					<p><span>Washerdryer</span> <br />
						#home.washerdryer#</p>
				
					<p><span>Address</span> <br />
						#home.address#</p>
				
					<p><span>Distance</span> <br />
						#home.distance#</p>
				
					<p><span>Cost</span> <br />
						#home.cost#</p>
				
					<p><span>Approved</span> <br />
						#home.approved#</p>
				
					<p><span>Created At</span> <br />
						#home.createdAt#</p>
				
					<p><span>Deleted At</span> <br />
						#home.deletedAt#</p>
				
					<p><span>Updated At</span> <br />
						#home.updatedAt#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this home", action="edit", key=home.id)#
</cfoutput>

</div>
