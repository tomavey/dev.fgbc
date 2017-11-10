<cfoutput>
<div class="container">
    
		Page:
		<ul>
			#paginationLinks(linkToCurrentPage=false, prepend="<li>", append="</li>")#
		</ul>

		<div id="search">
			#startFormTag(action="index")#
			#textFieldTag(name="search", placeHolder="Search")#
			#endFormTag()#
		</div>

		<div>
			#includePartial("/home/announcements")#
		</div>

</div>
</cfoutput>
