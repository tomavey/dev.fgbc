<cfoutput>
<cfparam name="title" default="">
<cfif isDefined("content.name")>
	<cfset title=content.name>
</cfif>
      <!-- Promo Block -->
    <section class="g-pos-rel">
      <div class="dzsparallaxer auto-init height-is-based-on-content use-loading mode-scroll" data-options='{direction: "reverse", settings_mode_oneelement_max_offset: "150"}'>
        <div class="divimage dzsparallaxer--target w-100 g-bg-cover g-bg-pos-top-center g-bg-img-hero g-bg-bluegray-opacity-0_2--after" style="height: 130%; background-image: url(../assets/img/extra-hero-image.jpg);"></div>

         <div class="container text-center g-py-130">
        <p class="g-color-white g-font-weight-600 g-font-size-35 text-uppercase"><cfoutput>#title#</cfoutput></p>
      </div>
      </div>
    </section>
    <!-- End Promo Block --> 

<div class="container card card-charis card-charis-square">

		<cfif !len(content.rightsRequired) OR gotRights(content.rightsRequired)>

					#content.content#

			<cfif gotrights("superadmin,office,pageEditor")>

									#content.author#


								<p>Updated: #dateformat(content.updatedAt)#</p>

								<p>Created: #dateformat(content.createdAt)#</p>
				<cfif gotrights("superadmin,pageEditor,office")>
					#listTag(controller="admin.contents")# | #editTag(controller="admin.contents", id=content.id)#
				</cfif>
			</cfif>


			<cfif isDefined("content.shortlink") && len(content.shortlink)>
				<p>Link to this page: #linkTo(controller="contents", action="show", key=content.shortlink, onlyPath=false)#</p>
			<cfelse>
				<p>Link to this page: #linkTo(controller="contents", action="show", key=content.id, onlyPath=false)#</p>
			</cfif>

		<cfelse>
			<p>You do not have permission to view this page.</p>
		</cfif>		

</div>
</cfoutput>

