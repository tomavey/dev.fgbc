<cfoutput><h1>Nominees for Fellowship Council #application.wheels.nominateTerm#</h1>
#linkto(text="What is the Fellowship Council?", href="http://fgbc.org/contents/show/22")#
<div class="hero-unit">
<h3>The Nominating Committee of the <a href="http://www.fgbc.org/">Fellowship of Grace Brethren Churches</a> is pleased to nominate the following people to the #application.wheels.nominateTerm# term of the <a href="http://fgbc.org/contents/show/22">Fellowship Council</a> of the <a href="http://www.fgbc.org/">Fellowship of Grace Brethren Churches</a>:</h3>
<p>Delegates at National Conference will select one representative from each region from this list.</p>
<ul>
    <li>Region A: Arctic, Hawaii, Mountain Plains, Nor-Cal, Pacific Northwest, Southern California-Arizona, Iowa Midlands, and Heartland</li>
    <li>Region B: Northcentral Ohio, Northeastern Ohio, Northwest Ohio, Tri-State, Allegheny and Western Pennsylvania</li>
    <li>Region C: Blue Ridge, Chesapeake, Mid-Atlantic, Northern Atlantic, Florida, and Southern.</li>
</ul>
</div>
<hr/>
</cfoutput>
<cfoutput query="nominations" group="region">
	<h1>#region#: </h1>
<hr/>
	<cfoutput>
	<div class="well nominee">
		<h2>#nomineename#</h2>
		<p>District: #district#</p>
		<p>Church: #nomineechurch#</p>
		<p>	<cftry>
				<cfset piclink2 = replace(piclink,".jpg","_web.jpg","all")>
				#linkTo(text='#imageTag("/fellowshipcouncil/nominated/#piclink2#")#', href="http://www.fgbc.org/images/fellowshipcouncil/nominated/#piclink#")#
			<cfcatch>#piclink#</cfcatch>
			</cftry>
			<cfif isDefined("bioShort") && len(bioShort) && ! isDefined("params.biolong")>
				#bioShort#
				#linkto(text="Use Long Bio", action="list", params="biolong=true")#
			<cfelse>
				#bio#
			</cfif>
		</p>
	</div>
	</cfoutput>
<hr/>
</cfoutput>

<cfif len(nominateMessage)>
	<cfoutput>
		<div id="nominatemessage">
			#nominateMessage#
		</div>
	</cfoutput>
</cfif>