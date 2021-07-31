<cfparam name="download" default=false>
<cfif isDefined("params.download")>
  <cfset download = true>
</cfif>

<cfset count = 0>
<div class="span11 container">

  <cfif !download>
    <h2>Thrive - Charis Pastor's Wives Network</h2>
    <cfoutput>
      <p>
        Sort by: 
        #linkTo(text="first name", controller="handbook.wives", action="index", params="sortBy=spouse")# 
        | 
        #linkTo(text="last name", controller="handbook.wives", action="index", params="sortBy=lname")# 
      </p>
      <p>
        <cfif !isDefined('params.onlyIfEmail')>
          Filter: #linkTo(text="Show only if email is present", controller="handbook.wives", action="index", params="onlyIfEmail=1")#
        <cfelse>
          Filter: #linkTo(text="Show all", controller="handbook.wives", action="index", params="")#
        </cfif>
      </p>
      <cfif gotRights("office,thrive")>
        <p class="pull-right">
          #linkToPlus(text="<i class='icon-download-alt'></i>", addParams="download=true", class="btn", title="Download this list as an excel spreadasheet")#
        </p>
      </cfif>
    </cfoutput>
  </cfif>

  <table class="table table-striped">
  <tr>
    <th>Name</th>
    <cfif download>
      <th>Last Name</th>      
    </cfif>
    <th>Email</th>
    <th>Cell Phone</th>
  </tr>
  <cfoutput query="pastorsWives">
    <!---Removes duplications when pastor has multiple positions--->
      <tr>
        <cfif !download>
          <td>#linkTo(text="#spouse# #lname#", route="HandbookWife", key=id)#</td>
          <td>#mailto(spouse_email)#</td>
        <cfelse>
          <td>#spouse#</td>  
          <td>#lname#</td>  
          <td>#spouse_email#</td>  
        </cfif>
        <td>#phone4#</td>
      </tr>
     <cfset count = count + 1> 
  </cfoutput>

</table>
<cfoutput>
  <p>
    Count: #count#
  </p>
</cfoutput>
</div>