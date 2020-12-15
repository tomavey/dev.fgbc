<div class="span11">
  <cfoutput>
    <h2>
      Handbook people without pictures
    </h2>
    <p>Count: #peopleWithoutPictures.recordCount#</p>
  </cfoutput>
  
  <!--- <cfoutput>#ddd(peopleWithoutPictures)#</cfoutput> --->
  <ul>
    <cfoutput query="peopleWithoutPictures">
      <li>
        #linkTo(text=selectName, controller="handbook.people", action="show", key=id, encode=false)#... 
        #linkTo(text="<i class='icon-search'></i>", href='http://www.google.com/search?tbm=isch&q=#fname#+#lname#+#city#+#Handbookstatestate#', title="Seach Google", target="_blank")#
      </li>
    </cfoutput>
  </ul>
  
</div>
