<cfoutput>
<div class="putRight" id="top-links">
	<ul class="nav nav-pills">
		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="##">Account<b class="caret"></b></a>
			<ul class="dropdown-menu">
				<li>#linkTo(text="Create an Account", controller="auth-users", action="new")#</li>
				<li>#linkTo(text="FGBC Email", href="http://fgbc.commercestreet.com/Login.aspx")#</li>
				<li>#linkTo(text="Forgot Password", controller="auth-users", action="get-email-for-change-password-link")#</li>
			</ul>
		</li>
		<li>#linkTo(text="Contact Us", controller="newlayout", action="contact")#</li>
		<li><a href="##loginModal" role="button" data-toggle="modal">Login</a></li>
	</ul>
</div>
</cfoutput>