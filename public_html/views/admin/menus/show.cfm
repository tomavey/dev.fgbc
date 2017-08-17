<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12">

<h1>Showing menu</h1>

					<p><span>Name</span>:
						#menu.name#</p>
				
					<p><span>Description</span>:
						#menu.description#</p>
				
					<p><span>Category</span>:
						#menu.category#</p>
				
					<p><span>Sub_menu_of</span>:
						#menu.sub_menu_of#</p>
				
					<p><span>Image</span>:
						#menu.image#</p>
				
					<p><span>Link</span>:
						#menu.link#</p>
				
					<p><span>Controller</span>:
						#menu.controller#</p>

					<p><span>Action</span>:
						#menu.action#</p>

					<p><span>Key</span>:
						#menu.keyy#</p>

					<p><span>Rightsrequired</span>:
						#menu.rightsrequired#</p>
				
					<p><span>Sortorder</span>:
						#menu.sortorder#</p>
				
					<p><span>Created At</span>:
						#dateformat(menu.createdAt)#</p>
				
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this menu", action="edit", key=menu.id)#
</div>
</div>
</cfoutput>
