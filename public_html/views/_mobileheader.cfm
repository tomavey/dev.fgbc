<cfoutput>
		<a href="https://twitter.com/fgbc" class="twitter-follow-button" data-show-count="false" class="ui-btn-left">Follow</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>

		<h1>FGBC.org-Mobile</h1>
		<!---
		#linkto(text="Login", controller="main", action="index", data_role="button", data_transition="flip", data_icon="info", class="ui-btn-right")#
		--->
		<cfif gotRights("basic")>
			#linkto(text=session.auth.email, controller="auth.users", action="logout", data_role="button", data_transition="flip", data_icon="info", class="ui-btn-right", data_ajax="false")#
		<cfelse>	
			<a href="##login" data-role="button" data-transition="flip" data-icon="info" class="ui-btn-right">Login</a>
		</cfif>

		<!---
		#linkTo(text="Open left panel", href="##left-panel", data_icon="arrow-r", data_iconpos="notext", data_shadow="false", data_isconshadow="false", class="ui-icon-nodisc ui-btn-left")#
		--->
</cfoutput>