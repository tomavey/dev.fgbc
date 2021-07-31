<cfparam name="Attributes.QueryName" default="Query">
<cfparam name="Attributes.DataSource" default="mysqlcf_fgbc_main"> 
<cfparam name="Attributes.ColumnList" default="*">
<cfparam name="Attributes.TableList" default="">
<cfparam name="Attributes.Constraints" default="">
<cfparam name="Attributes.GroupBy" Default="">
<cfparam name="Attributes.OrderBy" Default="#Attributes.ColumnList#">

<!--- Generate the following query syntax --->

<cfquery name="#Attributes.QueryName#" datasource="#Attributes.DataSource#">
    SELECT #Attributes.ColumnList#
    FROM #Attributes.TableList#
    <cfif Attributes.Constraints neq "">
        WHERE #PreserveSingleQuotes(Attributes.Constraints)# 
    </cfif>
    <cfif Attributes.GroupBy neq "">
        GROUP BY #Attributes.GroupBy#
    </cfif>
    <cfif Attributes.OrderBy neq "">
        ORDER BY #Attributes.OrderBy# 
    </cfif>
</cfquery>


<pre>
    <!---------------------------------------------------------------------------------------->
    <font color="red">RENDER THIS QUERY</font>
    <!---------------------------------------------------------------------------------------->
</pre>

<!--- Create a list of columns to loop through --->

<cfset LoopList = "#Attributes.QueryName#.ColumnList">

<table Border="1">
    <tr>
        <cfloop index="ColumnHeadings" list="#Evaluate(LoopList)#">
        <th>
            <cfoutput>#ColumnHeadings#</cfoutput>
        </th>
        </cfloop>
    </tr>

    <cfoutput query="#Attributes.QueryName#">
    <tr bgcolor="#iif(CurrentRow mod 2, DE('efefef'), DE('White'))#">
        <cfloop index="lstLp" list="#Evaluate(LoopList)#">
            <td>#Evaluate(LstLp)#</td>
        </cfloop> 
    </tr>
    </cfoutput>
</table>
<cfif isdefined("url.debug")><cfdump var="#Variables#"></cfif>