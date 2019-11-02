<cfparam name="params.category" default="">
<cfparam name="rowclass" default = "equalsetting">
<div class="container">
	<cfoutput>
	<h1>Listing #params.category# settings:</h1>

	#includePartial("showFlash")#

		<p>#linkTo(text="New setting", action="new")#</p>
		<p>Categories: <cfloop list="#categories#" index="i">
		#linkto(text=i, controller="admin.settings", action="index", params="category=#i#")# |  
		</cfloop>
		#linkto(text="All", controller="admin.settings", action="index")#
		</p>
	</cfoutput>

	<div class="table table-striped">

		<cftable query="settings" colHeaders="true" HTMLTable="true">
			
						
							<cfcol header="#linkto(text='Name', params="orderby=name")#" text="#name#" />
						
							<cfcol header="#linkto(text='Value', params="orderby=value")#" text="#value#" />
						
							<cfcol header="#linkto(text='Description', params="orderby=description")#" text="#left(description,20)#" />
						
							<cfcol header="#linkto(text='Category', params="orderby=category")#" text="#Category#" />

							<cfcol header="#linkto(text='Created', params="orderby=createdat")#" text="#dateFormat(createdAt)#" />
						
							<cfcol header="#linkto(text='Updated', params="orderby=updatedat")#" text="#dateFormat(updatedAt)#" />
						
				
			<cfcol header="&nbsp;" text="#showTag()#&nbsp;#editTag()#&nbsp;#copyTag(controller='admin.settings')#&nbsp;#deleteTag(class="noajax")#" />
		</cftable>
	</div>
	<cftry>
	<div>
		<cfdump var="#session.settings#" label="Session Settings">
		<cfoutput>
			#linkTo(text="Clear Session Settings", params="clearSessionSettings=1")#
		</cfoutput>
		<cfcatch>
		</cfcatch>
	</div>
	</cftry>

	<cfif isDefined("params.category") && params.category is "Conference">
		<div>
		<p>These are conference settings for someone without elevated rights:</p>
			<cfoutput>
			<cfloop list="#showGetSettingFor#" index="i">
			#i# - #getSetting(trim(i))#<br/>
			</cfloop>
			</cfoutput>
		</div>
	</cfif>

	<cfif gotRights("superadmin") && !len(params.category)>
		<cfoutput>
		<p>
			These are ALL settings used by the app. The "Application.wheels" column are directly from config/setting.cfm. The "getSetting()" column are settings from the getSetting function which will overWrite a setting if it is in the fgbc_metas mySql table. The green highlights show which settings will be overwritten. Click on #imageTag('/add-icon.png')# to add a new setting value. Use the table above to edit a value that is already in the fgbc_metas mySql table.
		</p>	
		<table>
			<tr>
				<th>Variable</th>
				<th>Application.wheels</th>
				<th>getSetting()</th>
			</tr>	
		<cfloop list="#applicationSettingsList#" index="i">
			<cftry>
					<cfif application.wheels[i] NEQ getSetting(i)>
						<cfset rowclass = "notequalsetting">
					<cfelse>	
						<cfset rowclass = "equalsetting">
					</cfif>
				<tr class="#rowclass#">
					<cfif application.wheels[i] NEQ i>
						<td>#i#</td>
					<cfelse>
						<td>#i#&nbsp;#linkto(text='#imageTag('/add-icon.png')#', controller="admin.settings", action="new", params="name=#i#", title="Add a new value")#</td>
					</cfif>		
					<td>#application.wheels[i]#
					<td>#getSetting(i)#</td>
				</tr>
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfloop>
		</table>
		</cfoutput>
	</cfif>

<!---
	<div>
	<cfoutput>
	<p>Actual Application settings:</p>
		<cfoutput query="settings">
		<ul>
			<cftry>
				<li>#name# - #application.wheels[name]#</li>
			<cfcatch>
			</cfcatch>
			</cftry>
		</ul>	
		</cfoutput>
	</cfoutput>	
	</div>
--->	

</div>
