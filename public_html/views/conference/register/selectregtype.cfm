<div class="container" id="selectregtype">
<cfset message = "What would you like to do?">
<cfif !isBefore("#year(now())#-07-17") && isAfter("#year(now())#-12-31")>
<cfset message = "">
</cfif>
<cfoutput>
<cfif isAdmin()>
	<p>ADMIN!</p>
</cfif>

	<cfif flashKeyExists("message")>
		<p class="Message">
		#flash("message")#
		</p>
	<cfelse>
		<div class="Message">
			#message#
		</div>
	</cfif>

<div class="row regtypes">

<cfset span = "span4">

<cfif regAccountIsOpen()>
	<div class="#span#">
			#linkto(text=imageTag("/conference/account.png"), controller="conference.users", action="my-regs")#
			#linkto(text="See your current registrations", controller="conference.users", action="my-regs", class="btn btn-large btn-block btn-info")#
	</div>
</cfif>

<cfif regIsOpen()>
	<div class="#span#">
		#linkto(text=imageTag("/conference/couplereg.png"), action="selectoptions", params="couple")#
		#linkto(text="Register a couple", action="selectoptions", params="couple",class="btn btn-large btn-block btn-info")#
	</div>

	<div class="#span#">
		#linkto(text=imageTag("/conference/singlereg.png"), action="selectoptions", params="single")#
		#linkto(text="Register a single", action="selectoptions", params="single", class="btn btn-large btn-block btn-info")#
	</div>
</cfif>

<cfif groupRegIsOpen()>
	<div class="#span#">
		#linkto(text=imageTag("/conference/groupreg.png"), action="selectoptions", params="group")#
		#linkto(text="Register a group", action="selectoptions", params="group", class="btn btn-large btn-block btn-info")#
	</div>
<cfelse>	
	<div class="#span#">
		#linkto(text=imageTag("/conference/groupreg.png"), onclick="alert('Not available'); return false")#
		#linkto(text="Registration for Group <br/> is not available", onclick="alert('Not available'); return false", class="btn btn-large btn-block btn-info")#
	</div>
</cfif>

<cfif childRegIsOpen()>
	<div class="#span#">
		#linkto(text=imageTag("/conference/familyreg.png"), action="selectoptions", params="family")#
		#linkto(text="Register a family", action="selectoptions", params="family", class="btn btn-large btn-block btn-info")#
	</div>

	<div class="#span#">
		#linkto(text=imageTag("/conference/childrenreg.png"), action="selectoptions", params="children")#
		#linkto(text="Register your children", action="selectoptions", params="children", class="btn btn-large btn-block btn-info")#
	</div>
<cfelse>
	<div class="#span#">
		#imageTag("/conference/familyreg.png")#
		#linkto(text="Registration for Grace Kids<br/> is not currently available online", onclick="alert('Not available yet'); return false", class="btn btn-large btn-block btn-info")#
	</div>

	<div class="#span#">
		#imageTag("/conference/childrenreg.png")#
		#linkto(text="Registration for Grace Kids<br/> is not available yet", onclick="alert('Not available yet'); return false", class="btn btn-large btn-block btn-info")#
	</div>
</cfif>

<cfif mealsRegIsOpen()>
	<div class="#span#">
		#linkto(text=imageTag("/conference/meals.png"), action="selectoptions", action="selectoptions",params="meals")#
		#linkto(text="Purchase Only Meal Tickets", action="selectoptions",params="meals", class="btn btn-large btn-block btn-info")#
	</div>
<cfelse>
	<div class="#span#">
		#imageTag("/conference/meals.png")#
		#linkto(text="Meal Tickets are not<br/> currently available online.", onclick="alert('Not available yet'); return false", class="btn btn-large btn-block btn-info")#
	</div>
</cfif>

<cfif optionsRegIsOpen()>
	<div class="#span#">
		#linkto(text=imageTag("/conference/excursion.png"), action="selectoptions", action="selectoptions",params="options")#
		#linkto(text="Put N Bay w/ Dinner", action="selectoptions",params="options", class="btn btn-large btn-block btn-info")#
	</div>
</cfif>

</div>

<cfif (!mealsRegIsOpen() || !childRegIsOpen()) && isBefore("2016-07-15")>
	<br/>
	<div class="well alert text-center">
		<cfif !mealsRegIsOpen()>
			<h1>
				Meal options are not currently available online.
			</h1>
		</cfif>
		<cfif !childRegIsOpen()>
			<h1>
				Childcare options are not currently available online.
			</h1>
		</cfif>

		<h2>
			You can add meal options when these options are available.
		</h2>

	</div>
</cfif>
</cfoutput>
</div>