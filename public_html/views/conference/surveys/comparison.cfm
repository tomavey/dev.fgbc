<cfoutput>
<table style="margin:0 auto">

<tr>
    <td>&nbsp;</td>
    <td><a href="/vision2020/survey/?showresults&event=cel2008">iGo08</a> in Tampa</td>
    <td><a href="/vision2020/survey/?showresults&event=cel2010"> in Cinci</td>
    <td><a href="/vision2020/survey/?showresults&event=v2020">Vision2020</a> in Wooster</td>
    <td><a href="/vision2020/survey/?showresults&event=v2020w">Vision2020West</a> in Calif</td>
    <td><a href="/vision2020/survey/?showresults&event=v2020w">Vision2020South</a> in Atlanta</td>
    <td><a href="/vision2020/survey/?showresults&event=v2014dc">FellowShift</a> in D.C.</td>
</tr>

<tr>
    <td>Age:</td>
    <cfset avgAge = model("Conferencesurvey").getAvgAge(event="cel2008")>
    <td>#numberformat(avgAge,"99.9")#</td>
    <cfset avgAge = model("Conferencesurvey").getAvgAge(event="cel2010")>
    <td>#numberformat(avgAge,"99.9")#</td>
    <cfset avgAge = model("Conferencesurvey").getAvgAge(event="v2020")>
    <td>#numberformat(avgAge,"99.9")#</td>
    <cfset avgAge = model("Conferencesurvey").getAvgAge(event="v2020w")>
    <td>#numberformat(avgAge,"99.9")#</td>
    <cfset avgAge = model("Conferencesurvey").getAvgAge(event="v2020s")>
    <td>#numberformat(avgAge,"99.9")#</td>
    <cfset avgAge = model("Conferencesurvey").getAvgAge(event="v2014dc")>
    <td>#numberformat(avgAge,"99.9")#</td>
</tr>

<tr>
    <td>Self-pay:</td>
    <cfset thiscount = model("Conferencesurvey").getcount(question="paid",answer="we paid the total cost ourselves",event="cel2008" )>
    <td>#numberformat(thiscount.percent,"99.9")#%</td>
    <cfset thiscount = model("Conferencesurvey").getcount(question="paid",answer="we paid the total cost ourselves",event="cel2010" )>
    <td>#numberformat(thiscount.percent,"99.9")#%</td>
    <cfset thiscount = model("Conferencesurvey").getcount(question="paid",answer="we paid the total cost ourselves",event="v2020" )>
    <td>#numberformat(thiscount.percent,"99.9")#%</td>
    <cfset thiscount = model("Conferencesurvey").getcount(question="paid",answer="we paid the total cost ourselves",event="v2020w" )>
    <td>#numberformat(thiscount.percent,"99.9")#%</td>
    <cfset thiscount = model("Conferencesurvey").getcount(question="paid",answer="we paid the total cost ourselves",event="v2020s" )>
    <td>#numberformat(thiscount.percent,"99.9")#%</td>
    <cfset thiscount = model("Conferencesurvey").getcount(question="paid",answer="we paid the total cost ourselves",event="v2014dc" )>
    <td>#numberformat(thiscount.percent,"99.9")#%</td>
</tr>

<tr>
    <td>Average Cost:</td>
    <cfset averagecost = model("Conferencesurvey").getavg(event="cel2008",question="cost")>
    <td>#dollarformat(averagecost)#</td>
    <cfset averagecost = model("Conferencesurvey").getavg(event="cel2010",question="cost")>
    <td>#dollarformat(averagecost)#</td>
    <cfset averagecost = model("Conferencesurvey").getavg(event="v2020",question="cost")>
    <td>#dollarformat(averagecost)#</td>
    <cfset averagecost = model("Conferencesurvey").getavg(event="v2020w",question="cost")>
    <td>#dollarformat(averagecost)#</td>
    <cfset averagecost = model("Conferencesurvey").getavg(event="v2020s",question="cost")>
    <td>#dollarformat(averagecost)#</td>
    <cfset averagecost = model("Conferencesurvey").getavg(event="v2014dc",question="cost")>
    <td>#dollarformat(averagecost)#</td>
</tr>

<cfset question = "Theme">

<tr>
    <td>Theme:</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2008",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2010",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020w",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020s",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2014dc",question=question)>
    <td>#numberformat(average,"99.9")#</td>
</tr>

<cfset question = "Location">

<tr>
    <td>Location:</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2008",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2010",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020w",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020s",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2014dc",question=question)>
    <td>#numberformat(average,"99.9")#</td>
</tr>

<cfset question = "Speakers">

<tr>
    <td>Speakers:</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2008",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2010",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020w",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020s",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2014dc",question=question)>
    <td>#numberformat(average,"99.9")#</td>
</tr>

<cfset question = "Music">

<tr>
    <td>Worship:</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2008",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2010",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020w",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020s",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2014dc",question=question)>
    <td>#numberformat(average,"99.9")#</td>

</tr>

<cfset question = "Schedule">

<tr>
    <td>Schedule:</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2008",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2010",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020w",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020s",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2014dc",question=question)>
    <td>#numberformat(average,"99.9")#</td>

</tr>

<cfset question = "LUNCHEONS">

<tr>
    <td>Meals:</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2008",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="cel2010",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020w",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2020s",question=question)>
    <td>#numberformat(average,"99.9")#</td>
        <cfset average = model("Conferencesurvey").getavg(event="v2014dc",question=question)>
    <td>#numberformat(average,"99.9")#</td>

</tr>
</table>
</cfoutput>
