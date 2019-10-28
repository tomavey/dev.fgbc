<cfset peoplecount = 0>
<cfset organizationcount = 0>

<div class="postbox" id="search">

    			<cfif isDefined("params.tags")>
				<cfoutput>
        			<p>
            			The following tags were set on this list: 
            			<ul>
                			<cfloop list="#params.tags#" index="i">
                    			<li>
        							#linkTo(text=i, controller="handbook.tags", action="show", key=i)#
                    			</li>
                			</cfloop>
            			</ul>
        			</p>
				</cfoutput>	
    			</cfif>

		<cfif isDefined("people") && people.recordcount>		
			<div class="well">
				<h4>People that match "<cfoutput>#params.search#</cfoutput>":</h4></br>
			<ul>	
			<cfoutput query="people" group="id">
					<cfset peoplecount = peoplecount+1>
					<cfset selectnameAlias = "#alias('lname',lname,id)#, #alias('fname',fname,id)# of #city#, #state#">
    			<cfset selectnameAlias = replace(selectnameAlias,"Non","","all")>
    				<li>
    					#linkto(
    							text=scrubSelectName(selectnameAlias),
    							controller="handbook.people",
    							action="show",
    							key=id,
    							class="ajaxclickable tooltip2", 
    							title="Click to show #alias('fname',fname,id)# #alias('lname',lname,id)# in the center panel"
    							)#
    				</li>
			</cfoutput>
			<cfoutput>
					<li>
						Count: #peoplecount#
					</li>	
			</cfoutput>		
			</ul>
			<cfoutput>
    			<p>Tag this list (separate multiple tags with a comma):
    						#startFormTag(controller="handbook.tags", action="search", method="post")#
    						#hiddenFieldTag(name="search", value=params.search)#
    						#hiddenFieldTag(name="type", value="person")#
    						<cfif isdefined("session.auth.username")>
    							#hiddenFieldTag(name="username", value=session.auth.username)#
    						<cfelse>
    							#hiddenFieldTag(name="username", value=session.auth.email)#
    						</cfif>
    						#textFieldTag(name="tags")#
    						#endformTag()#
    			</p>


			</cfoutput>
			</div>
		</cfif>	

	<cftry>		
		<cfif isDefined("organizations") && organizations.recordcount>
			<div class="well">
				<h4>Churches or Organizations that match "<cfoutput>#params.search#</cfoutput>":</h4></br>
			  <ul>
			<cfoutput query="organizations">
			<cfset organizationcount = organizationcount + 1>
				<li>
					#linkTo(
							text=left("#name#: #org_city# #state_mail_abbrev#",35), 
							controller="handbook.organizations",
							action="show", 
							key=id, 
							class="ajaxclickable tooltip2", 
							title="Click to show #name# in the center panel."
							)#
				</li>		
			</cfoutput>
			<cfoutput>
					<li>
						Count: #organizationcount#
					</li>	
			</cfoutput>		
				</ul>
			<cfoutput>
    			<p>Tag this list (separate multiple tags with a comma):
    						#startFormTag(controller="handbook.tags", action="search")#
    						#hiddenFieldTag(name="search", value=params.search)#
    						#hiddenFieldTag(name="type", value="organization")#
    						<cfif isdefined("session.auth.username")>
    							#hiddenFieldTag(name="username", value=session.auth.username)#
    						<cfelse>
    							#hiddenFieldTag(name="username", value=session.auth.email)#
    						</cfif>
    						#textFieldTag(name="tags")#
    						#endformTag()#
    			</p>


			</cfoutput>
			</div>
		</cfif>
	<cfcatch></cfcatch></cftry>

	<cftry>
		<cfif isDefined("tags") && tags.recordcount>
			<div class="well">
			<h4>Tags that match "<cfoutput>#params.search#</cfoutput>":</h4>	</br>
			  <ul>
			<cfset previousTag = "">  
			<cfoutput query="tags" group="tag">
			<cfif tag NEQ previousTag>
				<li>
					#linkTo(
							text=tag, 
							action="show", 
							key=tag
							)#
				</li>
			</cfif>	
			<cfset previousTag = Tab>	
			</cfoutput>
			</div>
		</cfif>		
	<cfcatch></cfcatch></cftry>

<div class="well">
This is an "or" search that lists all record where you search term is in the first name OR last name OR city OR email OR position.
</div>

</div>

