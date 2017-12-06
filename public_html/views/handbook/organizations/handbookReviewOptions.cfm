<div class="row">
<div class="span10 offset1">
<cfoutput>
#linkTo(text="Show All", action="handbookReviewOptions", params="reviewedBefore=#dateFormat(now() +1)#", class="pull-right")#
#startFormTag(action="handbookReviewOptions", method="get", class="form-search")#
#textFieldTag(id="datepicker", Label="Show churches last reviewed before:&nbsp;&nbsp;", name="reviewedBefore", value=dateFormat(args.reviewedBefore), class="input-small search-query", prepend="", append="")#
<button type="submit" class="btn">Search</button>
#endFormTag()#
    <table id="handbookReviewOptions">
        <tr>
            <th>    
                #linkto(text="Send to #arrayLen(churches)# Addresses from #getHandbookReviewSecretary()#", action="EmailChurchesForHandbookReview", class="btn", confirm="Are you absolutely certain!!!???", params="reviewedBefore=#args.reviewedBefore#&go=true")#</br>
                
            </th>
            <th>
                #linkto(text="Send to these test Churches from #getHandbookReviewSecretary()#", action="EmailChurchesForHandbookReview", class="btn", params="reviewedBefore=#args.reviewedBefore#&go=false")#
            </th>
        </tr>
        <tr>
            <td>
                Order by: 
                    #linkto(text="City", action="handbookReviewOptions", params="reviewedBefore=#args.reviewedBefore#&go=true&orderby=org_city")# | 
                    #linkto(text="Review Date", action="handbookReviewOptions", params="reviewedBefore=#args.reviewedBefore#&go=true&orderby=reviewedAt")# | 
                    #linkto(text="Church Name", action="handbookReviewOptions", params="reviewedBefore=#args.reviewedBefore#&go=true&orderby=name")# | 
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td valign="top">
                <cfloop from="1" to="#arraylen(churches)#" index="i">
                    #linkto(
                        text=churches[i].selectName, 
                        controller="handbook.organizations", 
                        action="show", 
                        key=churches[i].id, target="_blank")
                    #: 
                    #churches[i].email# 
                    #createEmailToUpdateOrg(churches[i].id,churches[i].email)#</br>
                    Last reviewed #churches[i].lastreviewedAt# by #churches[i].lastreviewedby#</br> 
                    #linkto(text='<i class="icon-remove"></i>', action="removeChurchFromSessionArray", params="item=#i#")#</br>
                    </br>
                </cfloop>
            </td>
            <td valign="top">
                <cfloop from="1" to="#arraylen(testchurches)#" index="i">
                    #testchurches[i].selectName#: #testchurches[i].email#</br>
                </cfloop>
            </td>
        </tr>
    </table>
</cfoutput>
</div>
</div>
