<cfset count = 0>
<div class="span11 container">
<h2>Thrive - Charis Pastor's Wives Network</h2>
<table class="stripped">
  <cfoutput query="pastorsWives">
    <!---Removes duplications when pastor has multiple positions--->
      <tr>
        <td>#linkTo(text="#spouse# #lname#", route="HandbookWife", key=id)#</td>
        <td>#mailto(spouse_email)#</td>
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