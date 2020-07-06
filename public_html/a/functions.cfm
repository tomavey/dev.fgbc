<cfset structAppend(form,url)>
<cfset params = form>
<cfif !StructKeyExists(session,"opensections")>
    <cfset session.opensections = structNew()>
</cfif>
<cfif isDefined("params.clearsettings")>
    <cfset StructClear(settings)>
    <cfset StructClear(session.opensections)>
    <cfdump var="#settings#" label="Settings">
    <cfdump var="#session#" label="Session">
    <cfabort>
</cfif>

<cfscript>

    public function isOpen(section){
        if (isDefined("params.clear") || isDefined("params.clearsession")){ session.opensections = {} };
        if (
            isDefined("params[section]") || 
            isDefined("params.openall") || 
            isDefined("params.allopen") || 
            (isDefined("settings[section]") && settings[section]) || 
            (StructKeyExists(session.opensections, section) && session.opensections[section])
            )
        {
        session.opensections[section] = true;    
        return true;
        }
            else
        {
        return false;
        };
    }

    public function scheduleIsOpen(){
        return isOpen("scheduleopen");
        };

    public function subscribeIsOpen(){
        return isOpen("subscribeopen");
    };

    public function featuresIsOpen(){
        return isOpen("featuresopen");
    };

    public function staytunedIsOpen(){
        return isOpen("staytunedopen");
    };

    public function groupRegistrationIsOpen(){
        return isOpen("groupregistrationopen");
    };

    public function registrationIsOpen(){
        return isOpen("registrationopen");
    };

    public function mapIsOpen(){
        return isOpen("mapopen");
    };

    public function speakersIsOpen(){
        return isOpen("speakersOpen");
    };

    public function exhibitorsIsOpen(){
        return isOpen("exhibitorsopen");
    };

    public function parallaxFirstIsOpen(){
        return isOpen("parallaxFirstopen");
    };

    public function parallaxSecondIsOpen(){
        return isOpen("parallaxSecondopen");
    };

    public function parallaxThirdIsOpen(){
        return isOpen("parallaxThirdopen");
    };

    public function whycomeIsOpen(){
        return isOpen("whycomeopen");
    };

    public function pricingIsOpen(){
        return isOpen("pricingopen");
    };

    public function testimonialsIsOpen(){
        return isOpen("testimonialsopen");
    };

    public function galleryIsOpen(){
        return isOpen("galleryopen");
    };

    public function partnersIsOpen(){
        return isOpen("partnersopen");
    };

    public function contactIsOpen(){
        return isOpen("contactopen");
    };

    public function socialIsOpen(){
        return isOpen("socialopen");
    };

    public function cohortsIsOpen(){
        return isOpen("cohortsopen");
    };

    public function childcareIsOpen(){
        return isOpen("childcareopen");
    };

    public function lodgingIsOpen(){
        return isOpen("lodgingOpen");
    };

    public function mobileIsOpen(){
        return isOpen("mobileopen");
    };

    public function twitterIsOpen(){
        return isOpen("twitteropen");
    };

    public function facebookIsOpen(){
        return isOpen("facebookopen");
    };

    public function vimeoIsOpen(){
        return isOpen("vimeoopen");
    };

    public function livestreamIsOpen(){
        return isOpen("livestreamopen");
    };

    public function showSlide2(){
        return isOpen("showSlide2");
    };

    public function showSlide3(){
        return isOpen("showSlide3");
    };

    public function showVideo(){
        return isOpen("showVideo");
    };

    public function getVimeoID(){
        return settings.vimeoId;
    }

    public function getDateLocation(){
        return settings.datesLocation;
    }

    public function getName(a){
        if (isDefined("a")){    
            if (a is "lower" || a is "l") {return lcase(settings.name);}
            if (a is "upper" || a is "u") {return ucase(settings.name);}
            if (a is "cap" || a is "c") {return replaceNoCase(settings.name,left(settings.name, 1 ),uCase(left(settings.name, 1 )));}
        };
        return settings.name;
    }

    public function showDebug(){
        if (isDefined("params.debug") || isOpen("debugon"))
            {return true;}
            else
            {return false;}
    }

    public function getDefaultLodgingInfo() {
        var info =  new Query(datasource="fgbc_main_3", sql="select content from fgbc_content where id = 127").execute().getResult();
        return info.content;
    }

    public function getHostHomesInfo() {
        var info =  new Query(datasource="fgbc_main_3", sql="select content from fgbc_content where id = 130").execute().getResult();
        return info.content;
    }

    public function getDetailedLodgingInfo() {
        var info =  new Query(datasource="fgbc_main_3", sql="select content from fgbc_content where id = 129").execute().getResult();
        return info.content;
    }

    public function getGraceKidsInfo() {
        try {
            var info =  new Query(datasource="fgbc_main_3", sql="select content from fgbc_content where id = 128").execute().getResult();
        } catch(err) {
            info.content = "";
        }
        return info.content;
    }

    public function showVideoInBanner() {
        return settings.showVideoInBanner;
    }

