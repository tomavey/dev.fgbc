<!---Drop Down options under administration--->
<cfoutput>
            <cfif gotRights("office,handbookedit")>

        				<li>
        					#linkto(text="New organization", controller="handbook.organizations", action="new", id="navsearch", title="Add a new organization.", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="New Person", controller="handbook.people", action="new", id="navsearch", title="Add a new person.", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="New Read Only Person", controller="handbook.people", action="new", params="simple", id="navsearch", title="Add a new person.", class="tooltip2")#
        				</li>
        				<li>
        					#linkto(text="Stats", controller="handbook.statistics", action="index", title="Handbook Administration", class="tooltip2")#
        				</li>
                        <li>
                            #linkto(text="Districts", controller="handbook.districts", action="index", id="navsearch", title="Districts", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Page Views", controller="handbook.updates", action="hits", id="navsearch", title="Page Views in the handbook.", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Subscribers", controller="handbook.subscribes", action="index", id="navsearch", title="List Subscriptions", class="tooltip2")#
                        </li>
                        <!---li>
                            #linkto(text="Send Email", controller="handbook.people", action="sendToHandbookPeople", id="navsearch", title="Send a pre-set email after confirmation", class="tooltip2")#
                        </li--->
                        <li>
                            #linkto(text="Send Dates", route="handbooksendTodaysDates", params="go=test", id="navsearch", title="Send todays birthdays and anniversaries to subscribed emails", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Send Prayer - Daily", controller="handbook.subscribes", action="sendTodaysprayerreminders", params="go=test", id="navsearch", title="Send todays prayer notices to subscribed emails", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Send Prayer - Weekly", controller="handbook.subscribes", action="sendThisWeeksPrayerReminders", params="go=test", id="navsearch", title="Send todays prayer notices to subscribed emails", class="tooltip2")#
                        </li>
                        <li>
                             #linkto(text="Send Yesterdays Updates", route="handbookSendYesterdaysUpdates", params="go=test", id="navsearch", title="Sends yesterdays updates to the handbook.", class="tooltip2")#
                        </li>
<!---
                        <li>
                            #linkto(text="Views Log", controller="user.views", action="index", id="navsearch", title="User Views of fgbc.org", class="tooltip2")#
                        </li>
--->
                        <li>
                            #linkto(text="Cell Phone Numbers", controller="handbook.people", action="cellPhoneNumbers", title="Cell Phone Numbers", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Send Update Church Links", controller="handbook.organizations", action="handbookReviewOptions", id="navsearch", title="under development", class="tooltip2")#
                        </li>
                        <li>
                            #linkto(text="Send Update Person Links", controller="handbook.people", action="handbookReviewOptions", id="navsearch", title="under development", class="tooltip2")#
                        </li>
						<li>
							#linkto(text="Web Sites", controller="handbook.organizations", action="websites")#
						</li>
						<li>
							#linkto(text="501c3 Group Roster", controller="handbook.organizations", action="groupRoster")#
						</li>
            </cfif>
            <cfif gotrights("office,agbmadmin")>
        				<li>
        					#linkto(text="AGBM", route="handbookAgbmList", id="navsearch", title="AGBM List Manger", class="tooltip2")#
        				</li>
            </cfif>
            <cfif gotrights("office,handbookadmin,ministrystaff")>
                        <li>
                            #linkto(text="Change Log", controller="handbook.updates", action="index", id="navsearch", title="Log of Changes.", class="tooltip2")#
                        </li>
                        <li>
                            #linkTo(text="Settings", controller="admin.settings", action="index", params="category=handbook", id="navsearch", title="Handbook Settings", class="tooltip2")#
                        </li>
            </cfif>

</cfoutput>