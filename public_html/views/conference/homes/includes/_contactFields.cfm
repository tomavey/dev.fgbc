<cfoutput>

  <div class="homes homes-contactinfo">
    <p class="homes-section">Contact Info</p>
    <p>
      Name*:<br/> <input type="text" name="home.name" class="homes-input-wide">
    </p>    
    <p>
      Phone*:<br/> <input type="text" name="home.phone" class="homes-input-wide">
    </p>
    <p>
      Email*:<br/> <input type="text" name="home.email" class="homes-input-wide">
      <p class="required" v-html="validEmailMessage"></p>
    </p>
    <p class="required">* = required</p>
  </div>

</cfoutput>
                    
