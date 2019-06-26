<cfparam name="showunpaid" default="false">
<div class="eachItemShown">
<cfoutput>

	<cfif showunpaid>
	<p>Change: this report shows unpaid registrations. To vew only paid regs click #linkto(text="here",controller="conference.registrations", action="summary")#.</p>
	<cfelse>
	<p>Change: this report no longer shows unpaid registrations. To include unpaid and comp regs click #linkto(text="here", controller="conference.registrations", action="summary", params="includeall")#. Unpaid regs may be duplicates or in process of payment.</p>
	</cfif>

<!--- <cfdump var="#regs#"><cfabort> --->

<table>
<tr>
<th>&nbsp;</th>
<th class="col1">2019 Regs<br/> before #dateformat(regs.todayDate,"mmmm-dd")#</th>
<th class="col1">2018 Regs<br/> before #dateformat(regs.todayDate,"mmmm-dd")#</th>
<th class="col1">2017 Regs<br/> before #dateformat(regs.todayDate,"mmmm-dd")#</th>
<th class="col1">2016 Regs<br/> before #dateformat(regs.todayDate,"mmmm-dd")#</th>
<th>Budget<br/> before April 1</th>
<th>Budget<br/> before May 1</th>
<th>Budget<br/> before June 1</th>
<th>Budget<br/> before July 15</th>
<th>Budget<br/> Total</th>
</tr>
<!---
<tr>
<td>#linkto(text="PreRegs", controller="conference.registrations", action="list", params="type=preregistration")#*</td>
<td align="right" class="col1">&nbsp;</td>
<td align="right" class="col1">#val(regs.Access2017.prepaid)#</td>
<td align="right" class="col1">&nbsp;</td>
<td align="right" class="col1">&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
--->
<tr>
<td>#linkto(text="GroupRegs", controller="conference.registrations", action="list", params="type=Registration-Group")#**</td>
<td align="right" class="col1">#val(regs.Access2019.group)#</td>
<td align="right" class="col1">#val(regs.Access2018.group)#</td>
<td align="right" class="col1">#val(regs.Access2017.group)#</td>
<td align="right" class="col1">&nbsp;</td>
<td align="right" class="col1">&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>#linkto(text="Singles", controller="conference.registrations", action="list", params="type=Registration-Single")#**</td>
<td align="right" class="col1">#val(regs.Access2019.singles)#</td>
<td align="right" class="col1">#val(regs.Access2018.singles)#</td>
<td align="right" class="col1">#val(regs.Access2017.singles)#</td>
<td align="right" class="col1">#val(regs.vTOR.singles)#</td>
<td align="right" class="col1">#val(regs.vNY.singles)#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>#linkto(text="Couples", controller="conference.registrations", action="list", params="type=Registration-Couple")#**</td>
<td align="right" class="col1">#val(regs.Access2019.couples)#</td>
<td align="right" class="col1">#val(regs.Access2018.couples)#</td>
<td align="right" class="col1">#val(regs.Access2017.couples)#</td>
<td align="right" class="col1">#val(regs.vTOR.couples)#</td>
<td align="right" class="col1">#val(regs.vNY.couples)#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>Total</td>
<td align="right" class="col1"><cftry>#regs.Access2019.singles+regs.Access2019.group+(regs.Access2019.couples*2)#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.Access2018.singles+regs.Access2018.group+(regs.Access2018.couples*2)#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.Access2017.singles+regs.Access2017.prepaid+regs.Access2017.group+(regs.Access2017.couples*2)#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.vTOR.singles+(regs.vTOR.couples*2)#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.vNY.singles+(regs.vNY.couples*2)#<cfcatch>!</cfcatch></cftry></td>
<td align="right">310</td>
<td align="right">335</td>
<td align="right">355</td>
<td align="right">375</td>
</tr>
<!---
<tr>
<td>Avg Age</td>
<td align="right" class="col1"><cftry>#regs.Access2017.avgage#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.vTOR.avgage#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.vNY.avgage#<cfcatch>!</cfcatch></cftry></td>
<td align="right" class="col1"><cftry>#regs.vDC.avgage#<cfcatch>!</cfcatch></cftry></td>
<td align="right">&nbsp;</td>
<td align="right">&nbsp;</td>
<td align="right">&nbsp;</td>
<td align="right">&nbsp;</td>
<td align="right">&nbsp;</td>
</tr>
--->
<!---tr>
	<td colspan="8" style="font-size:.8em">
		Plus #Val(v2020daySingle) + (2*val(v2020dayCouple))# day regs, and #v2020eveningSingle.recordcount + (2*v2020eveningCouple.recordcount)# evening regs and #v2020comp.recordcount# comp regs.
	</td>
