<cfoutput>
<H1>Welcome to the FGBC Statistics Page</h1>
<div class="well">
	Links you can use...
	<ul>
		<li>
		#linkto(text = "<h3>A Summary of our Stats for the Past FIVE Years</h3>", 
			controller="handbook.statistics", 
			action="getSummary", 
			key=year(now())-1, 
			params="
			compyear=#year(now())-2#&
			compyear2=#year(now())-3#&
			compyear3=#year(now())-4#&
			compyear4=#year(now())-5#", 
			class="btn btn-block btn-primary")#
		</li>
		<li>&nbsp;</li>
		<li>
			#linkto(
				text="<h3>Growth of our churches</h3>", 
				controller="handbook.statistics", 
				action="churchgrowth", 
				params="
					year1=#year(now())-1#&
					year2=#year(now())-6#&
					delta=10",
				class="btn btn-block btn-info"	
					)
				#
		</li>
		<li>&nbsp;</li>
		<li>
			#linkto(
				text="<h3>Stat History - Individual Churches</h3>", 
				controller="handbook.statistics", 
				action="stathistory",
				class="btn btn-block btn-warning" 
					)
				#
		</li>
		<li>&nbsp;</li>
		<li>
			#linkto(
				text="<h3>Distribution of churches by size</h3>", 
				controller="handbook.statistics", 
				action="sizeByPercent",
				key=year(now())-1,
				class="btn btn-block btn-success" 
					)
				#
		</li>
		</ul>	
</div>
</cfoutput>