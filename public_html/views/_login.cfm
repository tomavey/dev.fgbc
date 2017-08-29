<cfoutput>


	<!---Test of hooks--->
<div id="loginModal" class="modal hide fade" role="dialog" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h3 id="myModalLabel">Login</h3>
			<p>Two options...</p>
	</div>

	<cfif facebookloginisopen()>
		<div class="modal-left">
				#startFormTag(controller="auth.users",action="facebookOAuth")#
			<div class="modal-body">
				<h4 id="myModalLabel">Login with Facebook</h4>
				<p>You can login using your facebook account.</p>
				<p>With your permission, Facebook will share your email address with this app so we can give you access to the correct information.  Nothing will be posted to your facebook timeline.</p>
				<p>&nbsp;</p>
			</div>
			<div class="modal-footer">
				<button type="submit" name="submit" value="Login" class="btn btn-primary">Login With Facebook</button>
			</div>
				#endFormTag()#
		</div>
	<cfelse>
		<div class="modal-left">
			<div class="modal-body">
				<h4 id="myModalLabel">Facebook - Oops</h4>
				<cfif flashKeyExists("facebookfail")>
					<p>#flash("facebookfail")#</p>
				</cfif>
				<p>Facebook has changed their login process and we are working to upgrade.  This option for login is temporarily unavailable.</p>

				<p>&nbsp;</p>
			</div>
			<div class="modal-footer">
				#linkTo(text="Create a new FGBC account", controller="auth/users", action="new")#
			</div>
		</div>
	</cfif>

	<div class="modal-right">
		#startFormTag(controller="auth/users", action="testcheck")#
		<div class="modal-body">
			<h4 id="myModalLabel">Login with your FGBC account</h4>
				<div class="row-fluid">
					<div class="span12">
						#textField(objectName='user', property='username', label='Username:', class="input-block-level")#

					</div>
				</div>
				<div class="row-fluid">
					<div class="span12">
						#passwordField(objectName='user', property='password', label='Password:', class="input-block-level")#
					</div>
				</div>
		</div>
		<div class="modal-footer">
			<button type="submit" name="submit" value="Login" class="btn btn-primary">Login</button>
			<p>#linkTo(text="Create a new FGBC account", controller="auth/users", action="new")#</p>
		</div>
			#endFormTag()#
	</div>
</div>
</cfoutput>