<cfparam name="showElected" type="string" default="false">

<cfif isDefined("params.elected")>
	<cfset showElected = "true">
</cfif>

<cfoutput>
<cfif !showElected>
<h1>Nominees for Fellowship Council #getSetting('nominateTerm')#</h1>
<cfelse>
<h1>New Fellowship Council Members</h1>
#linkto(text="What is the Fellowship Council?", href="https://charisfellowship.us/contents/show/22")#
</cfif>
<div class="hero-unit">
	<cfif !showElected>
	<h3>The Nominating Committee of the <a href="https://charisfellowship.us/">Charis Fellowship</a> is pleased to nominate the following people to the #getSetting('nominateTerm')# term of the <a href="https://charisfellowship.us/contents/show/22">Fellowship Council</a> of the <a href="https://charisfellowship.us/">Charis Fellowship</a>:</h3>
	<p>Delegates at the annual corporation meeting of the Fellowship of Grace Brethren Churches, Inc (Doing business as Charis Fellowship) conference will select one representative from each region from this list.</p>
	<ul>
		<li>Region A: Arctic, Hawaii, Mountain Plains, Nor-Cal, Pacific Northwest, Southern California-Arizona, Iowa Midlands, and Heartland</li>
		<li>Region B: Northcentral Ohio, Northeastern Ohio, Northwest Ohio, Tri-State, Allegheny and Western Pennsylvania</li>
		<li>Region C: Blue Ridge, Chesapeake, Mid-Atlantic, Northern Atlantic, Florida, and Southern.</li>
	</ul>
	<cfelse>
	<h3>The following were elected to serve on the #linkto(text="Fellowship Council", href="https://charisfellowship.us/contents/show/22")# of the Charis Fellowship for #getSetting('nominateTerm')#</h3>
	</cfif>

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
				#linkTo(text='#imageTag("/fellowshipcouncil/nominated/#piclink2#")#', href="/images/fellowshipcouncil/nominated/#piclink#")#
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

<cfif len(nominateMessage) && !showElected>
	<cfoutput>
		<div id="nominatemessage">
			#nominateMessage#
		</div>
	</cfoutput>
</cfif>