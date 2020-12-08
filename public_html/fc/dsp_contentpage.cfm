<cfif isdefined("url.originalid")>
	<cfset attribute.editable = "no">
<cfelse>
	<cfset attribute.editable = "yes">
</cfif>

<cfoutput>
	<cfif not attribute.editable>
		<p><h2>History: #dateformat(content.datetime)# by #content.author# (not editable)</h2></p>
	<cfelse>
		<cfform action="#fbx('editcontent')#&id=#id#" id="editbutton"><cfinput type="submit" name="submit" value="Edit This Page"></cfform>
	</cfif>

	<cfif attribute.editable>
   		<p id="editlink"><a href="#fbx('editcontent')#&id=#id#"><img src="/images/edit-icon.png"></a></p>
	</cfif>

	<!---add commission list if this is a commission notes page--->
	<cfswitch expression="#url.id#">
		<cfcase value=360>
			<cfset tag="fc_structures">
			<cfinclude template = "dsp_commission.cfm">
			<hr/>
		</cfcase>
		<cfcase value=357>
			<cfset tag="fc_finance">
			<cfinclude template = "dsp_commission.cfm">
			<hr/>
		</cfcase>
		<cfcase value=361>
			<cfset tag="fc_membership">
			<cfinclude template = "dsp_commission.cfm">
			<hr/>
		</cfcase>
		<cfdefaultcase>
			<a href="?fuseaction=commissions" style="float:right">Commissions List</a>
		</cfdefaultcase>
	</cfswitch>
	<!---end of commission list--->

  		#content.paragraph#
		  
		  <br/><br/>
		  Updated: #dateformat(content.datetime,"medium")# by <a href="mailto:#content.author#">#content.author#</a></cfoutput>

	<cfif attribute.editable>	
		<cfform action="#fbx('editcontent')#&id=#id#" id="editbutton"><cfinput type="submit" name="submit" value="Edit This Page"></cfform>
	</cfif>

	<cfif isdefined("url.code")>
		<a id="buttonOne">Click here to Add this Page to Favourites</a>
	</cfif> 

	<cfif attribute.editable && history.recordcount && isDefined("url.showhistory")>
		<div style="border: 2px solid black; padding:20px; margin:20px">
		<p><span>History:</span>
			note: When an document is changed the original document is retained and a new one is created in the database.  So history is never lost! 
			<ul>
				<cfoutput query="history">
					<li>
						<a href="#fbx('content')#&id=#id#&originalid=#content.id#">#dateformat(datetime, "yyyy-mm-dd")# by #author#</a>
					</li>
				</cfoutput>
			</ul>	
		</p>
	</div>
	</cfif>

	<cfoutput>
		<p><a href="/fc/index.cfm?fuseaction=content&id=#content.id#&showHistory">Show History</a></p>
	</cfoutput>
