<div class="span10 offset1">
<h2>Use of FGBC Handbook data</h2>
<p>You have been given access to downloads of church and people data from the FGBC annual handbook (directory). In order to protect people and organizations listed in the handbook, you are to observe the following guidelines:</p>
<ol>
<li>Do not share your login information with anyone else. If you need access for administrative staff, that person should create and user account on FGBC.org and use the contact form on FGBC.org to request access to the handbook. Please allow 2 or 3 days for that access to be granted.</li>
<li>If you provide downloaded spreadsheets to staff inside your organization, you are responsible that they follow these guidelines.</li>
<li>Do not send downloaded spreadsheets to anyone outside of your organization.</li>
<li>Do not use the information in these spreadsheets for regular (weekly or monthly) mass emails. You can use this list as a one-time invitation to subscribe to regular email distribution.</li>
<li>If you use this list to send an email messsage to more than 30 addresses, copy that email to tomavey@fgbc.org along with an explanation of the purpose and destination or your mass email.</li>
<li>By clicking on any of the links below, you agree to follow these guidelines!</li>
</ol>
<hr/>

<cfoutput>
    				<ul>
        				<li>
        					#linkto(text="Member Churches and their campuses", route="handbookDownloadmembers", id="navsearch", title="Download Spreadsheet of Member Churches with their campuses", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>
						<li>
							#linkto(text="Member Churches, their campuses and new churches", route="downloadmemberchurchesadmin", key="includecampusesandnewchurches", params="download=", id="navsearch", title="Download Spreadsheet of Member Churches, with campuses PLUS new churches", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li>&nbsp;</li>
        				<li>
        					#linkto(text="People - Blue Pages", controller="handbook.people", action="bluepages", params="download=1", id="navsearch", title="Download a spreadsheet of all people in the blue pages of the handbook.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>
        				<li>
        					#linkto(text="People - Church Staff", controller="handbook.people", action="bluepages", params="download=1&staffonly=1", id="navsearch", title="Download a spreadsheet of all church staff.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>
						<li>
							#linkto(text="People - Church Staff with 'Pastor' in their title", controller="handbook.people", action="bluepages", params="download=1&pastoralstaffonly=1", id="navsearch", title="Download a spreadsheet of all church staff that have the word 'pastor' in their title.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li><h3 class="text-center">Download staff of churches in a district:</h3> 
							<cfoutput query="districts">
								<cfif district NEQ "Empty">
								#linkTo(text=district, controller="handbook.people", action="bluepages", params="download=1&staffonly=1&districtid=#districtid#", id="navsearch", title="Download a spreadsheet of all church staff in district.", class="btn btn-large btn-primary tooltip2 downloadconfirm")# 
								</cfif>
							</cfoutput>
						</li>
						<li>&nbsp;</li>
	       				<li>
        					#linkto(text="AGBM", controller="handbook.people", action="downloadagbm", id="navsearch", title="Download a spreadsheet of all AGBM members.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>

    					<cfif gotRights("superadmin,office")>
							<li>
								#linkto(text="Links to handbook review pages", controller="handbook.organizations", route="handbookUpdatelinks", id="navsearch", title="Download a spreadsheet of links to church update pages", class="tooltip2 btn btn-large btn-block btn-primary")#
							</li>
							<li>
								#linkto(text="Brotherhood Mutual Download", route="handbookDownloadMemberChurchesForBrotherhood", id="navsearch", title="Download a spreadsheet for Brotherhood Mutual", class="tooltip2 btn btn-large btn-block btn-primary")#
							</li>
    					</cfif>
    				</ul>

</cfoutput>
</div>