<cfparam name="testimonies" type="query">

<table class="table table-stripped">
  <thead>
    <tr>
      <th>
      Name
      </th>
      <th>
      Email
      </th>
      <th>
      Date
      </th>
      <th>
      Approved?
      </th>
      <th>
      Retreat
      </th>
      <th>
      &nbsp;
      </th>
    </tr>
  </thead>

  <tbody>
  <cfoutput query="testimonies">
    <tr>
      <td>
      #name#
      </td>
      <td>
      #email#
      </td>
      <td>
      #dateformat(createdAt)#
      </td>
      <td>
      #approved#
      </td>
      <td>
      #regid#
      </td>
      <td>
      #linkTo(text="<i class='icon-edit'></i>", action="edit", key=id, title="Edit this item", class="tooltip2")#
      #linkTo(text="<i class='icon-remove'></i>", controller="focus.testimonies", action="delete", key=id, title="Delete this item", class="tooltip2", onclick="return confirm('Are you sure you want delete this story?');", params="code=charis")#
      #linkTo(text="<i class='icon-search'></i>", action="show", key=id, title="View this item", class="tooltip2")#
      #linkTo(text="<i class='icon-ok'></i>", action="approve", key=id, title="Approve this item", class="tooltip2")#
      </td>
    </tr>
  </cfoutput>
  </tbody>
</table>

<cfoutput>
#linkTo(text="Add a new testimony", action="new")#
</cfoutput>