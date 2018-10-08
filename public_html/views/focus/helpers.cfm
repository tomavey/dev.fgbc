<cffunction name="getcontent">
<cfargument name="identifier">
<cfset var data = "">

	<cfif val(arguments.identifier) gt 0>
		<cfset data = model('Focuscontent').findOne(arguments.identifier)>
	<cfelse>
		<cfset data = model('Focuscontent').findOne(where="name='#arguments.identifier#'")>
	</cfif>

<cfreturn data.content>
</cffunction>

<cfscript>

<!---Functions used on a registration view page to determine if registration info should display--->

	function showRegistration(optionCount, retreat) {
		if ( isOffice() ) { return true }
		if ( now()-1 LTE retreat.deadline && retreat.regisopen && optionCount ) { return true }
		else { return false }
	}

	function regIsClosed (regisopen) {
		if ( isOffice() ) { return false }
		if ( !regIsOpen) { return true } 
		else { return false }
	}

	function showDeadlineIsPastMessage (deadline) {
		if ( isOffice() ) { return false }
		if ( deadline GTE now() ) { return true }
		else { return false }
	}

	function isOffice () {
		if ( isDefined("params.open") || gotrights("office") ) { return true }
		else { return false }
	}

	function showItem(id) {
		return !itemIsSoldOut(id)
	}



</cfscript>
