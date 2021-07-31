<cfoutput>
<div class="container">
    
		Page:
		<ul>
		#paginationLinks(linkToCurrentPage=true, prepend="<li>", append="</li>")#
		</ul>

		<div id="search">
			#startFormTag()#
			#textFieldTag(name="search", placeHolder="Search")#
			#endFormTag()#
		</div>

		<div>
			#includePartial(partial="/mainhome/announcements")#
		</div>

</div>
</cfoutput>
