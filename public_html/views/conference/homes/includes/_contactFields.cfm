<cfoutput>

  <div class="homes homes-contactinfo">
    <p class="homes-section">Contact Info</p>
    <p>
      Name*:<br/> <input type="text" name="home.name" class="homes-input-wide" v-model="name">
    </p>    
    <p>
      Phone*:<br/> <input type="text" name="home.phone" class="homes-input-wide" v-model="phone">
    </p>
    <p>
      Email*:<br/> <input type="text" name="home.email" class="homes-input-wide" v-model="email">
      <p class="required" v-html="validEmailMessage"></p>
    </p>
    <p class="required">* = required</p>
  </div>

</cfoutput>
                    
