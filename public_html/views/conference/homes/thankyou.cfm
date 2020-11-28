<cfparam name="thankyouMessage" default="Thank You message goes Here">
<cfparam name="thankyouId" default=0>

<div class="container" style="background-color:white;padding:20px;border-radius:10px">

  <cfoutput>

    #includePartial(partial="includes/navbar")#

  
    <cfif gotRights("office")>
      <p class="text-right">
        #linkto(text="<i class='fa fa-pencil-square'></i>", controller="admin.contents", action="edit", key=thankyouId)#
      </p>
    </cfif>
  
    <p>#thankyouMessage#</p>

    <cfif gotRights("office")>
      #listTag(action="index")#
    </cfif>
  
  </cfoutput>

</div>