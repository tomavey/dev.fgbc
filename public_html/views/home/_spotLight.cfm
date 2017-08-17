<cfoutput>

	<cfif isBefore("May 20, 2017")>
		<div class="spotlightImageHolder">
			#spotlightTag(image="family2016-17.jpg", text="Focus Retreats 2016/17", controller="focus.main", action="welcome")#
		</div>
	</cfif>

		<div class="spotlightImageHolder">
			#spotlightTag(image="charisalliance.jpg", text="Charis Alliance", route="page", key=82)#
		</div>

	<cfif isBefore("August 20, 2017")>
		<div class="spotlightImageHolder">
			#spotlightTag(image="access2017.jpg", text="Access 2017", href="http://www.access2017.com")#
		</div>
	</cfif>

		<div class="spotlightImageHolder">
			#spotlightTag(image="equippingnetwork.jpg", text="Equipping Network", href="http://fgbc.org/page/equippingnetwork")#
		</div>

		<div class="spotlightImageHolder">
			#spotlightTag(image="resources.png", controller='resources')#
		</div>


	<cfif isBefore("December 1, 2015")>
		<div class="spotlightImageHolder">
			#linkTo(text='#imageTag("spotlight/fellowshipforumsb.jpg")#<br/><h4 style="text-align:center">Fellowship Forums</h4>',
					href="http://fgbc.org/admin/contents/55")#
		</div>
	</cfif>


</cfoutput>