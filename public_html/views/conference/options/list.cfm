<cfoutput query="options">
<div class="eachItemShown show">

					<p style="font-weight:bold;font-size:1.5em">#buttondescription# - #numberformat(cost, "$9999.99")#</p>
				
					<p>#description#</p>

					<cfif gotRights("office,pageEditor")>
						#linkto(text="Edit", controller="conference.options", action="edit", key=id)#
					</cfif>
				
</div>

</cfoutput>
