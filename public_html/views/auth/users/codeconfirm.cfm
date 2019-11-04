<cfparam name="tempUser" default='#session.auth.tempUser#'>
<cfparam name="formAction" required=true type="string">
<div class="container">
  <h1>Enter the code that was sent to your email address: </h1>
  
    <cfoutput>

      <cfif flashKeyExists("error")>
        <p class="errorMessage">
            #flash("error")#
        </p>
      </cfif>

      #startFormTag(action=formAction)#

      #session.auth.checkCode#

      #hiddenFieldTag(name="email", value=tempUser.email)#
      #hiddenFieldTag(name="fname", value=tempUser.fname)#
      #hiddenFieldTag(name="lname", value=tempUser.lname)#
      #hiddenFieldTag(name="username", value=tempUser.username)#
      #hiddenFieldTag(name="password", value=tempUser.password)#

      #textFieldTag(name='Code', label='Code: ', placeholder="Code that was sent")#
  
      #submitTag("Enter the code")#
        
      #endFormTag()#
          
  
    </cfoutput>
  
  </div>
  