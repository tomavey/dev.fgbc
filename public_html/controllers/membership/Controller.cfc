component extends="controllers.Controller"{

	private string function isFellowshipCouncil() {
		if ( isDefined("session.auth.fellowshipcouncil") && session.auth.fellowshipcouncil ) {
			return true;
		} else if ( gotRights("superadmin,office,fellowshipcouncil") ) {
			return true;
		} else if ( isDefined("params.fc") && params.fc ) {
			return true;
		} else {
			return false;
		}
	}

	function isMembershipApp() {
		if ( isDefined("session.membershipapplication.id") && session.membershipapplication.id ) {
			return true;
		} else {
			return false;
		}
	}

}

