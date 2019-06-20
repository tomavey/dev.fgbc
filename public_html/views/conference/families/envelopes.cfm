<!---cfdump var='#envelopes#'><cfabort--->
<cfparam name="params.checksum" default="false">
<cfset previousname = "">
<cfset previousinvoice = "">

<cfif params.checksum>

	<cfset count = structNew()>
	<cfset listcounts = "envelopes,count,spouses," & listcounts>
	<cfloop list="#listcounts#" index="i">
		<cfset count[i] = 0>
	</cfloop>

</cfif>

<cfoutput>
<cfif not isdefined("params.download")>
#startFormTag(action="envelopes")#
#dateSelectTags(name="date")#
#submitTag("Date After")#
#endFormTag()#
</cfif>

<cfif isDefined("params.date")>
	#linkTo(text="Download as Excel", action="envelopes", params="download=true&date=#dateformat(params.date,'yyyy-mm-dd')#")#
<cfelse>
	#linkTo(text="Download as Excel", action="envelopes", params="download=true")#
</cfif>

<cfif isDefined("params.showFnameId") && isDefined("params.alpha")>
	| #linkTo(text="Don't Show Merge Icon", action="envelopes", params="alpha=#params.alpha#")#
<cfelseif isDefined("params.showFnameId")>
	| #linkTo(text="Don't Show Merge Icon", action="envelopes", params="")#
<cfelseif !isDefined("params.showFnameId") && !isDefined("params.alpha")>	
	| #linkTo(text="Show Merge Icon", action="envelopes", params="showFnameId=true")#
<cfelseif !isDefined("params.showFnameId") && isDefined("params.alpha")>	
	| #linkTo(text="Show Merge Icon", action="envelopes", params="alpha=#params.alpha#&showFnameId=true")#
</cfif>

<p>
	<cfif isDefined('params.showFnameId')>
		<cfloop list="#getSetting('alphabet')#" index="i">
			#linkTo(text=i, action="envelopes", params="showFnameId=#params.showFnameId#&alpha=#i#")#
		</cfloop>	
			#linkTo(text="all", action="envelopes", params="showFnameId=#params.showFnameId#")#
	<cfelse>
		<cfloop list="#getSetting('alphabet')#" index="i">
			#linkTo(text=i, action="envelopes", params="alpha=#i#")#
		</cfloop>	
			#linkTo(text="all", action="envelopes", params="")#
	</cfif>	
</p>

</cfoutput>

<table border="1">
	<tr>

		<cfif isDefined("params.option")>
			<th>&nbsp;</th>
		</cfif>
		<th>Invoice</th>
		<th>Tickets</th>
	</tr>
<cfset count1 = 0>

<cfoutput query="envelopes">

	<cfset thisenvelopeinfo = thisFamilyEnvelopeInfo(id)>


	<cfif showThisEnvelope(thisFamilyEnvelopeInfo(id),previousinvoice)>

		<cfset count1 = count1 + 1>
		<cfif thisFamilyEnvelopeInfo(id).name is previousname>
			<cfset color = "red">
		<cfelse>
			<cfset color = "black">
		</cfif>

		<tr style="color:#color#">
		<cfif isDefined("params.option")>
			<td>#count1#</td>
		</cfif>
		<td style="padding:3px">
			#linkto(text=LNAME, controller="conference.families", action="show", key=id, target="_new")#,&nbsp;#thisFamilyEnvelopeInfo(id).name#
			(#linkto(text=thisenvelopeinfo.invoice, controller="conference.invoices", action="show", key=val(thisenvelopeinfo.invoice), target="_new")#
			#thisenvelopeinfo.status#)
		</td>

		<td style="padding:3px">
		 	#thisenvelopeinfo.items#
		</td>
		</tr>

		 	<cfif params.checksum>
			 	<cfset count.count = count.count + listLen(thisenvelopeinfo.items,";")>
			 	<cfloop list="#thisenvelopeinfo.items#" delimiters=";" index="i">
			 		<cfloop list="#listcounts#" index="ii">
				 		<cfif i contains ii>
				 			<cfset count[ii] = count[ii] + 1 >
				 		</cfif>
			 		</cfloop>
			 	</cfloop>
				<cfset count.envelopes = count.envelopes + 1>
				<cfif thisFamilyEnvelopeInfo(id).name contains "&">
					<cfset count.spouses = count.spouses + 1>
				</cfif>
		 	</cfif>

		<cfset previousname = thisFamilyEnvelopeInfo(id).name>
		<cfset previousinvoice = thisFamilyEnvelopeInfo(id).invoice>

	</cfif>
</cfoutput>
</table>
<p>&nbsp;</p>
<p>Use these links to just show one ticket and check counts:</p>
<cfoutput>
	#linkto(text="Add checksum", params="checksum=true")#
	<cfloop list="#listcounts#" index="i">
		#linkto(text=i, action=params.action, params="option=#i#&checksum=true")#
	</cfloop>
	<p>Count: #count1#</p>
</cfoutput>
<cfif params.checksum>
<cfoutput>
	<p>Check Sums - use people/ticket(s) count from summary report</p>
	<cfloop collection=#count# item="i">
		<cfif count[i]>
			#i#: #count[i]#<br/>
		</cfif>
	</cfloop>
</cfoutput>
</cfif>
