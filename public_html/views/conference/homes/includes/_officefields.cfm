<cfoutput>

  <div class="homes homes-office">
    <p class="homes-section">For Office:</p>

    <p>
      Approved
    </p>
    <div class="homes-multi">
      #radioButton(objectName='home', property='approved', tagValue="Yes", label='Yes')#
      #radioButton(objectName='home', property='approved', tagValue="No", label='No')#
    </div>
    #textField(objectName='home', property='homeId', label='Host Home ID', class="homes-input-short")#
    #textField(objectName='home', property='status', label='Status', class="homes-input-short")#
    #textField(objectName='home', property='AssignedToName', label='Guest assigned to: ', class="homes-input-half")#
    #textField(objectName='home', property='AssignedToEmail', label='Guest Email: ', class="homes-input-half")#
    #textArea(objectName='home', property='officecomments', label='Office Comments', class="homes-input-wide")#

    
  </div>

</cfoutput>