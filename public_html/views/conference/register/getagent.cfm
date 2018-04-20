<cfoutput>
<div class="container" id="getAgent">
<div class="eachItemShown">
<cfif isDefined("session.shoppingcart[1].groupRegId")>
    <p class="getagentinstructions">Please enter an email address where we can send a link to this registration...</p>
    <cfset agentFieldLabel = "Email address to send registration link to">
<cfelse>
    <p class="getagentinstructions">Please enter an email address where we can send confirmation of this registration and payment...</p>
    <cfset agentFieldLabel = "Email address to send confirmation:">
</cfif>
<p><h2 class="alert">#flash("agent")#</h2></p>

#startFormTag(route=formaction2, id="getagent")#
    #textfieldtag(label=agentFieldLabel, name="agent", value="#params.agent#")#
#submitTag(value="Submit", class="btn")#
#endFormTag()#

<cfif !isDefined("session.shoppingcart[1].groupRegId")>
    <p style="text-align:center;font-size:1.4em">Do not press the back button on your browser from this page on.</p>
</cfif>
</div>
</cfoutput>
</div>
<cfif application.wheels.environment is "development" && false>
<cfdump var="#session#">
<cfdump var="#params#">
</cfif>