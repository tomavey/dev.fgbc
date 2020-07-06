<cfparam name="selected" default="all">

<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">Churches by State</li>
		<cfoutput><li class="active">#linkTo(text="All", controller="churches")#</a></li></cfoutput>
		<cfloop query="arguments.qStates">
			<li><a href="##" class="state"><cfoutput>#state#</cfoutput></a></li>
		</cfloop>
	</ul>
</div>