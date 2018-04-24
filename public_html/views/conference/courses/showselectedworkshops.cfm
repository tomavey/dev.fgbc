<cfparam name="params.personid" default=0>
<div id='selectworkshops' class="container">
<cfif isObject(person)>
    <cfoutput>
        <h2 class="text-center">#getEventAsText()# #capitalize(pluralize(params.type))# selected for #person.fname#</h2>
    </cfoutput>
</cfif>


<cfif ! flashIsEmpty()>
    <cfoutput>
        <p class="well">
            #flash("success")#
        </p>
    </cfoutput>
</cfif>

<cfif workshops.recordcount>

<cfoutput query="workshops" group="eventDate">

<!---
<h2>#eventDay# - #eventDate#</h2>
--->
    <cfoutput>
        <div class="well">
            <h3 class="title">#title#</h3>

            <cfif isDefined("subtype") && showSubTypesOfCourses()>
                <p class="subtype">#subtypes[subtype]#</p>
            </cfif>

            <p class="description">
                <cfif len(descriptionShort)>#descriptionShort#<cfelse>#descriptionLong#</cfif>
            </p> 
            <p>   
            #linkTo(text="Post a question", controller="conference.coursequestions", action="new", params="courseid=#Conferencecourseid#&personid=#params.personid#", onlyPath=false, class="btn")# 
            #linkTo(text="View all the questions for #title#", controller="conference.coursequestions", action="list", params="courseid=#Conferencecourseid#", onlyPath=false, class="btn", target="_blank")#
            </p>
        </div>
    </cfoutput>

</cfoutput>

<cfoutput>

    <cfif isDefined("params.personid")>
    #linkTo(text="Edit this list", controller="conference.courses", action="selectCohorts", params="type=cohort&personid=#params.personid#", class="btn btn-block", onlyPath="false")#
    </cfif>

</cfoutput>


<cfelse>
    <cfoutput>
        <p class="alert text-center">
            No cohorts have been selected for #person.fname#.
        </p>
        #linkTo(text="Select Cohorts for #person.fname#", controller="conference.courses", action="selectCohorts", personid=#params.personid#, params="type=cohort&personid=#person.id#", class="btn btn-block btn-primary btn-large", onlyPath="false")#
    </cfoutput>
</cfif>

<cfoutput>

    <div id="sendworkshopsemail" class="text-center">
    <p>Check your inbox.  You may have already received email confirmation of these choices.</p>
    <div class="text-center">
        #StartFormTag(action="sendSelectedWorkshops", class="form")#
        <fieldset>
            <cfif isValid("email",person.email)>
                #textFieldTag(name="email", value=person.email, label="Email this list to: ", placeholder="email address", class="input-large")#
            <cfelse>
                #textFieldTag(name="email", value=person.email, label="Email this list to: ", placeholder="email address", class="input-large")#
            </cfif>
            #hiddenFieldTag(name="personid", value=params.personid)#
            #hiddenFieldTag(name="type", value=params.type)#
            #submitTag(value="Send this list.", class="btn")#
        </fieldset>
        #endFormTag()#
    </div>
    </div>
    <div>&nbsp;</div>

</cfoutput>
</div>