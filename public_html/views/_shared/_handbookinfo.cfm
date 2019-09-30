<cfset addreturn = 0>
<cfoutput>
<div style='mso-pagination:widow-orphan lines-together'>
       	  <strong>#trim(lname)#, #trim(fname)#<cfif len(spouse)><span style="font-style:italic;">&nbsp;#trim(spouse)#</span></cfif></strong>

		  <cfif params.action NEQ "bluepages" and params.action NEQ "handbookinfo" or isDefined("params.showedit")>
                                <cftry>
		  	#linkto(text='<i class="icon-search"></i>', controller="handbook.People", action="show", key=id, class="tooltipside", title="Show #fname# #lname#", onclick="window.open(this.href); return false;")#
                                    <cfcatch>---</cfcatch></cftry>
			<cfif !isAgbm(id) and gotRights("office")>						
				#linkto(text='<i class="icon-trash"></i>', controller="handbook.People", action="delete", method="delete", key=id, class="tooltipside ajaxdelete", title="Delete #fname# #lname#", onclick="confirm('Are you sure?')", class="noAjax")#
			</cfif>  
		  </cfif>

	<br/>

      <cfif len(trim(address1))>
      #fixAddress(address1)#<br/>
	  </cfif>

      <cfif len(trim(address2))>
	    #fixAddress(address2)#<br/>
      </cfif>

	  <cfif len(city)>
        #trim(city)#,
		<cfset addreturn = 1>
	  </cfif>

	  <cfif len(state_mail_abbrev) or len(zip)>
		<cfif state_mail_abbrev neq "Non" and len(city)>
			  #state_mail_abbrev#
  			  <cfset addreturn = 1>
		</cfif>
		<cfif len(zip)>
			   #trim(zip)#
				<cfset addreturn = 1>
				#isAgbm(id)#
		</cfif>
		<cfif addreturn>
			  <br/>
		</cfif>
	  </cfif>
	  <cfif len(country) and country DOES NOT CONTAIN "USA" and country NEQ "USA,USA" and country NEQ "U.S." and country NEQ "US" and country NEQ "United States">
	  	#trim(country)#<br/>
	  </cfif>
      <cfif len(phone) AND phone NEQ phone3>
        H:#fixphone(phone)#<br/>
	  </cfif>
      <cfif len(phone2) AND phone2 NEQ phone>
      	M:#fixphone(phone2)#<br/>
      </cfif>
      <cfif len(phone3)>
      	W:#fixphone(phone3)#<br/>
      </cfif>
	  <cfset lenEmail = len(email)>
      <cfif lenEmail>
	  	<cfif lenEmail GT 25>
	      	<span style="font-size:.9em">#trim(email)#</span>
		<cfelse>  
	      	#trim(email)#
		</cfif>  
         <cfset message = urlEncodedFormat("#fname# - We are updating information in the online FGBC handbook which is used each year for the printed handbook. Can you review this for me?  Today?  Be sure to click the 'This information is correct' button when you are finished. Thanks so much! #urlFor(controller="handbook.welcome", action="welcome", params='id=#encrypt(email,application.wheels.passwordkey,'CFMX_COMPAT','HEX')#', onlyPath=false)#")>
         <cfset subject = urlEncodedFormat("Please review your personal FGBC Handbook listing")>
		<cfif isDefined("params.showupdatedat")>
		 	#mailTo(
				name='<i class="icon-envelope"></i>',
				emailaddress='#email#?subject=#subject#&body=#message#',
				alt="e"
								)#
		</cfif>
		<cfif isDefined("params.showupdate")>
		 	#mailTo(
				name='[email link]',
				emailaddress='#email#?subject=#subject#&body=#message#',
				alt="e"
								)#
		</cfif>
		<br/>
	  </cfif>
	  <cfset lenEmail2 = len(email2)>
      <cfif lenEmail2 and email NEQ email2>
	  	<cfif lenEmail2 GT 25>
	      	<span style="font-size:.9em">#trim(email2)#</span><br/>
		<cfelse>  
	      	#trim(email2)#<br/>
		</cfif>  
      </cfif>
      <cfif len(skype)>
      	Skype:#trim(skype)#<br/>
      </cfif>
      #displayPositions(id)#<!---From views/helpers.cfm--->
</div>
</cfoutput>
