<div class="container">

<h1>Create a New home</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("home")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='home', property='name', label='Name')#
																
				
					
						#textField(objectName='home', property='phone', label='Phone')#
																
				
					
						#textField(objectName='home', property='email', label='Email')#
																
				
					
						#textField(objectName='home', property='available', label='Available')#
																
				
					
						#textField(objectName='home', property='howmany', label='Count')#
																
				
					
						#textField(objectName='home', property='forFamilies', label='For Families')#
																
				
					
						#textField(objectName='home', property='forCouples', label='For Couples')#
																
				
					
						#textField(objectName='home', property='forSingles', label='For Singles')#
																
				
					
						#textField(objectName='home', property='bedrooms', label='Bedrooms')#
																
				
					
						#textField(objectName='home', property='beds', label='Beds')#
																
				
					
						#textField(objectName='home', property='bathrooms', label='Bathrooms')#
																
				
					
						#textField(objectName='home', property='arrangements', label='Arrangements')#
																
				
					
						#textField(objectName='home', property='describe', label='Describe')#
																
				
					
						#textField(objectName='home', property='other', label='Other')#
																
				
					
						#textField(objectName='home', property='airconditioning', label='Airconditioning')#
																
				
					
						#textField(objectName='home', property='towells', label='Towells')#
																
				
					
						#textField(objectName='home', property='linens', label='Linens')#
																
				
					
						#textField(objectName='home', property='tv', label='Tv')#
																
				
					
						#textField(objectName='home', property='wifi', label='Wifi')#
																
				
					
						#textField(objectName='home', property='kitchen', label='Kitchen')#
																
				
					
						#textField(objectName='home', property='breakfast', label='Breakfast')#
																
				
					
						#textField(objectName='home', property='refrigerator', label='Refrigerator')#
																
				
					
						#textField(objectName='home', property='washerdryer', label='Washerdryer')#
																
				
					
						#textField(objectName='home', property='address', label='Address')#
																
				
					
						#textField(objectName='home', property='distance', label='Distance')#
																
				
					
						#textField(objectName='home', property='cost', label='Cost')#
																
				
					
						#textField(objectName='home', property='approved', label='Approved')#
																
				
																
				
																
				
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>

</div>
