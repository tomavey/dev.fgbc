<div class="container">

<cfoutput query="locations">
  <div class="eachItemShown">
    <h3>
      #roomnumber#
    </h3>
    <p>
      Capacity: #capacity#
    </p>
    <p>
      Equipment: #equipment#
    </p>
    <p>
      Default Setup: #defaultsetup#
    </p>
    <p>
      Manager: #manager#
    </p>
    #linkTo(text="Show events in this location", controller="conference.events", action="index", params="locationid=#id#")#
    #editTag()#
  </div>
</cfoutput>

</div>