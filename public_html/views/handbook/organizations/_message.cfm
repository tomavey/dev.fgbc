<cfparam name="church.selectName" default="CHURCH NAME">
<cfparam name="church.email" default="CHURCH EMAIL">
<cfparam name="church.lastReviewedAt" default="CHURCH LAST REVIEWED AT">
<cfparam name="church.lastReviewedBy" default="CHURCH LAST REVIEWED BY">
<cfparam name="church.id" default=0>

<cfoutput>
  <h1>#getSetting('ChurchHandbookReviewGreeting')#</h1>

  <h3>The #year(now())+1# Charis Fellowship Handbook is in production and we would like to make sure our information about #church.selectName# is correct!</h3>
  
  <p>Please use this link to update the listing for #church.selectName# before #$deadLineAsString()#</p>
  
  <p>#linkto(route="reviewhandbook", orgid=simpleEncode(church.id), onlyPath=false)#</a></p>
  <p style="font-weight:bold">Thanks so much for your help! If you need assistance, reply to this email and I will get back to you.</p>
  <p style="font-size:.8em;color:grey"><span>From</span>: #getHandbookReviewSecretary()#</p>
  <p style="font-size:.8em;color:grey"><span>To</span>: #church.email#</p>
  <p style="font-size:.8em;color:grey"><span>Church</span>: #church.selectName#</p>
  <p style="font-size:.8em;color:grey"><span>Last Reviewed</span>: #church.lastReviewedAt# by #church.lastReviewedBy#</p>
  <p style="font-size:.8em;color:grey">You are receiving this email because you are church in the Charis Fellowship.</p>
  
</cfoutput>
