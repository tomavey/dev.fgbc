<cfoutput>
<div class="row-fluid well contentStart contentBg">
    
    <div class="span3">
        #includePartial(partial="sidebar", selected="home")#
    </div>

    <div class="span9">

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
			#includePartial(partial="/mainhome/announcements")#
		</div>

	</div>
</div>
</cfoutput>
