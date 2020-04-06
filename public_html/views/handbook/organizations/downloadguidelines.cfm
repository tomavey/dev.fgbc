<div class="span10 offset1">
<h2>Use of Charis Fellowship Handbook data</h2>
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
        					#linkto(text="Member Churches and their campuses", route="handbookDownloadmembers", id="navsearch",  params="download=1&include=campuses", title="Download Spreadsheet of Member Churches with their campuses", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>
						<li>
							#linkto(text="Member Churches, their campuses and new churches", route="handbookDownloadmembers", params="download=1&include=campusesandnewchurches", id="navsearch", title="Download Spreadsheet of Member Churches, with campuses PLUS new churches", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li>&nbsp;</li>
        				<li>
        					#linkto(text="People - Blue Pages", route="handbookBluepages", params="download=1", id="navsearch", title="Download a spreadsheet of all people in the blue pages of the handbook.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>
						<li class="preview">
							#linkto(text="Preview - Blue Pages", route="handbookBluepages", params="preview=1", class="downloadconfirm" )#
        				</li>
        				<li>
        					#linkto(text="People - Church Staff", route="handbookBluepages", params="download=1&staffonly=1", id="navsearch", title="Download a spreadsheet of all church staff.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li class="preview">
							#linkto(text="Preview - Church Staff", route="handbookBluepages", params="preview=1&staffonly=1", class="downloadconfirm" )#
        		</li>
						
						<li>
							#linkto(text="People - Church Staff with 'Pastor' in their title", route="handbookBluepages", params="download=1&pastoralstaffonly=1", id="navsearch", title="Download a spreadsheet of all church staff that have the word 'pastor' in their title.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li class="preview">
							#linkto(text="Preview - Church Staff with 'Pastor' in their title", route="handbookBluepages", params="preview=1&pastoralstaffonly=1", class="downloadconfirm" )#
						</li>

						<li>
							#linkto(text="People - Non-Staff (ie: retired)", route="handbookBluepages", params="download=1&nonstaff=1", id="navsearch", title="Download a spreadsheet of all who are listed in the bluepages but who are NOT on staff at a church or ministry", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li class="preview">
							#linkto(text="Preview - People - Non-Staff (ie: retired)", route="handbookBluepages", params="preview=1&nonstaff=1", class="downloadconfirm" )#
						</li>

						<li>
							#linkto(text="Wives - Wives of people with 'Pastor' or 'Chaplain' in their title", route="handbookPeoplePastorsWives", params="download=1", id="navsearch", title="Download a spreadsheet of all church staff that have the word 'pastor' in their title.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
						</li>
						<li class="preview">
							#linkto(text="Preview - Church Staff with 'Pastor' in their title", route="handbookPeoplePastorsWives", class="downloadconfirm" )#
						</li>	

						<li><h3 class="text-center">Download staff of churches in a district:</h3> 
							<cfoutput query="districts">
								<cfif district NEQ "Empty">
								#linkTo(text=district, route="handbookBluepages", params="download=1&staffonly=1&districtid=#districtid#", id="navsearch", title="Download a spreadsheet of all church staff in district.", class="btn btn-large btn-primary tooltip2 downloadconfirm")# 
								</cfif>
							</cfoutput>
						</li>
						<li>&nbsp;</li>
	       				<li>
        					#linkto(text="AGBM", route="handbookDownloadagbm", id="navsearch", title="Download a spreadsheet of all AGBM members.", class="tooltip2 btn btn-large btn-block btn-primary downloadconfirm")#
        				</li>

    					<cfif gotRights("superadmin,office")>
							<li>
								#linkto(text="Links to handbook review pages", route="handbookUpdatelinks", id="navsearch", title="Download a spreadsheet of links to church update pages", class="tooltip2 btn btn-large btn-block btn-primary")#
							</li>
							<li>
								#linkto(text="Brotherhood Mutual Download", route="handbookDownloadMemberChurchesForBrotherhoodPreview", id="navsearch", title="Download a spreadsheet for Brotherhood Mutual", class="tooltip2 btn btn-large btn-block btn-primary")#
							</li>
    					</cfif>
    				</ul>

</cfoutput>
</div>