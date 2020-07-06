<cfparam name="srpastors" type="query">
<cfset count = 1>
<h3>Seniors Pastors (sortorder = 1) that are not members of the AGBM</h3>
<ul>
<cfoutput query="srpastors">
  <cfif NOT isAgbmmember(id,params)>
    <cfset lastpaymentinfo = getLastPayment(personid=id,formatted="false")>
    
	<cfif lastpaymentinfo contains "na">
    	<cfset showpaylink = false>
	<cfelse>	  
		<cfset showpaylink = true>
    </cfif>
    
    <li>#linkto(controller="handbook-people", action="show", key=id, text=fullname)#: #city#, #state_mail_abbrev# 
    <cfif showpaylink>
    	  #linkto(
    	  		  text="(<span style='font-size:.7em'>Last memfee: #lastpaymentinfo#</span>)", 
    			  controller="handbook-agbm",
    			  action="show", 
    			  key=id, 
    			  class="tooltipside", 
    			  title="View payment information")#</li>
    </cfif>			  
    <cfset count = count +1>
  </cfif>
</cfoutput>
</ul>
<cfoutput>
Count: #count#
</cfoutput>