<cfparam name="tempUser" default='#session.auth.tempUser#'>
<cfparam name="formAction" required=true type="string">

<div class="container card card-charis text-center">
  <h1>Enter the code that was sent to your email address: </h1>
  <p>Be sure to check spam or junk folders.</p>
    <cfoutput>

      <cfif flashKeyExists("error")>
        <p class="errorMessage">
            #flash("error")#
        </p>
      </cfif>

      #startFormTag(action=formAction)#
      
      <cfif isLocalMachine()>
        <p>
          #session.auth.tempUser.checkCode#
        </p>
      </cfif>

      #hiddenFieldTag(name="email", value=tempUser.email)#
      #hiddenFieldTag(name="fname", value=tempUser.fname)#
      #hiddenFieldTag(name="lname", value=tempUser.lname)#
      #hiddenFieldTag(name="username", value=tempUser.username)#
      #hiddenFieldTag(name="password", value=tempUser.password)#

      #textFieldTag(name='Code', placeholder="Enter the code that was sent to your email HERE", class="form-control", style="width:50%;margin:0 auto")#
  
      #submitTag("Enter the code")#
        
      #endFormTag()#<br/>
          
  
    </cfoutput>
  
  </div>
  