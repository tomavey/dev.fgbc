<cfparam name="district" type="object">
<cfparam name="formaction" default="update">
<div class="span11">
<cfoutput>
#ckeditor()#

<h2>#district.district#</h2>

#startFormTag(action=formaction, key=params.key)#

#putFormTag()#
			
#includePartial(partial="form")#

#submitTag()#<br/>

#linkTo(text="This information is correct", action="setreview", key=params.key, class="btn")#

#endFormTag()#

</cfoutput>
</div>
