<cfparam name="coursequestions" required="true" type="query">

<cfif !coursequestions.recordcount && isDefined("courseTitle")> 
<h1 class="text-center"><cfoutput>#courseTitle#</cfoutput></h1>
<div class="well text-center">No questions have been posted yet.</div>
</cfif>

<div id="coursequestions" class="container">
    <cfoutput query="coursequestions" group="Conferencecoursetitle">
        <h2>#Conferencecoursetitle#</h2>
        <cfoutput>
            <div class="well question">#question#
                <p class="text-right postedby">Submitted by #mailto(email,fullname)# on #dateFormat(createdAt)# 
                <cfif !hasThisPersonSelectedWorkshops(personid,"cohort",Conferencecourseid)>
                *
                </cfif>
                </p>
            </div>
        </cfoutput>
    </cfoutput>
<p class="text-right">(* = no longer signed up for this cohort)</p>    
</div>