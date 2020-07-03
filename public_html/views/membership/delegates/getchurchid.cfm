<cfoutput>
<div id="getchurchid">
	<cfif flashKeyExists("error")>
	<p class="alert alert-error" style="font:2em bold">
		#flash("error")#
	</p>
	</cfif>
		#startFormTag(controller="membership.delegates", action="submit")#
			#selectTag(name='churchid', options=churches, textField='selectNameCity', includeBlank='Select your church')#
			#textfieldTag(name='captcha', placeholder='to avoid webbots', label='How many letters are in the word "grace"?')#
			#submitTag(value='Go to the delegate form for this church', class="btn btn-primary")#
		#endFormTag()#

<!--- 		<form action="submit">
		<select name="churchid" class="span5">
			<option value='0'>---Select your church---</option>
			<cfoutput query="churches">
				<option value='#id#'>#selectNameCity#</option>
			</cfoutput>
		</select>
		<br/>How many letters are in the word "grace"? <input type="text", name="captcha" placeholder="to avoid webbots"/>
		<br/>
		<input type="submit" value="Go to the delegate form for this church" class="btn btn-primary">
		</form>
--->


	<div class="well">
		<cfif isBefore("2020-07-28")>
			<p>The opportunity for declaring the Gospel of Jesus Christ through Charis Fellowship congregations has never been greater. Because our face-to-face meeting this year has been postponed until 2021, the annual business meeting of the Charis Fellowship (a.k.a. the Fellowship of Grace Brethren Churches, Inc.) will be held July 28 at 7:00 pm PDT / 4:00 pm EDT.</p> 
		<cfelse>	
			<p>#linkTo(text=getSetting('eventAsText'), href=getSetting("webpage"))# is a leadership conference sponsored by the #linkTo(text="Charis Fellowship", href="https://charisfellowship.us")# .  This conference includes dynamic speakers, a great location and meal gatherings focusing on ministry around the globe.  It also includes one official business meeting of Charis Fellowship (a.k.a. the Fellowship of Grace Brethren Churches, Inc).</p>
		</cfif>

		<p>
		Member churches are eligible to send delegates to this business meetings to participate in the discussion and vote for things like:
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

		<p>Member churches should submit the names of their approved delegates using this form before #dateFormat(getSetting("delegatesSubmitDeadline"), "mmmm dd, yyyy")#.</p>
	</div>
</div>
</cfoutput>

<script>

$(document).ready(function () {


});
</script>