	<div id="popup"></div>
	
	<div class="container" id="main">
	
    		<div class="row">
    	
    			<div id="pageheader" class="span12 visible-desktop">
    				<cfoutput>
    				<span id="welcome">
    					<cfif isdefined('session.auth.email')>
    						Welcome #session.auth.email#
    						&nbsp;&nbsp;
    						#linkTo(text="logout", controller="handbook.welcome", action="logout")#
    					<cfelse>
							#linkTo(text="Login", action="loginForm")#
    					</cfif>
    				</span>
    				</cfoutput>
    			</div>
			</div>	
