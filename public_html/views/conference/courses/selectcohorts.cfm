<cfparam name="cohorts" required="true" type="query">
<cfoutput>

<div class="container">

    <cfif getSetting("workshopsRegIsOpen")>

    <cfif showSubTypesOfCourses()>
        <div class="row">
            <div class="alert text-center cohortIntro">
                #getCohortsDescription()#
            </div>
        </div>
    </cfif>

        <div class="row">

        <div class="span8">
        <button href="##" class="clearAllSelections" class="btn btn-block">Clear All Selections</button>

        #startFormTag(action=formaction, class="cohortcheckbox")#

        #hiddenFieldTag(name="personid", value=params.personid)#
        #hiddenFieldTag(name="type", value=params.type)#

            <cfoutput query="cohorts">
                <div class="well eachcohort">
                    <cfif find(id,coursesIdList)>
                    #checkBoxTag(name="cohorts", value=id, checked="true", id="#title#", class="subtype-#subtype#")#
                    <cfelse>
                    #checkBoxTag(name="cohorts", value=id, id="#title#", id="#title#", class="subtype-#subtype#")#
                    </cfif>
                    <p class="disabledMessage-#subtype#"></p>
                    <p>#title#</p>
                            <cfif isDefined("subtype") && showSubTypesOfCourses()>
                                <cfif len(subtype)>
                                <p class="subtype">#subtypes[subtype]#</p>
                                </cfif>
                            </cfif>
                    <div class="cohortdescription">#descriptionlong#</div>
                    <p class="description">#getSubtypeDesc(subtype)#</p>
                </div>
            </cfoutput>

        <div class="cohortmessage alert"></div>

        </div><!---span--->

        <div class="span3">

        <div class="cohortmessage alert">
        <cfif !flashIsEmpty()>
        #flash("toomany")#
        </cfif>
        </div>

        #submitTag(value="Save My Selections", class="btn cohortsubmit")#

        #endFormTag()#

        <a href="##" class="clearAllSelections">Clear All Selections</a>
            

        </div><!---span--->


        </div><!---row--->


    <cfelse>    
        <div class="alert text-center cohortIntro">
            Signup for Cohorts and Workshops is not open yet.  Check back after June 10
        </div>
    </cfif>

</div><!---Container--->

</cfoutput>
