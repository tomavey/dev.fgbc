<cfoutput>

<!------------WELCOME---------------
---------------------------------------------------->
<div data-role="page" id="welcome">

	<div data-role="header">
		#includePartial(partial="/mobile/header")#
	</div><!-- /header -->

	<div data-role="content">
		#includePartial(partial="/mobile/welcome")#
		<cfoutput query="menuoptions" group="category">
			<hr/>
			<cfoutput>
			#createLink(text=name, link=link, controller=controllerr, action=actionn, key=keyy, data_role="button", data_ajax=false)#
			</cfoutput>
		</cfoutput>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<cfset uiBtnActive = "welcome">
			#includePartial(partial="/mobile/navbar")#
		</div><!-- /navbar -->
	</div><!-- /footer -->

</div><!-- /page -->

<!------------CHURCHES---------------
---------------------------------------------------->
<div data-role="page" id="churches">

	<div data-role="header">
		#includePartial(partial="/mobile/header")#
	</div><!-- /header -->

	<div data-role="content">
		#startFormTag(action="churches", data_ajax="false")#
		#textFieldTag(name="search", placeholder="Search by church name, city, or state.")#
		#submitTag("Search")#
		#endFormTag()#
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<cfset uiBtnActive = "churches">
			#includePartial(partial="/mobile/navbar")#
		</div><!-- /navbar -->
	</div><!-- /footer -->

</div><!-- /page -->

<!------------MINISTRIES---------------
---------------------------------------------------->
<div data-role="page" id="ministries">

	<div data-role="header">
		#includePartial(partial="/mobile/header")#
	</div><!-- /header -->

	<div data-role="content">
		<cfoutput query="ministry" group="category">
		<cfif not category is "none">
			<div class="postbox categories"><h1>#category#</h1></div>

			<cfoutput>
				<div class="well ministries">
							<h2>#linktoUrl(text=ministry.name, href=webaddress)#</h2>

							<p>#ministry.summary#</p>
						
				</div>
			</cfoutput>
		</cfif>
		</cfoutput>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<cfset uiBtnActive = "ministries">
			#includePartial(partial="/mobile/navbar")#
		</div><!-- /navbar -->
	</div><!-- /footer -->

</div><!-- /page -->


<!------------MORE---------------
---------------------------------------------------->
<div data-role="page" id="more">

	<div data-role="header">
		#includePartial(partial="/mobile/header")#
	</div><!-- /header -->

	<div data-role="content">
		<p>More</p>
		<cfoutput query="menuoptions">
			#createLink(text=name, link=link, controller=controllerr, action=actionn, key=keyy)#<br/>
		</cfoutput>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<cfset uiBtnActive = "more">
			#includePartial(partial="/mobile/navbar")#
		</div><!-- /navbar -->
	</div><!-- /footer -->

</div><!-- /page -->


<!------------LOGIN---------------
---------------------------------------------------->
<cfoutput>
<div data-role="page" id="login">

	<div role="banner" class="ui-corner-top ui-header ui-bar-d" data-role="header" data-theme="d">
		<a title="Close" data-theme="d" data-wrapperels="span" data-iconshadow="true" data-shadow="true" data-corners="true" class="ui-btn-left ui-btn ui-btn-up-d ui-shadow ui-btn-corner-all ui-btn-icon-notext" href="##" data-icon="delete" data-iconpos="notext" data-rel="back"><span class="ui-btn-inner ui-btn-corner-all"><span class="ui-btn-text">Close</span><span class="ui-icon ui-icon-delete ui-icon-shadow">&nbsp;</span></span></a>
		<h1 aria-level="1" role="heading" class="ui-title">Login</h1>
		<div class="fb-login">
			#linkTo(text=imageTag("facebook-icon_200.png"), controller="auth.users", action="facebookOAuth", data_ajax="false")#
		</div>

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

</cfoutput>