<cfoutput>
		#linkTo(text="fgbc.org", controller="home", action="index", params="nomobile", data_ajax="false", data_role="button", class="ui-btn-left")#

		<h1>FGBC.org/Mobile</h1>
		<!---
		#linkto(text="Login", controller="main", action="index", data_role="button", data_transition="flip", data_icon="info", class="ui-btn-right")#
		--->
		<cfif gotRights("basic")>
			#linkto(text=session.auth.email, controller="auth.users", action="logout", data_role="button", data_transition="flip", data_icon="info", class="ui-btn-right", data_ajax="false")#
		<cfelse>	
			#linkto(text="login", controller="mobile", anchor="login", data_role="button", data_icon="info", data_rel="dialog", class="ui-btn-right", data_ajax=true)#
		</cfif>

		<!---
		#linkTo(text="Open left panel", href="##left-panel", data_icon="arrow-r", data_iconpos="notext", data_shadow="false", data_isconshadow="false", class="ui-icon-nodisc ui-btn-left")#
		--->
</cfoutput>