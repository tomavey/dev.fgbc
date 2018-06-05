<cfoutput>
<cfif flashKeyExists("error")>
<p class="alert alert-error" style="font:2em bold">
#flash("error")#
</p>
</cfif>

	<form action="submit">
	<select name="key" class="span5">
		<option value='0'>---Select your church---</option>
		<cfoutput query="churches">
			<option value='#id#'>#selectNameCity#</option>
		</cfoutput>
	</select>
	<br/>How many letters are in the word "grace"? <input type="text", name="captcha" placeholder="to avoid webbots"/>
	<br/>
	<input type="submit" value="Go to the delegate form for this church" class="btn btn-primary">
	</form>


<div class="well">
<p>#linkTo(text="Access2018", href="http://www.access2018.com")# is a leadership conference sponsored by the #linkTo(text="Charis Fellowship", href="https://charisfellowship.us")# .  This conference includes dynamic speakers, a great location and meal gatherings focusing on ministry around the globe.  It also includes one official business meeting of FGBC, inc.</p>

<p>
Member churches are eligible to send delegates to these business meetings to participate in the discussion and vote for things like:
<ul>
<!---
<li>#linkTo(text="New members of the Fellowship Council (board of directors)", href="http://fgbc.org/nominate/list")#</li>
--->
<li>New members of the Fellowship Council (board of directors)</li>
<li>Future executive director of the Charis Fellowship</li>
<li>New member churches</li>
<li>New cooperating organizations</li>
<li>The Charis Fellowship Annual budget including fellowship fees</li>
</ul>
</p>

<p>Member churches should submit the names of their approved delegates using this form before July 1.</p>
</div>
</cfoutput>
