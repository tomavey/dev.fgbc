<div style="font-family:Arial, Helvetica, sans-serif;font-size:1.1em">

<cfoutput>


<div id="churchinfo">
<p>
	#church.name#
	#church.address1#<br/>
	<cfif len(church.address2)>
		#church.address2#<br/>
	</cfif>
	#church.org_city#, #church.handbookstate.state_mail_abbrev# #church.zip#<br/>
</p>
<p>
	Delegates allowed: #church.delegatecount#
</p>

</div>

<div>
<p>Submitter: #delegates.submitter#</p>
<p>Submitter Email: #delegates.submitteremail#</p>

</div>

</cfoutput>

<h2>Your Delegates...</h2>
<ul>
<cfoutput query="delegates">

	<li>

		#name# - #email#

	</li>

</cfoutput>

</ul>

<cfoutput>
	Save use this link to edit your delegate information:
	#linkTo(action="show", controller="membership.delegates", key=params.key, onlyPath=false)#
</cfoutput>
 <h2 class="well">Delegate instructions and reports will be available at<br/> <a href="https://charisfellowship.us/page/delegates2019">charisfellowship.us/page/delegates2019</a>.<br/>  Please share this link with all your delegates</a></h2>
</div>

