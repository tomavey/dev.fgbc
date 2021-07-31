				<cfoutput query="blogs">
					
					<div class="postbox blogs">

						<span style="font-size:1.2em;font-weight:bold">
							<cfif blogaddress is not "">
							    <a href="#blogaddress#">#Title#</a>
						    <cfelse>
						    	#title#
						    </cfif>
							<cfif not active>INACTIVE!</cfif>
						</span>

						<cfif gotrights("superadmin,office")>
							#editTag(controller="admin.blogs")# #showTag(controller="admin.blogs")# #deleteTag(controller="admin.blogs")#
						</cfif>

						<!---if this person is logged in, show email subscription link--->
						<cfif isdefined("session.auth.login") and session.auth.login>
							<cfif isdefined("feedburnerCode") and feedburnerCode is not "">
								<p style="text-align:right;padding-bottom:15px;font-size:10px">
									<a href="http://feedburner.google.com/fb/a/mailverify?uri=#feedburnerCode#&amp;loc=en_US&email=#session.auth.email#','mywindow','width=600,height=500,location=no,scrollbars=no,toolbar=no,directories=no,menubar=no,status=no" onclick="window.open('http://feedburner.google.com/fb/a/mailverify?uri=#feedburnerCode#&amp;loc=en_US&email=#session.auth.email#','mywindow','width=600,height=500,location=no,scrollbars=no,toolbar=no,directories=no,menubar=no,status=no');return false">Subscribe to "#title#" by Email</a>
								</p>
							</cfif>
						</cfif>
						
						<!---Test to see if new format code is in database--->
						<cfif isdefined("feedburnerCode") and feedburnerCode is not "">
							<script src="http://feeds.feedburner.com/#feedburnerCode#?format=sigpro&displayDate=true&displayExcerpts=true&nItems=#nitems#&excerptLength=15&displayTitle=false" type="text/javascript" >
							</script>
							<noscript>
								<p>
									Subscribe to RSS headline updates from: 
										<a href="http://feedburner.google.com/fb/a/mailverify?uri=#feedburnercode#&amp;loc=en_US">#title#</a><br/>
										Powered by FeedBurner
								</p> 
							</noscript>
						<cfelse>
							Feed is not set up correctly!
						</cfif>
						
					</div>
					
			<!---Create a column break--->
		<cfif blogs.currentrow is int(blogs.recordcount/2)>
			</td>
			<td valign="top" width="50%" align="left" class="eachblog">
		</cfif>
					
				</cfoutput>
