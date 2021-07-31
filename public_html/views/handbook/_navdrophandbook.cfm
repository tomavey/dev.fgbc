<!---Drop Down options under administration--->
<cfoutput>
            <cfif gotRights("office,handbookedit")>
        				<li>
        					#linkto(text="Blue Pages", route="handbookBluepages", id="navsearch", title="People Info for Handbook", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Yellow Pages", route="handbookYellowpages", id="navsearch", title="Church Info for Handbook", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Prayer List", route="handbookPrayerlist", id="navsearch", title="Generate a prayerlist for the handbook.", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Districts", controller="handbook.districts", action="index", id="navsearch", title="Links to District Information", class="tooltip2")#
        				</li>
                        <li>
                            #linkto(text="Districts Report", controller="handbook.districts", action="handbookreport", id="navsearch", title="Report for Handbook", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Ministries List (for inside cover)", controller="admin.ministries", action="simplelist", id="navsearch", title="Report for Handbook", class="tooltip2")#
                        </li>
        				<li>
        					#linkto(text="Church Distribution", controller="handbook.organizations", action="distribution", id="navsearch", title="Download distribution list to churches", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="People Distribution", controller="handbook.people", action="distribution", id="navsearch", title="Download distribution list to people", class="tooltip2")#
        				</li>
            </cfif>

</cfoutput>