<cfoutput>
<div class="row-fluid well contentStart contentBg">

<div class="span12">

	<h1>#blog.title#</h1>

					<p><span>Blog Address: </span>
						#linkTo(text=blog.blogAddress, href=blog.blogAddress)#</p>
				
					<p><span>Feedburner Code: </span>
						#blog.feedburnerCode#</p>
				
					<p><span>Feedburner Name: </span>
						#linkto(text=blog.feedburnerName, href=blog.feedburnerName)#</p>
				
					<p><span>Feedburner Number: </span>
						#blog.feedburnerNumber#</p>
				
					<p><span>Email: </span>
						#mailto(blog.email)#</p>
				
					<p><span>Active: </span>
						#blog.active#</p>
				
					<p><span>Sortorder: </span>
						#blog.sortorder#</p>
				
					<p><span>Created: </span>
						#dateformat(blog.createdAt)#</p>
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this blog", action="edit", key=blog.id)#
</div>
</cfoutput>
