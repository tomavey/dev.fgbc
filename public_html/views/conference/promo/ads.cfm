<cfdirectory action="list" directory="C:\Websites\208238wq7\vision2020\images\program_ads\" name="ads">
<ul>
<cfoutput query="ads">

	<li>#linkto(href="/vision2020/images/program_ads/#name#", text=name)#</li>
</cfoutput>
</ul>