</tr--->
</table>
<div style="width:400px;margin:10px auto;float:left">
</div>
<div style="width:400px;margin:20px auto">
	<ul style="list-style:none">
		<li>
			List of actual tickets by category:
			<ul style="list-style:none;margin-left:20px">
				<li>
					#linkto(action="list", text="ALL",class="btn btn-block")#
				</li>
				<li>
					#linkto(text="Registrations", action="list", params="type=Registration&token=#getSetting("requiredToken")#",class="btn btn-block")#
				</li>
				<li>
					#linkto(text="Meals", action="list", params="type=Meal&token=#getSetting("requiredToken")#", class="btn btn-block")#
				</li>
				<li>
					#linkto(text="Cohorts", controller="conference.courses", action="showallselectedcohorts", class="btn btn-block")#
				</li>

				<cfif optionsRegIsOpen()>
					<li>
						#linkto(text="Workshops", controller="conference.courses", action="showallselectedworkshops", class="btn btn-block")#
					</li>
				</cfif>

				<li>
					#linkto(text="Options (Excursions)", action="list", params="type=other", class="btn btn-block")#
				</li>

				<cfif childRegIsOpen()>
					</li>

					<li>
						#linkto(text="GraceKids", action="list", params="type=GraceKids", class="btn btn-block")#
					</li>
					<!---
					<li>
						#linkto(text="GraceKids-Nursery", action="list", params="type=GraceKids-Nursery", class="btn btn-block")#
					</li>
					<li>
						#linkto(text="GraceKids-Preschool ", action="list", params="type=GraceKids-Preschool ", class="btn btn-block")#
					</li>
					<li>
						#linkto(text="Grace Kids-Elementary", action="list", params="type=GraceKids-Elementary", class="btn btn-block")#
					</li>
					<li>
						#linkto(text="Grace Kids Excursions ", action="list", params="type=GraceKidsExcursions ", class="btn btn-block")#
					</li>
					<li>
						#linkto(text=" Grace Kids Segments", action="list", params="type= GraceKidsSegments", class="btn btn-block")#
					</li>
					--->
				</cfif>
			</ul>	
		<li>Comments:
			<ul>
				<li>
					** GroupRegistrations were sold online so that one person could purchase multiple regs without providing names at registration The minimum number for a group is 5. Groupreg convert to single regs when the church provides a list of names.
				</li>
				<li>
					#regs.Access2019.Free# free (16-24 yr old or 70+ yr olds) registrations for #getEventAsText()# are not included in these numbers.
				</li>
				<cfif regs.Access2019.staff>
					<li>
						#regs.Access2019.staff# staff registrations for #getEventAsText()# are not included in these numbers.
					</li>
				</cfif>
			</ul>
		</li>
	</ul>
</div>
<div>
	<p>
		<cfset thisyear = year(now())>
		Change Date:
		<cfloop list="#thisyear#-04-01,#thisyear#-05-01,#thisyear#-05-15,#thisyear#-06-01,#thisyear#-06-15,#thisyear#-07-01,#thisyear#-07-15" index="i">
		#linkTo(text=i, params="bydate=#i#", route='conferenceregsummary')#&nbsp;
		</cfloop>
		#linkTo(text="today", params="", route='conferenceregsummary')#
	</p>
	<p>
	<cfif showunpaid>
		#linkto(text="Show only paid regs", params="")#
	<cfelse>
		#linkto(controller="conference.registrations", action="summary", text="Show all regs including ones not paid for yet", params="includeall")#
	</cfif>
	</p>
</cfoutput>
</div>
