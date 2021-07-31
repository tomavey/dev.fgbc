<cfoutput>
        <cfif showSubTypesOfCourses()>
            <div class="row">
                <div class="alert text-center">
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
                    <p class="description">#descriptionlong#</p>
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
</cfoutput>
