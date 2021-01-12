<div class="container span11">

  <cfoutput>
    #errorMessagesFor("Handbookpastorswife")#
    <cfif NOT flashIsEmpty()>
      <div id="flash-messages">
          <cfif flashKeyExists("error")>
              <p class="errorMessage">
                  #flash("error")#
              </p>
          </cfif>
          <cfif flashKeyExists("success")>
              <p class="successMessage">
                  #flash("success")#
              </p>
          </cfif>
      </div>
    </cfif>
     <div class="well">
      #pastorsWife.spouse# #pastorsWife.lname#<br/>
      #mailto(pastorsWife.spouse_email)# 
      #pastorsWife.phone4#
      <cfif gotRights("office,thrive")>
        #linkTo(text='<i class="icon-edit"></i>', controller="handbook.wives", action="editMe", key=params.key)#
      </cfif>
      <br/>  
      #pastorsWife.address1#<br/>
      <cfif len(pastorsWife.address2)>
        #pastorsWife.address2#<br/>
      </cfif>
      #pastorsWife.city# #pastorsWife.state_mail_abbrev# #pastorsWife.zip#<br/>
      <cfif val(pastorsWife.profile.wifesBirthdayMonthNumber) && val(pastorsWife.profile.wifesBirthdayDayNumber)>
        <cfset birthday = "#pastorsWife.profile.wifesBirthdayMonthNumber#-#pastorsWife.profile.wifesBirthdayDayNumber#">
        Birthday: #dateFormat(birthday,"mmmm dd")# 
        <br/>
      </cfif>
      <cfif len(pastorsWife.profile.anniversaryAsString)>
        Anniversary: #dateFormat(pastorsWife.profile.anniversaryAsString,"mmmm dd")#<br/>
      </cfif>
      <br/>
      #linkTo(text=pastorsWife.selectname, controller="handbook.people", action="show", key=pastorsWife.id)#
    </div>

  </cfoutput>
</div>