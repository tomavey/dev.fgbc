					<cfif len(birthdayyear)>
    					<cfset age = year(now()) - val(birthdayyear)>
					<cfelse>
						<cfset age = 0>
					</cfif>	   
    					<cfif age is 0>				
    						 <cfset noage = noage + 1>
    					</cfif>	 		 
            			<cfif age GTE 60>
            				 <cfset age60 = age60+1>
    					</cfif>	 
            			<cfif age GTE 50 AND age LT 60>
            				 <cfset age50 = age50+1>
    					</cfif>	 
            			<cfif age GTE 40 AND age LT 50>
            				 <cfset age40 = age40+1>
    					</cfif>	 
            			<cfif age GTE 30 AND age LT 40>
            				 <cfset age30 = age30+1>
    					</cfif>	 
            			<cfif age GTE 20 AND age LT 30>
            				 <cfset age20 = age20+1>
    					</cfif>	 
