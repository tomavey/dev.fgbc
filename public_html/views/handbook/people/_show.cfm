<cfoutput>

#includePartial("pictures")#

					<h2 style="display:inline;">
						<cfif len(handbookperson.prefix)>#trim(handbookperson.prefix)# </cfif>#handbookperson.fname# #trim(handbookperson.lname)#<cfif len(handbookperson.suffix)> #trim(handbookperson.suffix)#</cfif><cfif len(handbookperson.spouse)>,&nbsp;<i>#handbookperson.spouse#</i></cfif>
					</h2>

					<cfif NOT isAjax() AND (isDefined("session.auth.handbook.people") AND gotHandbookPersonRights(handbookperson.id)) OR gotrights("superadmin,office,agbmadmin,handbookedit")>
					<p id="editicon">
						  #linkto(text='<i class="icon-edit"></i>', action="edit", key=params.key, class="tooltipleft", title="Edit #handbookperson.fullname#")#
					</p>
					</cfif>


					<p>
						#handbookperson.address1#<br />
						<cfif len(handbookperson.address2)>
							#handbookperson.address2#<br />
						</cfif>

						<cfif handbookperson.stateid is not 53>
							#handbookperson.city#, #handbookperson.handbookstate.state#
						<cfelse>
							#handbookperson.city#
						</cfif>
						 #handbookperson.zip# <br/>
						<cfif len(handbookperson.country) and handbookperson.country DOES NOT CONTAIN "USA">
							#handbookperson.country#
						</cfif>
					</p>

				<p>
					<cfif len(handbookperson.phone)>
						H: #phoneTo(handbookperson.phone)#<br/>
					</cfif>

					<cfif len(handbookperson.phone2)>
						M: #phoneTo(handbookperson.phone2)#<br/>
						<cfif gotRights("office")>
							#telCoQueryLink(handbookperson.phone2)#
							#linkto(text="?", href="https://charisfellowship.us/admin/settings/17", target="_new")#<br/>
						</cfif>
					</cfif>

					<cfif len(handbookperson.phone3)>
						W: #phoneTo(handbookperson.phone3)#<br/>
					</cfif>

					<cfif len(handbookperson.skype)>
						<span>Skype:</span>#handbookperson.skype#<br/>
					</cfif>

					<cfif len(handbookperson.email)>
						#mailTo(handbookperson.email)#<br/>
					</cfif>

					<cfif len(handbookperson.email2)>
						#mailto(handbookperson.email2)#<br/>
					</cfif>

					<cfif len(handbookperson.spouse_email)>
						Spouse: #mailto(handbookperson.spouse_email)#<br/>
					</cfif>
				</p>

#includePartial("positions")#

</cfoutput>