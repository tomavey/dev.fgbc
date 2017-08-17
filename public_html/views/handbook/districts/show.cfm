<cfparam name="district" type="struct">
<div class="span11">
	<cfoutput>
		<h2>#district.district#</h2>

		#linkTo(text="Edit", action="edit", key=params.key, class="btn")#
		<cfif gotRights("superadmin,office")>
			#linkTo(text="List", action="index", class="btn")#
		</cfif>
		#linkTo(text="This information is correct", action="setreview", key=params.key, class="btn")#

		<cfif len(district.reviewedAt)>
			<p>Last reviewed on #dateformat(district.reviewedAt)# by #district.reviewedBy#</p>
		<cfelse>
			<p>Last updated on #dateformat(district.updatedAt)# by #district.updatedBy#</p>
		</cfif>

		<div class="well">
			#district.report#
		</div>

		<cfif val(district.agbmregionid)>	
			<p>AGBM Region: #agbmregion.name#</p>
		</cfif>
			<p>Fellowship Council Region: #district.region#</p>
			
		#linkTo(text="Edit", action="edit", key=params.key, class="btn")#

		<cfif gotRights("superadmin,office")>
			#linkTo(text="List", action="index", class="btn")#
		</cfif>

		<cfset message = urlencode("Greetings! - I'm finishing up the #year(now())+1# FGBC handbook.  Can you review the #district.district# district information for me using the link provided?  This week? http://fgbc.org/handbook-districts/show/#district.districtid# Be sure to click the 'This information is correct' button when you are finished. Thanks - Tom ")>
		<cfset subject = urlEncode("Please review the FGBC Handbook listing for #district.district#")>

				 	#mailTo(
						name='<i class="icon-envelope"></i>',
						emailaddress='?subject=#subject#&body=#message#',
						alt="e"
										)#

	</cfoutput>
</div>