<cfoutput>
#linkto(text="Help?", action="help", class="help")#
<div class="#params.action#" id="showinfo">

  <h1>Welcome to the FGBC Online Handbook.</h1>

  <cfif isMobile()>
  	<p>Enter your email below and we will send you a link to unlock the online handbook on this device.</p>
  <cfelse>

    <p>
    	This online version of the printed handbook is for the convenience of folks and ministries who are listed in the handbook.
    </p>

    <p>
    	Please submit your email address using the link below. <br/>
    	If that email address is listed in the handbook, we will send you a personal link to unlock this online version of the handbook on this computer.
    </p>

    <p>Need more help? #linkto(text="Send us your questions.", controller="messages", action="new")#</p>

    <cfif !flashIsEmpty()>
    <p class="alert">
      #flash("error")#
    </p>
    </cfif>

  </cfif>

  <p>
  	#startFormTag(action="sendLink")#
    <cfif isDefined("params.email")>
      #textFieldTag(name="email", label="Email Address: ", value=params.email)#
    <cfelse>
      #textFieldTag(name="email", label="Email Address: ")#
    </cfif>
  	#submitTag("Submit")#
  	#endFormTag()#
  	<cfif flashKeyExists("failure")>
  		<p class="errorMessage">
  			#flash("failure")#
  			<p>#linkto(text="Or use this form to ask the handbook secretary help.", controller="messages", action="new", class="btn")#</p>
  		</p>
  	</cfif>
  </p>

</div>
</cfoutput>