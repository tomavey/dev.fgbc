<cfoutput>

			#startFormTag(action=formAction)#
		
      #textFieldTag(name="payHalf", label='We would like to pay half now')#
					
			#submitTag()#
				
			#endFormTag()#
			

<cfdump var="#params#">
</cfoutput>
