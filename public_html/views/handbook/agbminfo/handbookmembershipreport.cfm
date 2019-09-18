<div is="agmhandbookreport">
<cfset countall = 0>
<cfset alert = 1>

<cfoutput>

<cfif !isDefined("params.plain")>
  #linkTo(text="Show without formating", action="handbookmembershipreport", params="plain", class="btn")#
</cfif>

<h2 class="text-center"> INSPIRE - Charis Pastors Network<br/> membership as of September 30, #currentMembershipYear#</h2>
</cfoutput>

<p class="text-center">MINISTERS MUST BE MEMBERS OF CHARIS FELLOWSHIP CHURCHES WHICH APPROVE THEIR SERVICE AS ELDERS. <br/> THE MEMBERSHIP FEE IS $100, DUE EVERY YEAR IN APRIL AND MAY.<p>

<p>INSPIRE PLACES ITS MEMBERS IN ONE OF THE FOLLOWING CATEGORIES
<ol>
	<li>??Ministers who have been examined and certified by a recognized examining board in the Charis Fellowship, their ordained or licensed status having been confirmed either by an examining board or by a properly signed document from their church.??</li>
	<li>??Men who are preparing for licensed and ordained ministry and are being mentored by a member of Inspire.??</li>
	<li>??Elders who have been qualified by a local church to serve in a particular ministry role, their status having been confirmed either by an examining board or by a properly signed document from their church.??</li>
</ol>
</p>
<cfoutput>
<p><small>(Based on membership payment records recorded for #currentMembershipYear#)</small></p>
</cfoutput>

<cfif cat0Ordained.recordcount>
  <div class="well">
    <h2>Ordained Ministers</h2>
    <cfset count = 0>
    <cfoutput query="cat0Ordained" group="id">
		<cfoutput>
		</cfoutput>
	    #includePartial("handbookMembershipListing")#
    	<cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat1Ordained.recordcount>
  <div class="well">
    <h2>Category One - Ordained Ministers</h2>
    <cfset count = 0>
    <cfoutput query="cat1Ordained" group="id">
		<cfoutput>
		</cfoutput>
	    #includePartial("handbookMembershipListing")#
    	<cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat1Licensed.recordcount>
  <div class="well">
    <h2>Category One - Licensed Ministers</h2>
    <cfset count = 0>
    <cfoutput query="cat1Licensed" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat0Commissioned.recordcount>
  <div class="well">
    <h2>Commissioned Ministers</h2>
    <cfset count = 0>
    <cfoutput query="cat0Commissioned" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat2Ordained.recordcount>
  <div class="well">
    <h2>Category Two - Ordained Students</h2>
    <cfset count = 0>
    <cfoutput query="cat2Ordained" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat2Licensed.recordcount>
  <div class="well">
    <h2>Category Two - Licensed Students</h2>
    <cfset count = 0>
    <cfoutput query="cat2Licensed" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat1Mentored.recordcount>
  <div class="well">
    <h2>Category One - Being Mentored</h2>
    <cfset count = 0>
    <cfoutput query="cat1Mentored" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat2Mentored.recordcount>
  <div class="well">
    <h2>Category One - Being Mentored</h2>
    <cfset count = 0>
    <cfoutput query="cat2Mentored" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfif cat3.recordcount>
  <div class="well">
    <h2>Category Three</h2>
    <cfset count = 0>
    <cfoutput query="cat3" group="id">
      #includePartial("handbookMembershipListing")#
      <cfset count = count + 1>
    </cfoutput>
	<cfoutput>
    &nbsp;&nbsp;&nbsp;Count: #count#
	</cfoutput>
    <cfset countall = count + countall>
  </div>
</cfif>

<cfoutput>
<p>
   Count all = #countall#
</p>
</cfoutput>
</div>
