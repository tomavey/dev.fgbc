<div class="container span10">
    <cfoutput>
     
        #startFormTag(action="handbookReviewOptions", method="get", class="form-search")#
        #textFieldTag(Label="Show persons last reviewed before:&nbsp;&nbsp;", name="lastReviewedBefore", value=args.lastReviewedBefore, class="input-small", id="datepicker", prepend="", append="")#
        <cfif isDefined("params.type")>
            #hiddenFieldTag(name="type", value=params.type)#
        </cfif>
        <cfif isDefined("params.orderby")>
            #hiddenFieldTag(name="orderby", value=params.orderby)#
        </cfif>
        #submitTag("Submit")#
        #endFormTag()#

        #startFormTag(action="handbookReviewOptions", method="get", class="form-search")#
        #selectTag(name="tag", options=tags, valueField="tag", textField="tag", includeBlank="---Filter for tag---", prepend="", append="")#
        #submitTag("Show only this tag")#
        #endFormTag()#
        

    <p>
        <cfif getHandbookReviewSecretary() IS getSetting(name='handbookReviewsecretary2', useSessionSetting=false) and gotRights("office")>    
            #linkTo(text="Use Main Handbook Secretary", action="handbookReviewOptions", params="handbookReviewsecretary=#getSetting(name='handbookReviewsecretary', useSessionSetting=false)#", class="pull-right")#    
        <cfelse>    
            #linkTo(text="Use Alt Handbook Secretary", action="handbookReviewOptions", params="handbookReviewsecretary=#getSetting(name='handbookReviewsecretary2', useSessionSetting=false)#", class="pull-right")#    
        </cfif>
    </p>

    <div class="well">
        <p>Subject: #getSetting('PersonHandbookReviewGreeting')#<p>
        <p>#emailMessage#</p>
    </div>    

    <table id="handbookReviewOptions">
        <tr>
            <th>    
                #linkto(text="Send to #arrayLen(people)# people from #getHandbookReviewSecretary()#", action="emailPeopleForHandbookReview", class="btn", confirm="Are you absolutely certain!!!???", params="lastreviewedBefore=#args.lastreviewedBefore#&go=true")#</br>
            </th>
            <th>
                #linkto(text="Send to these test people from #getHandbookReviewSecretary()#", action="emailPeopleForHandbookReview", class="btn", params="lastreviewedBefore=#args.lastreviewedBefore#&go=false")#
            </th>
        </tr>
        <tr>
            <td>
                Showing #arrayLen(people)# #UCase(args.type)#. Filter for: 
                #linkTo(text="Staff", action="handbookReviewOptions", params="type=staff&lastReviewedBefore=#args.lastReviewedBefore#&orderby=#args.orderby#")# | 
                #linkTo(text="Non-Staff", action="handbookReviewOptions", params="type=non-staff&lastReviewedBefore=#args.lastReviewedBefore#&orderby=#args.orderby#")# | 
                #linkTo(text="Everyone", action="handbookReviewOptions", params="type=everyone&lastReviewedBefore=#args.lastReviewedBefore#&orderby=#args.orderby#")#
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
                <cfloop from="1" to="#arraylen(people)#" index="i">
                     <cfset message = urlEncodedFormat("Greetings!  We are updating information in the online Charis Fellowship handbook which is used each year for the printed handbook. Can you review this for me?  Today?  Be sure to click the 'This information is correct' button when you are finished. Thanks so much! #urlFor(controller="handbook.welcome", action="welcome", params='id=#encrypt(people[i].email,getSetting("passwordkey"),'CFMX_COMPAT','HEX')#', onlyPath=false)#")>
                    <cfset subject = urlEncodedFormat("Please review your personal Charis Fellowship Handbook listing")>
                    #linkto(text="#people[i].selectName#", controller="handbook.welcome", action="welcome", key=encrypt(people[i].email,getSetting("passwordkey"),"CFMX_COMPAT","HEX"), onlyPath=false, params="logoutfirst=true")#
                    #mailTo(
				        name='<i class="icon-envelope"></i>',
				        emailaddress='#people[i].email#?subject=#subject#&body=#message#',
				        alt="e")#
                    </br>
                    #people[i].email#
                    </br>
                    <cfif len(people[i].reviewedAt)>
                    Last Reviewed on #people[i].reviewedAT# by #people[i].reviewedBy#</br>
                    </cfif>
                    <cfif isDefined("people[i].updatedAt") AND len(people[i].updatedAt)>
                    Last Updated on #people[i].updatedAt#</br>
                    </cfif>
                    #linkto(text='<i class="icon-remove"></i>', action="removePersonFromSessionArray", params="item=#i#")#</br>
                    </br>
                </cfloop>
            </td>
            <td valign="top">
                <cfloop from="1" to="#arraylen(testpeople)#" index="i">
                    #linkto(text="#testpeople[i].selectName#", controller="handbook.welcome", action="welcome", key=encrypt(people[i].email,getSetting("passwordkey"),"CFMX_COMPAT","HEX"), onlyPath=false, params="logoutfirst=true")#
                    </br>
                    #testpeople[i].email#
                    </br>
                    Last reviewed on #testpeople[i].reviewedAT# by #testpeople[i].reviewedBy#</br></br>
                </cfloop>
            </td>
        </tr>
    </table>        
    </cfoutput>
</div>