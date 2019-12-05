<cfoutput>

<style>
  .homes {
    border: 1px solid grey;
    padding:20px;
    margin: 20px;
    border-radius:10px;
    font-size:20px
  }
  .homes-section {
    border: 1px solid black;
    width: 300px;
    padding: 5px;
    margin-top: -30px;
    background-color: white;
    font-size: 110%;
    font-weight: bold;
    border-radius: 5px
  }
  .homes-question {
    margin-bottom:40px
  }
  .homes-multi {
    margin-left: 30px
  }
  .homes label {
    font-size:105%
  }
  .homes-multi label input {
    margin-left:10px
  }
  .homes-input-wide {
    width: 90%
  }
  .homes-input-half {
    width: 50%
  }
  .homes-input-short {
    width: 100px
  }
</style>

<div class="homes-form">

  <div class="homes homes-contactinfo">
    <p class="homes-section">Contact Info</p>
    #textField(objectName='home', property='name', label='Name', class="homes-input-wide")#
            
    #textField(objectName='home', property='phone', label='Phone', class="homes-input-half")#
    
    #textField(objectName='home', property='email', label='Email', class="homes-input-half")#
  </div>
                      
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

  <div class="homes homes-location">
    <p class="homes-section">Location</p>

    #textField(objectName='home', property='address', label='Address (street, city, zip) ', class="homes-input-wide")#

    #textField(objectName='home', property='distance', label='Distance from Grace College Campus', class="homes-input-half")#
                        
    #textField(objectName='home', property='cost', label='Cost per night? (Note: We hope to offer host homes for little to no cost)', class="homes-input-short")#
  
  </div>
                      
<cfif gotRights("office")>

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

</cfif>

</div>

</cfoutput>

                    
