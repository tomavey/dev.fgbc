<div class="container card"><h1>Resources...</h1>

	<cfoutput>

		<p>Here are some resources that many of our churches are using...</p>

		<p style="font-size:.6em">
			<cfif gotRights("office") && !isDefined("params.showAll") >
				#linkTo(text="Show all", params="showAll=1")#
			<cfelseif gotRights("office") && isDefined("params.showAll")>
				#linkTo(text="Show only public", params="")#
			</cfif>
		</p>

	</cfoutput>

	<ul>
	<cfoutput query="resources">
		<cfif len(file)>
			<li>#linkTo(text=description, href="#application.wheels.webpath#files/#file#")#
				<cfif len(summary)>
					<span class="expand">#summary#</span>
				</cfif>
			</li>
		<cfelseif len(image)>
			<li>#linkTo(text="<img src='#image#' />", href=webaddress)#
				<cfif len(summary)>
					<span class="expand">#summary#</span>
				</cfif>
			</li>
		<cfelseif len(webaddress)>
			<li>#linkTo(text=description, href=webaddress)#
				<cfif len(summary)>
					<span class="expand">#summary#</span>
				</cfif>
			</li>
		<cfelse>
		</cfif>
	</cfoutput>
	</ul>

	<cfoutput>
		<cfif gotrights("superadmin,office")>
			<p>
				#linkto(text="Upload a new resource", controller="admin.resources", action="new")#
			</p>
		</cfif>
	</cfoutput>

</div>
