<cfparam name="emailAll" default="">
<cfparam name="showInstructions" default=false>
<cfif showInstructions>
  <cfoutput>
    Add "?regids=" to the url plus a comma delimited string of regids for the retreats you want a report on.<br/>
    for example: ?regids=central18,central19,central17
    <p>
      more examples: 
      #linkto(text="Central", href="/focus/recentregs/?regids=central19,central18,central17")#
      #linkto(text="East", href="/focus/recentregs/?regids=east19,East18,east17")#
      #linkto(text="SouthWest", href="/focus/recentregs/?regids=southwest19,southwest18,southwest17")#
      #linkto(text="South", href="/focus/recentregs/?regids=South19,South18,South17")#
      #linkto(text="Northwest", href="/focus/recentregs/?regids=northwest19,northwest18,northwest17")#
    </p>
  </cfoutput>
<cfelse>  
  <cfoutput>
    <h2>
      #recentFocusRegs.recordCount# focus retreat registrants for #params.regids#
    </h2>
  </cfoutput>
  <table>
    <cfoutput query="recentFocusRegs">
      <tr>
        <td>
          #fname#
        </td>
        <td>
          #lname#
        </td>
        <td>
          #mailto(email)#
        </td>
      </tr>
  <cfset emailall = emailall & '; ' & email> 
    </cfoutput>
  </table>
  </br>
  <cfoutput>
    <p>
      #replace(emailAll,'; ','','one')#
    </p>
  </cfoutput></cfif>