</cfscript>

<cffunction name="queryToJson">
    <cfargument name="Data" type="query" required="yes" />
    <cfset var loc = structNew()>
    <cfset loc.columnnames = data.columnList>
    <cfset loc.jsonObject = "[">
        <cfoutput query="data">
            <cfset loc.thisitem = "{">
            <cfloop list="#loc.columnNames#" index="loc.i">
                <cfset loc.thisdata = '"#escapeString(data[loc.i])#"'>
                <cfset loc.thisitem = loc.thisitem & '"' & lcase(loc.i) & '"' & ":" & loc.thisdata & ",">
            </cfloop>
            <cfset loc.thisitem = left(loc.thisitem,len(loc.thisitem)-1) & "},">
            <cfset loc.jsonObject = loc.jsonObject & loc.thisitem>
        </cfoutput>
        <cfset loc.jsonObject = left(loc.jsonObject,Len(loc.jsonObject)-1)>
        <cfset loc.jsonObject = loc.jsonObject & "]">
        <cfreturn loc.jsonObject>
</cffunction>

<cffunction name="escapeString">
    <cfargument name="string" required="true">
    <cfset var loc = structNew()>
        <cfset loc.return =  arguments.string>
        <cfset loc.return = replace(loc.return,"&quot;", "'", "ALL")>
        <cfset loc.return = REReplace(loc.return,chr(34),"'","ALL")>
        <cfset loc.return = REReplace(loc.return, "\r\n|\n\r|\n|\r", "<br/>", "all")>
        <cfreturn loc.return>
</cffunction>

    <cffunction name="jsonToStruct">
    <cfargument name="jsonString" required="true">
    <cfset var loc=structNew()>
    <cfset loc = arguments>
    <cfset loc.return = structNew()>
<!---<cfdump var="#loc.jsonString#">--->
        <cfset loc.return2 = DeserializeJSON(loc.jsonString)>
        <cfset loc.jsonString = replace(jsonString,'", "','"%%"','all')>
        <cfset loc.jsonString = replace(jsonString,'","','"%%"','all')>
        <cfset loc.jsonString = replace(jsonString,'": "','"&&"','all')>
        <cfset loc.jsonString = replace(jsonString,'":"','"&&"','all')>
        <cfset loc.jsonString = replace(jsonString,"}","","all")>
        <cfset loc.jsonString = replace(jsonString,"{","","all")>
        <cfset loc.jsonString = replace(jsonString,"}","","all")>
        <cfset loc.jsonString = replace(jsonString,"Date ","","all")>
        <cfset loc.jsonString = trim(loc.jsonString)>
        <cfloop list = '#jsonString#' delimiters="%%" index="loc.i">
            <cfset loc.count = 1>
            <cfloop list = '#loc.i#' delimiters="&&" index= "loc.ii">
                <cfset loc.ii = escapeString(removeChars(trim(loc.ii),1,1))>
                <cfset loc.ii = escapeString(removeChars(trim(loc.ii),len(loc.ii),1))>
                <cfif loc.count is 1>
                    <cfset loc.keyy = loc.ii>
                <cfelseif loc.count is 2>
                    <cfset loc.value = loc.ii>
                <cfdump var="#loc.value#" label="value">
                    <cfbreak>
                </cfif>
                <cfset loc.count = loc.count + 1>
            </cfloop>
                <cfset loc.return[loc.keyy] = loc.value>
       </cfloop>
<!---<cfdump var="#loc.return#"><cfabort>--->
       <cfreturn loc.return>
    </cffunction>

