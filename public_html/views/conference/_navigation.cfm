<cfoutput>
    <nav id="main-nav" class="main-navigation primary">
			<h2 class="hidden">Main navigation</h2>
			
							<div class="menu-main-menu-container"><ul id="menu-main-menu-6" class="menu"><li class="ppr-new-window menu-item menu-item-type-post_type menu-item-object-page menu-item-37"><a target="_blank" href="#confUrl#/register/">Register</a></li>
<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-25"><a href="#confUrl#/location/">Location</a></li>
<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-22"><a href="#confUrl#/speakers/">Speakers</a>
<ul class="sub-menu">
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-351"><a href="#confUrl#/alan-hirsch/">Alan Hirsch</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-357"><a href="#confUrl#/speakers/caesar-kalinowski/">Caesar Kalinowski</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-476"><a href="#confUrl#/speakers/michel-faulkner/">Michel Faulkner</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-467"><a href="#confUrl#/speakers/ed-lewis/">Ed Lewis</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-477"><a href="#confUrl#/speakers/kevin-pinkerton/">Kevin Pinkerton</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-485"><a href="#confUrl#/speakers/steve-galegor/">Steve Galegor</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-486"><a href="#confUrl#/speakers/nathan-wells/">Nathan Wells</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-491"><a href="#confUrl#/speakers/bartley-sawatsky/">Bartley Sawatsky</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-501"><a href="#confUrl#/speakers/phil-sparling/">Phil Sparling</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-502"><a href="#confUrl#/speakers/javier-forero/">Javier Forero</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-505"><a href="#confUrl#/speakers/dave-guiles/">Dave Guiles</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-571"><a href="#confUrl#/speakers/heidi-bogue/">Heidi Bogue</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-575"><a href="#confUrl#/speakers/tim-boal/">Tim Boal</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-579"><a href="#confUrl#/speakers/liz-culter-gates/">Liz Cutler Gates</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-647"><a href="#confUrl#/speakers/bonnie-beuggert/">Bonnie Beuggert</a></li>
</ul>
</li>
<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-27"><a href="#confUrl#/grace-kids/">Grace Kids</a></li>
<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-271"><a href="#confUrl#/blog/">Blog</a></li>
<li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-273"><a>More</a>
<ul class="sub-menu">
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-24"><a href="#confUrl#/schedule/">Schedule</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-26"><a href="#confUrl#/meals/">Meals &##038; Events</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-23"><a href="#confUrl#/workshops/">Workshops</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-36"><a href="#confUrl#/riskursions/">Riskursions</a></li>
	<li class="ppr-new-window menu-item menu-item-type-post_type menu-item-object-page menu-item-457"><a target="_blank" href="#confUrl#/exhibitors/">Exhibitors</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-442"><a href="#confUrl#/media/">Media</a></li>
	<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-386"><a href="#confUrl#/contact-form/">Contact Us</a></li>
</ul>
</li>

	<cfif not isLoggedIn()>
		<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-36"><a href="####loginModal" role="button" data-toggle="modal">Login</a></li>
	<cfelse>

		<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-24">#linkto(text="My Account", controller="conference.users", action="myRegs")#
		<ul class="sub-menu">
		  <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-26">#linkto(text="Logout", route="authLogoutUser")#</li>
		  <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-23">#linkto(text="My Registrations", controller="conference.users", action="myRegs")#
		</ul>
		</li>
	</cfif>

</ul></div>			
					</nav>

</cfoutput>
