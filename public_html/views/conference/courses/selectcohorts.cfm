<cfparam name="cohorts" required="true" type="query">
<cfoutput>

<div class="container">

    <cfif workshopsRegOpen()>

    <cfif showSubTypesOfCourses()>
        <div class="row">
            <div class="alert text-center cohortIntro">
                #getCohortsDescription()#
            </div>
        </div>
    </cfif>

    #startFormTag(action=formaction, class="cohortcheckbox")#

        <div class="row">

        <div class="span10">
        <a href="##" class="clearAllSelections">Clear All Selections</a>


        #hiddenFieldTag(name="personid", value=params.personid)#
        #hiddenFieldTag(name="type", value=params.type)#
        <cfset previousSubType = "">    
            <cfoutput query="cohorts">
                <cfif subtype NEQ previousSubType>
                    <h2>#subtypes[subtype]#</h2>
                </cfif>
                <div class="well eachcohort">
                    <cfif display is "Full">
                        This event is FULL.
                    <cfelse>    
                        <cfif find(id,coursesIdList)>
                        #checkBoxTag(name="cohorts", value=id, checked="true", id="#title#", class="subtype-#subtype#")#
                        <cfelse>
                        #checkBoxTag(name="cohorts", value=id, id="#title#", id="#title#", class="subtype-#subtype#")#
                        </cfif>
                    </cfif>    
                        <p class="disabledMessage-#subtype#"></p>
                        <p>#title#</p>
                                <cfif isDefined("subtype") && showSubTypesOfCourses()>
                                    <cfif len(subtype)>
                                    <p class="subtype">#subtypes[subtype]#</p>
                                    </cfif>
                                </cfif>
                        <div class="cohortdescription">#descriptionlong#</div>
                        <br/>
                        <p class="description">#getSubtypeDesc(subtype)#</p>
                </div>
                <cfset previousSubType = subtype>
            </cfoutput>

        <div class="cohortmessage alert"></div>

        </div><!---span--->

        </div><!---row--->

        <div>
            <div class="submitCohortsBox">

                <div class="cohortmessage alert">
                <cfif !flashIsEmpty()>
                #flash("toomany")#
                </cfif>
                </div>
    
                #submitTag(value="Save My Selections", class="btn cohortsubmit")#
    
                <a href="##" class="clearAllSelections">Clear All Selections</a>
    
            </div>
    
        </div>

        #endFormTag()#

    <cfelse>    
        <div class="alert text-center cohortIntro">
            Signup for Cohorts and Workshops is not open yet.  Check back after June 10
        </div>
    </cfif>

</div><!---Container--->

</cfoutput>
