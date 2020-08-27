<cfparam name="showThisDistrictOnly" default="all">
<cfif isDefined("params.district") and len(params.district)>
    <cfset showThisDistrictOnly = params.district>
</cfif>
<cfparam name="showThisAlphaOnly" default="all">
<cfif isDefined("params.alpha") and len(params.alpha)>
    <cfset showThisAlphaOnly = params.alpha>
</cfif>

<cfoutput>
	<p>
		<cfloop list="#getAlphabet()#" index="i">
			#linkto(text=i, action=params.action, params="alpha=#i#")#
		</cfloop>
		#linkto(text="ALL", action=params.action, params="alpha=all")#
	</p>
</cfoutput>

<p>
	<cfoutput query="districts">
		#linkto(text=district, action=params.action, params="district=#district#")#
	</cfoutput>
	<cfoutput>#linkto(text="ALL", action=params.action, params="district=all")#</cfoutput>
</p>


<table class="table table-striped">
<tr>
    <th>
        Name
    </th>
    <th>
        Church
    </th>
    <th>
        District
    </th>
    <th>
        Last Payment
    </th>
    <th>
        &nbsp;
    </th>
</tr>    
<cfoutput>
<cfloop from="1" to="#arrayLen(agbmmembers)#" index="i">
<cfset thisPerson = agbmmembers[i]>
<cfif (showThisDistrictOnly is "all" || thisperson.district is showThisDistrictOnly)
    &&
    (showThisAlphaOnly is "all" || left(thisperson.lname,1) is showThisAlphaOnly)
>
<tr>
<td>
    #linkto(text="#thisperson.fname#&nbsp;#thisperson.lname#", controller="handbook.people", action="show", key=thisperson.id)#
</td>
<td>
    <cfif isDefined("thisperson.church")>
        #linkto(text=thisperson.church, controller="handbook.organizations", action="show", key=thisperson.churchid)#
    </cfif>
</td>
<td>
    <cfif isDefined("thisperson.district")>
        #thisperson.district#
    </cfif>
</td>
<td class="paymentsPopup">
    <cfif arrayLen(thisperson.membershipfees)>
    <span>#dollarFormat(thisperson.membershipfees[1].membershipfee)# for #agbmmembers[i].membershipfees[1].membershipfeeyear#</br></span>
        <span>
        <cfloop from="1" to="#arrayLen(thisperson.membershipfees)#" index="ii">
            #dollarFormat(thisperson.membershipfees[ii].membershipfee)# for #thisperson.membershipfees[ii].membershipfeeyear#</br>
        </cfloop>
        </span>
    </cfif>
</td>
<td>
	#showTag(thisperson.id)#
    #addTag(controller='Handbook.AgbmInfo', action="add", id=thisperson.id)#
</td>
</tr>
</cfif>
</cfloop>
<tr>
<td colspan="4">
Count = #arrayLen(agbmmembers)#
</td>
</tr>
</cfoutput>
</table>