<cffunction name="getCohorts">
<cfargument name="types" default="Cohort,Workshop">
<cfset var data = "">
<cfset types = commaListToQuoteList(types)>
<cfquery dataSource="#settings.dsn#" name="data">
    SELECT id, title, descriptionlong, subtype
    FROM equip_courses
    WHERE type IN (#types#)
    AND event="#settings.event#"
    AND deletedAt IS NULL
    ORDER BY title
</cfquery>
<cfreturn data>
</cffunction>

<cfscript>
    function commaListToQuoteList (list) {
        var newList = "";
        newlist = listMap(list, function (e) {
            return '"'&e&'"';
        })
        return newList;
    }
</cfscript>


<cffunction name="getSubtype">
<cfargument name="subtype" required="true" type="string">
    <cfif subtype is "A">
        <cfreturn "Tuesday: 11:00 am 12:30 pm">
    </cfif>
    <cfif subtype is "B">
        <cfreturn "Wednesday: 11:00 am 12:30 pm">
    </cfif>
    <cfif subtype is "C">
        <cfreturn "Thursday: 11:00 am 12:30 pm">
    </cfif>
    <cfif subtype is "D">
        <cfreturn "Tuesday AND Wednesday (2 days): 11:00 am 12:30 pm">
    </cfif>
<cfreturn "NA">
</cffunction>

<cffunction name="getSubtypeDesc">
<cfargument name="subtype" required="true" type="string">
    <cfif subtype is "A">
        <cfreturn "This cohort meets on Tuesday from 11:00 am 12:30 pm">
    </cfif>
    <cfif subtype is "B">
        <cfreturn "This cohort meets on Wednesday from 11:00 am 12:30 pm">
    </cfif>
    <cfif subtype is "C">
        <cfreturn "This cohort meets on Thursday from 11:00 am 12:30 pm">
    </cfif>
<cfreturn "NA">
</cffunction>

<cffunction name="getMeals">
<cfset var data = "">
<cfquery dataSource="#settings.dsn#" name="data">
    SELECT id, buttondescription, description, cost
    FROM equip_options
    WHERE type="Meal" 
    AND event="#settings.event#"
    AND deletedAt IS NULL
    ORDER BY sortorder
</cfquery>
<cfreturn data>
</cffunction>

<cffunction name="getExcursions">
<cfset var data = "">
<cfquery dataSource="#settings.dsn#" name="data">
    SELECT id, buttondescription, description, cost
    FROM equip_options
    WHERE type="Other" 
    AND event="#settings.event#"
    AND deletedAt IS NULL
    ORDER BY sortorder
</cfquery>
<cfreturn data>
</cffunction>

<cffunction name="getSpeakers">
<cfset var data="">
<cfquery dataSource="#settings.dsn#" name="data">
    SELECT id, fname, lname, pedigree, bioweb, email, picThumb
    FROM equip_instructors
    WHERE event="#settings.event#"
    AND tags LIKE "%speaker%"
    AND deletedAt IS NULL
    ORDER BY lname
</cfquery>
<cfreturn data>
</cffunction>

<cffunction name="getStaff">
<cfset var data="">
<cfquery dataSource="#settings.dsn#" name="data">
    SELECT id, fname, lname, pedigree, bioweb, email, picThumb
    FROM equip_instructors
    WHERE event="#settings.event#"
    AND tags LIKE "%staff%"
    AND deletedAt IS NULL
    ORDER BY lname
</cfquery>
<cfreturn data>
</cffunction>

<cffunction name="getActivities">
<cfset var data="">
<cfquery datasource="#settings.dsn#" name="data">
    SELECT description, descriptionprogram, link
    FROM equip_events
    WHERE event="#settings.event#"
    AND category = "excursion"
    AND deletedAt IS NULL
</cfquery>
<cfreturn data>
</cffunction>

<cffunction name="ticketRequired">
    <cfif settings.mealticketsopen>
        <cfreturn "<a href='https://charisfellowship.us/conference/register/selectregtype' target='_new'> Ticket Required</a>">
    <cfelse>
        <cfreturn "Tickets Required (not available yet)">
    </cfif>    
</cffunction>

<cffunction name="cohortsListReady">
    <cfif settings.cohortsListReady>
        <cfreturn "Use the link at the top of this page to see the list or click <a data-remodal-target='modal-cohorts' class='cohortnavlink'>HERE</a>">
    <cfelse>
        <cfreturn "The list of cohorts is coming soon.">
    </cfif>
</cffunction>

<cffunction name="linkToOpenSpeakersModal">
    <cfif settings.speakersOpen>
        <cfreturn "<a data-remodal-target='modal-speakers' class='cohortnavlink submenu'>HERE </a> are our speakers.">
    <cfelse>
        <cfreturn "The list of speakers is coming soon.">
    </cfif>    
</cffunction>

<cffunction name="isMobile">
    <cfif reFindNoCase("android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",CGI.HTTP_USER_AGENT) GT 0 OR reFindNoCase("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw-(n|u)|c55\/|capi|ccwa|cdm-|cell|chtm|cldc|cmd-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc-s|devi|dica|dmob|do(c|p)o|ds(12|-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(-|)|g1 u|g560|gene|gf-5|g-mo|go(.w|od)|gr(ad|un)|haie|hcit|hd-(m|p|t)|hei-|hi(pt|ta)|hp( i|ip)|hs-c|ht(c(-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i-(20|go|ma)|i230|iac( |-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e-|e\/|-[a-w])|libw|lynx|m1-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|-([1-8]|c))|phil|pire|pl(ay|uc)|pn-2|po(ck|rt|se)|prox|psio|pt-g|qa-a|qc(07|12|21|32|60|-[2-7]|i-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h-|oo|p-)|sdk\/|se(c(-|0|1)|47|mc|nd|ri)|sgh-|shar|sie(-|m)|sk-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h-|v-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl-|tdg-|tel(i|m)|tim-|t-mo|to(pl|sh)|ts(70|m-|m3|m5)|tx-9|up(.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(-|2|g)|yas-|your|zeto|zte-",Left(CGI.HTTP_USER_AGENT,4)) GT 0 OR isDefined("params.mobile")>
        <cfreturn true>
    <cfelse>
        <cfreturn false>
    </cfif>
</cffunction>


