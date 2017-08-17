<cfoutput>
<h2>We do not have a #year(now())-1# Statistical Report on file for #church.name#.  Please use the link below to submit your churches statistics before registering your delegates.</h2>
<p style="text-align:center">#linkTo(text="Go to statistical form", controller="handbookStatistics", action="submit", key=params.key, class="btn btn-primary")#</p>
</cfoutput>
<p>Note: Questions?  Call the church office at 574-269-1269 or use <a href="http://www.fgbc.org/messages/new"></a>this form to send us a message.</a></p>
