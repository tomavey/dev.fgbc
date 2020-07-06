<div>
<h1>For some reason your credit card payment has failed.  You may use the link below to try again or call the Charis Fellowship National Office at 574-269-1269 for assistance.</h1>
<cfoutput>#linkTo(action="payonline", key=params.key, params="sendNotice=False", text="Try Again", class="btn btn-large btn-block btn-primary", style="display:block")#</cfoutput>
</div>