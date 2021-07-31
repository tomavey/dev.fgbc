<div id="consultants">
<cfloop list="ID,LNAME,FNAME,PHONE,EMAIL,EXPERIENCE,COMMENT" index="i">
<cfparam name="form.#i#" default="">
</cfloop> 
<cfform action="#xfa.formaction#" method="post">
<cfif isdefined("form.id")>
	<cfinput type="hidden" value="#form.id#">
</cfif>
      <table>
            <tr class="even">
                  <td id="label">LNAME</td>
                  <td><cfinput type="text" name="lname" value="#form.lname#" id="lname"></td>
            </tr>
            <tr class="odd">
                  <td id="label">FNAME</td>
                  <td><cfinput type="text" name="fname" value="#form.fname#" id="fname"></td>
            </tr>
            <tr class="even">
                  <td id="label">PHONE</td>
                  <td><cfinput type="text" name="phone" value="#form.phone#" id="phone"></td>
            </tr>
            <tr class="odd">
                  <td id="label">EMAIL</td>
                  <td><cfinput type="text" name="email" value="#form.email#" id="email"></td>
            </tr>
            <tr class="even">
                  <td id="label">EXPERIENCE</td>
                  <td><cfinput type="text" name="experience" value="#form.experience#" id="experience"></td>
            </tr>
            <tr class="odd">
                  <td id="label">COMMENT</td>
                  <td><cfinput type="text" name="comment" value="#form.comment#" id="comment"></td>
            </tr>
            <tr>
                  <td colspan="2" align="center"><cfinput type="submit" name="submit" value="Submit"></td>
            </tr>
      </table>
</cfform>
</div>