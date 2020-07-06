<cfoutput>
  <div class="homes homes-location">
    <p class="homes-section">Location</p>

    #textField(objectName='home', property='address', label='Address (street, city, zip) ', class="homes-input-wide")#

    #textField(objectName='home', property='distance', label='Distance from Grace College Campus', class="homes-input-half")#
                        
    #textField(objectName='home', property='cost', label='Cost per night? (Note: We hope to offer host homes for little to no cost)', class="homes-input-short")#
  
  </div>
</cfoutput>
                      
