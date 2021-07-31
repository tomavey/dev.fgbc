<h3>Sending SMS From a Web Page Example</h3>
<cfif IsDefined("form.oncethrough") is "Yes">
<cfif IsDefined("form.SMSMessage") is True AND form.SMSMessage is not "">
<h3>Sending Text Message: </h3>
<cfoutput>#form.SMSMessage#</cfoutput><br>
<cfscript>
/* Create a structure that contains the message. */
msg = structNew();
msg.command = "submit";
msg.destAddress = "5745276061";
msg.shortMessage = form.SMSMessage;
ret = sendGatewayMessage("SMS Menu App - 5745276061", msg);
</cfscript>
</cfif>
<hr noshade>
</cfif>
<!--- begin by calling the cfform tag --->
<cfform action="command.cfm" method="POST">
SMS Text Message: <cfinput type="Text" name="SMSMessage" value="Sample text Message" required="No" maxlength="160">
<p><input type = "submit" name = "submit" value = "Submit">
<input type = "hidden" name = "oncethrough" value = "Yes">
</cfform>