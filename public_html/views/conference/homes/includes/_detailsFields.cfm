<cfoutput>
  <div class="homes homes-detailsinfo">
    <p class="homes-section">Details</p>
    
    #textField(objectName='home', property='bedrooms', label='How many bedrooms are available?')#
                      
    #textArea(objectName='home', property='beds', label='How many beds are available? (please list sizes: king, queen, double, bunk, etc.)', class="homes-input-wide")#
    
    #textField(objectName='home', property='bathrooms', label='How many bathrooms are available? ', class="homes-input-wide")#
    
    #textArea(objectName='home', property='arrangements', label='What are the sleeping arrangements? ( i.e., bedroom 1 = 1 queen, living room = 1 sofa bed, etc.) ', class="homes-input-wide")#
                        
    #textArea(objectName='home', property='description', label='Please describe the space available for your guests (i.e., bedroom in your home, detached apartment, RV, etc.) ', class="homes-input-wide")#
    
    #textArea(objectName='home', property='other', label='Other details to note (i.e., pets, steep stairs, points of interest)', class="homes-input-wide")#
    
    <p>
      Amenities available: (select all that apply)
    </p>
    <div class="homes-multi">
      #checkBox(objectName='home', property='airconditioning', label="Air Conditioner", checkedValue="Yes")#
      #checkBox(objectName='home', property='towels', checkedValue="Yes")#
      #checkBox(objectName='home', property='linens', checkedValue="Yes")#
      #checkBox(objectName='home', property='wifi', checkedValue="Yes")#
      #checkBox(objectName='home', property='kitchen', checkedValue="Yes")#
      #checkBox(objectName='home', property='breakfast', checkedValue="Yes")#
      #checkBox(objectName='home', property='refrigerator', checkedValue="Yes")#
      #checkBox(objectName='home', property='washerdryer', label="Washer/Dryer", checkedValue="Yes")#
    </div>

  </div>

</cfoutput>