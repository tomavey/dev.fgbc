<cfoutput>
<div class="putRight" id="top-links">
	<ul class="nav nav-pills">
		<cfif isDefined("session.auth.login") and session.auth.login>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="##">#left(session.auth.email,"20")#<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li>#linkTo(text="Change Password", controller="auth.users", action="get-email-for-change-password-link")#</li>
					<li>#linkTo(text="Contact Us", controller="messages", action="new")#</li>
					<li>#linkTo(text="My Account", controller="auth.users", action="edit", key=session.auth.userid)#</li>
				</ul>
			</li>
			<li>#linkTo(text="Logout", route="authLogoutUser")#</li>
			<li id="status"></li>
		<cfelse>
			<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="##">Account<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li>#linkTo(text="Create an Account.", route="AuthNewUser")#</li>
					<li>#linkTo(text="Forgot Password.", route="ForgotPassword")#</li>
				</ul>
			</li>
			<li>#linkTo(text="Contact Us", controller="messages", action="new")#</li>
			<li><a href="##loginModal" role="button" data-toggle="modal">Login</a>
			</li>
		</cfif>
	</ul>
</div>
</cfoutput>