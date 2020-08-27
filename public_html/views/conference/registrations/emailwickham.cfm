<cfoutput>
<div style="font-size:14px;font-family:arial,san-serif;width:960px;margin:0 auto;background-color:white">	
<a href="http://www.vision2020now.com" style="border:none"><img src="http://www.fgbc.org/vision2020/images/vision2020logo.jpg" style="margin:10px;border:none" /></a>
<p>
	Hi #fname#!
</p>
<p>Thanks so much for registering for the Vision2020 Leadership Conference!	You are entitled to a free ticket for the Phil Wickham concert on Saturday evening at at 7:30. Wooster Grace is selling tickets to the concert for $15 and $25 but we want to be sure to hold a seat for everyone registered for the Vision2020 conference who wants to attend the concert.  
</p>	
<p>
	Please use this link to claim your free ticket to the concert: 
</p>
<p>#linkto(controller="register", action=request.action, params="peopleid=#personid#&invoiceid=#invoiceid#", onlyPath=false)#</p>
<p>See you soon!<br/>
Tom Avey
</p>

</div>	
</cfoutput>