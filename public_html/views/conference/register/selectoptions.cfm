<cfparam name="message" default="Begin by typing first names(s) for one adult (ie: 'John''), couple (ie:'John and Jane')<br/> or child (ie:'Johnny') on the left.<br/><br/>You will add last name and contact information later.">
<cfparam name="inputmessage" default="First name(s) of one person, couple or child:">
<cfparam name="placeholdermessage" default="First name(s) of one person, couple or child">

<cfif regType() is "couple">
	<cfset message = "To register a couple, begin by typing the first names of you and your spouse (ie:'John and Jane') on the left.<br/><br/>You will add last name and contact information later.">
	<cfset placeholdermessage = "First names of you and your spouse">
	<cfset inputmessage = placeholdermessage & ":">
<cfelseif regType() is "single">
	<cfset message = "To register a single, begin by typing just your first name (ie:'John') on the left.<br/><br/>You will add last name and contact information later.">
	<cfset inputmessage = "Your first name:">
	<cfset placeholdermessage = "Your first name">
	<cfset inputmessage = placeholdermessage & ":">
	<cfif preRegIsOpen()>
		<cfset message = "Begin by typing just your first name (ie:'John') on the left.<br/><br/>You will add last name and contact information on another screen.<br/>">
	</cfif>
<cfelseif regType() is "group">
	<cfset message = "Begin by typing just the first name (ie:'John') of the faciltator for this group on the left.<br/><br/>You will add last name and contact information on another screen.<br/><br/> Put your group under one facilitators name for now and send us all the names and email addresses sometime before June 1.">
	<cfset inputmessage = "Group facilitator's first name:">
	<cfset placeholdermessage = "Group facilitator's first name">
	<cfset inputmessage = placeholdermessage & ":">
<cfelseif regType() is "family">
	<cfset message = "To register a family, begin by typing the first names of you and your spouse (ie:'John and Jane') on the left.<br/><br/>You will add last name and contact information later. <br/><br/>After you have registered you and your spouse, you change the type of registration to children using the icons near the top of this page. <br/><br/>You can also come back later and add children or meal options to your family's registrations.">
	<cfset placeholdermessage = "First names of you and your spouse:">
	<cfset inputmessage = placeholdermessage & ":">
<cfelseif regType() is "meal">
	<cfset message = "To purchase meal tickets, enter your full name">
	<cfset placeholdermessage = "First Name">
	<cfset inputmessage = placeholdermessage & ":">
<!---	
<cfelseif regType() is "options" && preRegIsOpen()>
	<cfset message = "To purchase for next years conference, enter your name then the number of registrations. We will contact you to add specific names later">
	<cfset placeholdermessage = "First Name">
	<cfset inputmessage = placeholdermessage & ":">
--->	
<cfelseif regType() is "options">
	<cfset message = "To purchase these options enter your first name then the number of tickets.">
	<cfset placeholdermessage = "First Name">
	<cfset inputmessage = placeholdermessage & ":">
<cfelseif regType() is "children">
	<cfset message = "To register children, enter the FIRST name of a child you want to register:">
	<cfset placeholdermessage = "Your child's FIRST name">
	<cfset inputmessage = placeholdermessage & ":">
</cfif>

<cfoutput>

<div class="container">
<cfif isAdmin()>
	<p>ADMIN!</p>
</cfif>

<div class="row">
<div class="Message">
<h2 class="text-center">All prices are in $US Dollars</h2>
	<cfif flashKeyExists("message")>
		#flash("message")#
	<cfelse>
		#message#
	</cfif>

			<hr/>
			<div class="changeregtype">
				<cftry>
					<p>Change type of registration:</p>
					<cfif !regType() is "couple">
						#linkto(text=imageTag("conference/couplereg50.png"), action="selectoptions", params="couple", title="Register a couple", class="tooltiplink")#
					</cfif>
					<cfif !regType() is "single">
						#linkto(text=imageTag("conference/singlereg50.png"), action="selectoptions", params="single", title="Register a single", class="tooltiplink")#
					</cfif>
					#linkto(text=imageTag("conference/groupreg50.png"), action="selectoptions", params="group",title="Register a group", class="tooltiplink")#
					<cfif childRegIsOpen()>
						<cfif !regType() is "family">
							#linkto(text=imageTag("/conference/familyreg50.png"), action="selectoptions", params="family", title="Register a family", class="tooltiplink")#
						</cfif>
						<cfif !regType() is "children">
							#linkto(text=imageTag("/conference/childrenreg50.png"), action="selectoptions", params="children", title="Register Children", class="tooltiplink")#
						</cfif>
					</cfif>
					<cfif mealsRegIsOpen() AND !regType() is "meals">
						#linkto(text=imageTag("/conference/meals50.png"), action="selectoptions", action="selectoptions",params="meals", title="Purchase meal tickets", class="tooltiplink")#
					</cfif>
					<cfif optionsRegIsOpen() && !isRegType("options")>
						#linkto(text=imageTag("/conference/excursion50.png"), action="selectoptions", action="selectoptions",params="options", title="Local Option", class="tooltiplink")#
					</cfif>
				<cfcatch>
					#linkTo(text="Change type of registration", action="selectregtype", class="btn btn-block")#
				</cfcatch>
				</cftry>
			</div>
</div>

<!---Don't ask for person information if this is a group registration--->


<div class="row">
<div id="selectoptions" class="span6">

<cfif !isDefined("session.shoppingcart[1].item") || !isOptionRegTypeGroup(session.shoppingcart[1].item)>

	#startFormTag(action=formaction, spamProtection=true)#

<cfif isdefined("params.return")>
	#hiddenFieldTag(name="return", value=params.return)#
</cfif>

<fieldset id="personNames">
	<legend>#inputmessage#</legend>
#textfieldtag(name="person", value="#urlDecode(params.person)#", required="yes", message="Please enter a name!", placeholder=placeholdermessage, class="input input-xxlarge")#
</fieldset>

#includePartial("selectoptions")#

#submitTag(value=submitvalue, class="btn btn-large btn-block btn-info")#

#endFormTag()#

<cfelseif isDefined("session.registration.regtype") && session.registration.regtype is "groupToSingle">
<p>If this looks correct, click "Checkout" and we will ask for some more information about this person.</p>
<br/><br/>
<p>Once this person is registered, we will send a link to add meals, childcare and select cohorts.</p>
<cfelse>
<p class="groupreginfo">Since this is a group registration, we will put the group under one facilitators name.  When you receive a link to your invoice for these registrations, there will be a form at the bottom to convert each person in your group to an individual registration. Individuals can add meals or childcare later.</p>
</cfif>

</div>


<!------------------------------------->

<div class="" id="shoppingcart">
	#includePartial("shoppingcart")#
</div>
</div><!---.row--->
</div><!---.container--->
</cfoutput>