<div class="container span11">

  <cfoutput>
    <div class="well">
      #pastorsWife.spouse# #pastorsWife.lname#<br/>
      #mailto(pastorsWife.spouse_email)# #pastorsWife.phone4#<br/>  
      #pastorsWife.address1#<br/>
      <cfif len(pastorsWife.address2)>
        #pastorsWife.address2#<br/>
      </cfif>
      #pastorsWife.city# #pastorsWife.state_mail_abbrev# #pastorsWife.zip#<br/>
      <cfif val(pastorsWife.Handbookprofile.wifesBirthdayMonthNumber) && val(pastorsWife.Handbookprofile.wifesBirthdayDayNumber)>
        <cfset birthday = "#pastorsWife.Handbookprofile.wifesBirthdayMonthNumber#-#pastorsWife.Handbookprofile.wifesBirthdayDayNumber#">
        Birthday: #dateFormat(birthday,"mmmm dd")#<br/>
      </cfif>
      <cfif len(pastorsWife.Handbookprofile.anniversaryAsString)>
        Anniversary: #dateFormat(pastorsWife.Handbookprofile.anniversaryAsString,"mmmm dd")#<br/>
      </cfif>
      <br/>
      #linkTo(text=pastorsWife.selectname, controller="handbook.people", action="show", key=pastorsWife.id)#
    </div>

  </cfoutput>
</div>