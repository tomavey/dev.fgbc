<cfoutput>
  <div class="homes homes-availabilityinfo">
    <p class="homes-section">Availability</p>
    <div class="homes-question">
      <p>
        Is your home available July 21-23, 2020?
      </p>
      <div class="homes-multi">
        #radioButton(objectName='home', property='available', tagValue="Yes", label='Yes')#
        #radioButton(objectName='home', property='available', tagValue="No", label='No')#
      </div>
    </div>
    
    <div class="homes-question">
      #textField(objectName='home', property='howmany', label='How many guests can you host?')#
    </div>
                        
    
    <p>My home is best for (select all that apply)</p>
    <div class="homes-multi">
      #checkBox(objectName='home', property='forFamilies', label="Families", checkedValue="Yes")#
      #checkBox(objectName='home', property='forCouples', label="Couples", checkedValue="Yes")#
      #checkBox(objectName='home', property='forSingles', label="Singles", checkedValue="Yes")#
    </div>
                        
  </div>
</cfoutput>

