<cfparam name="instructorname" default="Facilitator">
<cfparam name= "addlinks" default="false">
<cfparam name= "addcomments" default="false">
<cfparam name= "addtracks" default="false">
<cfparam name= "addquestions" default="false">
<cfparam name="hideAddoptions" default="false">
<cfparam name = "stringOfTitles" default="">
<cfif isDefined("params.type") AND params.type is "excursion">
    <cfset instructorname = "Guide">
</cfif>
<cfif isDefined("params.addlinks")>
    <cfset addlinks = true>
</cfif>
<cfif isDefined("params.addtracks")>
    <cfset addtracks = true>
</cfif>
<cfif isDefined("params.addcomments")>
    <cfset addcomments = true>
</cfif>
<cfif isDefined("params.addquestions")>
    <cfset addquestions = true>
</cfif>
<cfif isDefined("params.hideAddoptions")>
    <cfset hideAddoptions = true>
</cfif>
<cfif !hideAddoptions>
<cfoutput>
<p>
    #linkto(text="Add links to titles", action="list", params="type=#params.type#&addlinks=true&print")#<br/>
    #linkto(text="Add tracks and comments", action="list", params="type=#params.type#&addtracks=true&addcomments=true&print")#<br/>
    #linkto(text="Add Questions", action="list", params="type=#params.type#&addquestions=true&print")#<br/>
    #linkto(text="Remove extra's", action="list", params="type=#params.type#&print")#<br/>
    #linkto(text="Hide these choices", action="list", params="type=#params.type#&print&hideAddoptions&addquestions")#<br/>
    #linkto(text="Hide descriptions", action="list", params="type=#params.type#&print&hidedescription")#<br/>
    <cfif !isdefined("params.hidedescription")>
        <hr/>
    </cfif>
</p>
</cfoutput>
</cfif>

<div id="courseslist">
<cfoutput query="courses" group="date">
    <cfif workshopsEventsAreSet()>
        <h1>#dayOfWeekasString(dayOfWeek(date))# (#dateFormat(date,"mmmm/dd")#)</h2>
    <cfif !isdefined("params.hidedescription")>
        <hr/>
    </cfif>    
        <br/><br/>
    </cfif>
    <cfset daycount = 0>
    <cfoutput group="title">
        <cfif title NEQ "empty">
            <cfset daycount = daycount + 1>
            <cfset stringOfTitles = stringOfTitles & ' &bull; ' & title>
            <div class="eachworkshop">
            <cfif addlinks>
                #linkto(text=title, controller="conference.courses", action="view", key=id, onlyPath=false)#<br/>
            <cfelse>
                #title#<br/>
            </cfif>
            <cfif len(subtype)>
            #subtypes[subtype]#<br/>
            </cfif>

           	<cfif workshopsEventsAreSet()>
                #room#<br/>
            </cfif>
                    <cfset instructors = "">
                    <cfset count = 0>
                        <cfoutput>
                                <cfset instructors = instructors & ', ' & #pedigree# & ' ' & #fullname#>
                            <cfif len(fullname)>
                                <cfset count = count +1>
                            </cfif>
                        </cfoutput>
                    <cfset instructors = replace(instructors,", ","","one")>
                    <cfif count EQ 0>

                    <cfelseif count EQ 1>
                        #instructorname#: #instructors#<br/>
                    <cfelse>
                        #pluralize(instructorname)#: #instructors#<br/>
                    </cfif>

            <cfif len(descriptionshort)>
                <cfset description = descriptionshort>
            <cfelse>
                <cfset description = descriptionlong>
            </cfif>

            <cfif !isDefined("params.hidedescription")>
                #description#<br/>
            </cfif>        

            <cfif addComments>
            <br/>
            Comments: #comment#<br/>
            </cfif>
            <cfif addTracks>
            <br/>
            Track: #track#<br/>
            </cfif>

                </div>
            <br/>
                    <p>#commentPublic#</p>
            <cfif addquestions>        
            <div class="questions">
            <p>
                <cfif len(question)>
                    Questions:
                <cfelse>
                    No questions posted yet
                </cfif>    
            <cfif len(question)>
            <ol>       
                <cfoutput>
                <li>#question#</li>
                </cfoutput>
            </ol>  
            </cfif>
            </div>
            </cfif>
            <cfif !isDefined("params.hidedescription")>
            <hr/>
            </cfif>
        </cfif>
    </cfoutput>
    <p style="text-align: right">
        Count on #dayOfWeekasString(dayOfWeek(date))#: #daycount#
    </p>
    <hr/>
</cfoutput>
<p>
    <cfset stringOfTitles = replace(stringOfTitles,'.','','all')>
    <cfset stringOfTitles = replace(stringOfTitles,' &bull; ','','one')>
    <cfoutput>
        #stringOfTitles#
    </cfoutput>
</p>
</div>
