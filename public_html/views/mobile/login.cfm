<!------------LOGIN---------------
---------------------------------------------------->
<cfoutput>
<div data-role="page" id="login">

	<div role="banner" class="ui-corner-top ui-header ui-bar-d" data-role="header" data-theme="d">
		<a title="Close" data-theme="d" data-wrapperels="span" data-iconshadow="true" data-shadow="true" data-corners="true" class="ui-btn-left ui-btn ui-btn-up-d ui-shadow ui-btn-corner-all ui-btn-icon-notext" href="##" data-icon="delete" data-iconpos="notext" data-rel="back"><span class="ui-btn-inner ui-btn-corner-all"><span class="ui-btn-text">Close</span><span class="ui-icon ui-icon-delete ui-icon-shadow">&nbsp;</span></span></a>
		<h1 aria-level="1" role="heading" class="ui-title">Login.</h1>
		#linkTo(text="Login with Facebook", controller="auth.users", action="facebookOAuth")#

	</div>

	<div data-role="content">
	#startFormTag(controller="auth.users", action="checklogin", data_ajax="false")#
	#textField(objectName='user', property='username', label='Username:', class="input-block-level")#
	#passwordField(objectName='user', property='password', label='Password:', class="input-block-level")#
	#submitTag("Login")#
	#endFormTag()#
	</div><!-- /content -->

</div><!-- /page -->
</cfoutput>