<cfparam name="uiBtnActive" default="">
<cfoutput>

		<ul>
			<cfif uiBtnActive is "news">
				<li>#linkTo(text="News", controller="mobile", action="news", data_ajax=false, data_icon="grid", class="ui-btn-active")#</li>
			<cfelse>				
				<li>#linkTo(text="News", controller="mobile", action="news", data_ajax=false, data_icon="grid", class="ui-btn-inactive")#</li>
			</cfif>

			<cfif uiBtnActive is "churches">
				<li>#linkTo(text="Churches", controller="mobile", action="index", anchor="churches", data_ajax=dataajax, data_icon="home", class="ui-btn-active")#</li>
			<cfelse>	
				<li>#linkTo(text="Churches", controller="mobile", action="index", anchor="churches", data_ajax=dataajax, data_icon="home")#</li>
			</cfif>	

			<cfif uiBtnActive is "ministries">
				<li>#linkTo(text="Ministries", controller="mobile", action="index", anchor="ministries", data_ajax=dataajax, data_icon="gear", class="ui-btn-active")#</li>	
			<cfelse>
				<li>#linkTo(text="Ministries", controller="mobile", action="index", anchor="ministries", data_ajax=dataajax, data_icon="gear")#</li>	
			</cfif>

			<cfif uiBtnActive is "opportunities">
				<li>#linkTo(text="Opportunities", controller="mobile", action="opportunities", data_ajax=false, data_icon="star", class="ui-btn-active")#</li>	
			<cfelse>
				<li>#linkTo(text="Opportunities", controller="mobile", action="opportunities", data_ajax=false, data_icon="star")#</li>	
			</cfif>	
		</ul>

</cfoutput>