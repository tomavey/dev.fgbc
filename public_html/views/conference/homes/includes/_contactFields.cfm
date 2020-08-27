<cfoutput>

  <div class="homes homes-contactinfo">
    <p class="homes-section">Contact Info</p>

    #textField(objectName='home', property='name', label='Name*', class="homes-input-wide", v_model="name")#
            
    #textField(objectName='home', property='phone', label='Phone*', class="homes-input-half", v_model="phone")#
    
    #textField(objectName='home', property='email', label='Email*', class="homes-input-half", v_model="email")#
    </p>
    <p class="required" v-html="validEmailMessage"></p>
    <p class="required">* = required</p>
  </div>

</cfoutput>
                    
