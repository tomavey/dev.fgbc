<cfparam name="useForCreditFields" default=0>
<!--- 
<cfdump var="#people#"><cfabort>
 --->

<div class="eachItemShown">
<cfoutput>

			#errorMessagesFor("people")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

				
<!--- 
						#select(objectName='people', property="familyid", options=families, textField="lname", label="Family Name: ")#
 --->
						#selectTag(name='equip_familiesid', options=families, textField="lnameId", label="Family Name: ", selected=people.family.id)#
						
						#textField(objectName='people', property='fname', label='First Name: ')#
					
						#textField(objectName='people', property='email', label='Email: ')#
					
						#textField(objectName='people', property='phone', label='Phone: ')#
					
						#select(objectName='people', property='gender', options="Male,Female", textfield="description")#

						#select(objectName='people', property='age', options=ageRanges, textfield="description", includeBlank="Select an Age Range")#

						#select(objectName='people', property='type', options=application.wheels.typeofpeople, textfield="type", includeBlank="Select a Type")#
					
						#textField(objectName='people', property='churchname', label='Church: ')#
					
					<cfif useForCreditFields>
					
						#textField(objectName='people', property='title', label='Title')#
					
						#textField(objectName='people', property='socsec', label='Socsec')#
					
						#textField(objectName='people', property='birthdate', label='Birthdate')#
					
						#textField(objectName='people', property='maritalstatus', label='Maritalstatus')#
					
						#textField(objectName='people', property='ethnic', label='Ethnic')#
					
						#textField(objectName='people', property='gender', label='Gender')#
					
						#textField(objectName='people', property='churchaddress', label='Churchaddress')#
					
						#textField(objectName='people', property='churchcity', label='Churchcity')#
					
						#textField(objectName='people', property='churchstate', label='Churchstate')#
					
						#textField(objectName='people', property='churchzip', label='Churchzip')#
					
						#textField(objectName='people', property='specialcode', label='Specialcode')#
					
						#textField(objectName='people', property='hsname', label='Hsname')#
					
						#textField(objectName='people', property='hsaddress', label='Hsaddress')#
					
						#textField(objectName='people', property='college1name', label='College1name')#
					
						#textField(objectName='people', property='college1state', label='College1state')#
					
						#textField(objectName='people', property='college1dates', label='College1dates')#
					
						#textField(objectName='people', property='college1hours', label='College1hours')#
					
						#textField(objectName='people', property='college1degree', label='College1degree')#
					
						#textField(objectName='people', property='college2name', label='College2name')#
					
						#textField(objectName='people', property='college2state', label='College2state')#
					
						#textField(objectName='people', property='college2dates', label='College2dates')#
					
						#textField(objectName='people', property='college2hours', label='College2hours')#
					
						#textField(objectName='people', property='college2degree', label='College2degree')#
					
						#textField(objectName='people', property='college3name', label='College3name')#
					
						#textField(objectName='people', property='college3state', label='College3state')#
					
						#textField(objectName='people', property='college3dates', label='College3dates')#
					
						#textField(objectName='people', property='college3hours', label='College3hours')#
					
						#textField(objectName='people', property='college3degree', label='College3degree')#
					
						#textField(objectName='people', property='college4name', label='College4name')#
					
						#textField(objectName='people', property='college4state', label='College4state')#
					
						#textField(objectName='people', property='college4dates', label='College4dates')#
					
						#textField(objectName='people', property='college4hours', label='College4hours')#
					
						#textField(objectName='people', property='college4degree', label='College4degree')#
					
						#textField(objectName='people', property='churchcode', label='Churchcode')#
					</cfif>						

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>