<div class="regcosts">
<cfoutput>

<cfif preRegIsOpen() && !regIsOpen()>
	<div id="singlecosts" class="well">
<p class="text-center">Before January 1, 2017 groups of 5 or more can pre-register for just <span class="price">$65 per person.</span>.   Register 5 or more now and add the specific names later (we will contact you for the names after January 1.  We encourage you to bring your church staff and leadership! </p>
	</div>
<cfelse>
			<div id="singleregcosts" class="well">
				<h3>SINGLE: Registration costs for a single registration...</h3>
				<table>
						<tr>
							<th>&nbsp;</th>
							<th>ages 25-75</th>
							<th>ages 16-24</th>
							<th>ages 75+</th>
						</tr>
					<cfif isBefore("05/01/2017")>
						<tr>
							<td>Before May 1-</td>
							<td class="center">$#getDollarType()#85</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("06/01/2017")>
						<tr>
							<td>Before June 1-</td>
							<td class="center">$#getDollarType()#95</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/01/2017")>
						<tr>
							<td>Before July 1-</td>
							<td class="center">$#getDollarType()#105</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
						<tr>
							<td>After July 15-</td>
							<td class="center">$#getDollarType(408)#115</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
				</table>
				<p style="text-align:center">Refundable if you cancel before July 15!<br/>
			</div>

			<div id="coupleregcosts" class="well">
				<p><h3>COUPLE: Registration costs for a COUPLE'S registration...</h3>
				<span style="font-size:.8em">At least one person in the married couple must qualify for the age discount.</span>
				</p>
				<table>
						<tr>
							<th>&nbsp;</th>
							<th>ages 25-75</th>
							<th>ages 16-24</th>
							<th>ages 75+</th>
						</tr>
					<cfif isBefore("05/01/2017")>
						<tr>
							<td>Before May 1-</td>
							<td class="center">$#getDollarType()#120</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("06/01/2017")>
						<tr>
							<td>Before June 1-</td>
							<td class="center">$#getDollarType()#130</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/01/2017")>
						<tr>
							<td>Before July 1-</td>
							<td class="center">$#getDollarType()#140</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/15/2017")>
						<tr>
							<td>Before July 15-</td>
							<td class="center">$#getDollarType()#150</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
						<tr>
							<td>After July 15-</td>
							<td class="center">$#getDollarType()#160</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
				</table>
				<p style="text-align:center">Refundable if you cancel before July 15!<br/>
			</div>

<!---
			<div id="dayratecosts" class="well">
				<p><h3>DAY RATES: Registration costs for one day of Vision Conference...</h3>
				</p>
				<table>
						<tr>
							<th>&nbsp;</th>
							<th>ages 25-74</th>
							<th>ages 16-24</th>
							<th>ages 75+</th>
						</tr>
					<cfif isBefore("05/01/2017")>
						<tr>
							<td>Before May 1-</td>
							<td class="center">$#getDollarType()#40</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("06/01/2017")>
						<tr>
							<td>Before June 1-</td>
							<td class="center">$#getDollarType()#50</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/01/2017")>
						<tr>
							<td>Before July 1-</td>
							<td class="center">$#getDollarType()#60</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/15/2017")>
						<tr>
							<td>Before July 15-</td>
							<td class="center">$#getDollarType()#70</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
						<tr>
							<td>After July 15-</td>
							<td class="center">$#getDollarType()#125</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
				</table>
				<p style="text-align:center">Refundable if you cancel before July 15!<br/>
				</p>
			</div>

			<div id="dayratecosts" class="well">
				<p><h3>COUPLE DAY RATES: Registration costs for one day of Vision Conference for a couple...</h3>
				</p>
				<table>
						<tr>
							<th>&nbsp;</th>
							<th>ages 25-74</th>
							<th>ages 16-24</th>
							<th>ages 75+</th>
						</tr>
					<cfif isBefore("05/01/2017")>
						<tr>
							<td>Before May 1-</td>
							<td class="center">$#getDollarType()#60</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("06/01/2017")>
						<tr>
							<td>Before June 1-</td>
							<td class="center">$#getDollarType()#70</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/01/2017")>
						<tr>
							<td>Before July 1-</td>
							<td class="center">$#getDollarType()#80</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/15/2017")>
						<tr>
							<td>Before July 15-</td>
							<td class="center">$#getDollarType()#90</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
						<tr>
							<td>After July 15-</td>
							<td class="center">$#getDollarType()#100</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
				</table>
				<p style="text-align:center">Refundable if you cancel before July 15!<br/>
				</p>
			</div>
--->
			<div id="groupratecosts" class="well">
				<p><h3>GROUP RATES: For groups of 5 or more...</h3>
				</p>
				<table>
						<tr>
							<th>&nbsp;</th>
							<th>ages 25-74</th>
							<th>ages 16-24</th>
							<th>ages 75+</th>
						</tr>
					<cfif isBefore("07/01/2017")>
						<tr>
							<td>Before July 1-</td>
							<td class="center">$#getDollarType()#75</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("06/01/2017")>
						<tr>
							<td>Before July 1-</td>
							<td class="center">$#getDollarType()#65</td>
							<td class="center">FREE</td>
							<td class="center">FREE</td>
						</tr>
					</cfif>
					<cfif isBefore("07/023/2017")>
						<tr>
							<td>After July 1</td>
							<td class="center" colspan="3">Not available after July 1</td>
						</tr>
					</cfif>
				</table>
				<p style="text-align:center">Not Refundable<br/>
				</p>
			</div>

			<div id="gracekidscosts" class="well">
				<p><h3>Grace Kids: Child care costs (infant through 6th grade)</h3>
				<!---
				<span style="font-size:.8em">Grades 1-6 will also do some excursions.</span>
				--->
				</p>
				<table>
					<tr>
						<td>One Child</td>
						<td>$#getDollarType()#50</td>
					</tr>
					<tr>
						<td>Two Children</td>
						<td>$#getDollarType()#90</td>
					</tr>
					<tr>
						<td>Three Children</td>
						<td>$#getDollarType()#120</td>
					</tr>
					<tr>
						<td>Four Children</td>
						<td>$#getDollarType()#140</td>
					</tr>
					<tr>
						<td>Five Children</td>
						<td>$#getDollarType()#150</td>
					</tr>
					<tr>
						<td>Six Children</td>
						<td>$#getDollarType()#160</td>
					</tr>
				</table>
				<p style="text-align:center">Refundable if you cancel before July 15!
				</p>
			</div>
</cfif>
</cfoutput>
			</div>
