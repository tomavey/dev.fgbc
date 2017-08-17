<cfif isDefined("params.key") AND val(params.key)>
	 <cfset showheader = false>
<cfelse>
	 <cfset showheader = true>
</cfif>	 
<cfset count = 1>
<div class="span10">
<cfoutput>
<cfif not isDefined("params.date") AND showheader>
	<h1>Handbook Pictures by Last Name</h1>
	<p>#linkTo(text="List by date", action="index", params="date=1", class="btn")#</p>
<cfelseif showheader>	
	<h1>Handbook Pictures by Date Uploaded</h1>
	<p>#linkTo(text="List by Last Name", action="index", params="", class="btn")#</p>
</cfif>	
<cfif gotRights("superadmin")>
	<p>#linkTo(text="New Picture", action="new", class="btn")#</p>
</cfif>
</cfoutput>

<ul class="thumbnails">
  <cfoutput query="handbookpictures">
  <cftry>
    <cfif pictureExists(file)>
      <li class="thumbnail">
           #linkTo(text=imageTag(source='/handbookpictures/thumb_#file#'), href='/images/handbookpictures/web_#file#')#

           <p>#linkto(text=fullname, controller="handbook.people", action="show", key=personid)#</p>

            <cfif gotRights("superadmin,office")>
              <span style="color:grey;font-size:.8em">#createdBy# on #dateformat(createdAt)#<br/><br/></span>
              #showTag()#
            </cfif>

            <cfif gotRights("superadmin,office") OR email is session.auth.email>
              #deleteTag()#
            
        			<cfif useFor is "default">
        			  *
        			<cfelse>  			
                      #linkTo(text='<i class="icon-ok"></i>', action='setPictureAsDefault', key=ID, class="tooltipside", title="Set this picture as the default")#
        			</cfif>  

            </cfif>

    	  <cfset count = count +1>

      </li> 
    </cfif>
          <cfcatch>
            <cfif gotRights("superadmin,office") OR (isdefined("session.auth.email") && email is session.auth.email)>
              #linkto(text=fullname, controller="handbook.people", action="show", key=personid)# - #file#sss
              #deleteTag()# #editTag()#
            </cfif>
          </cfcatch>
    </cftry>
  </cfoutput>

  <li class="span2">
    <cfoutput>
    <cfif gotRights("superadmin")>
    	<p>#linkTo(text="New handbookpicture", action="new")#</p>
    	<p>#linkTo(text="List by date", action="index", params="date=1")#</p>
    </cfif>
    <p>Count = #count#</p>
    </cfoutput>  
  </li>
</ul>
</div>
