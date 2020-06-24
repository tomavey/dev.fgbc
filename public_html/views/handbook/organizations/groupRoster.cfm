<cfset count = 0>
<div class="offset1" id="showinfo">
<h2>FGBC Group Roster</h2>
<cfscript>
    var SortOptions = [
      {option:"Fein",sortBy:"fein"},
      {option:"Name",sortBy:"name"},
      {option:"City",sortBy:"org_city"},
      {option:"State",sortBy:"state"}
      ]
    writeOutput("Sort By: ")  
    ArrayEach(SortOptions,function(item) {
      writeOutPut( linkto(text=item.option, controller="handbook.organizations", action="grouproster", params="sortBy=#item.sortby#") )
      writeOutput( " | " )
    }) 
</cfscript>

<form class="form-search" action="/handbook/grouproster" method="get">
  <button type="submit" class="btn">Search</button>
  <input type="text" class="input-medium search-query" name="search" placeholder="search">
</form>

<cfoutput query="rosterChurches">
  <cfset count = count + 1>
<p>
#linkto(text=selectname, controller="handbook.organizations", action="show", key=id)#&nbsp;&nbsp;&nbsp;  EIN##&nbsp;#fein#
</p>
</cfoutput>
<cfoutput>
  Count: #rosterChurches.recordCount#<br/>
  #linkto(text="Group Roster Guidelines", href="https://charisfellowship.us/files/FGBCgroupexemptionprocedure2019.pdf" target="_new")#
</cfoutput>
</div>