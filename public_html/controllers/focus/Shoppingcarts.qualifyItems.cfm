<cfscript>

	private function isItemQualified(itemId,itemIds) {
		var item = model("Focusitem").findOne(where="id=#itemid#")
		var dependenciesNames = item.dependencies
		var dependenciesIds = ''
		var dependenciesIdsArray = []
		if ( !len(dependenciesNames) ) { return true }
		dependenciesIds = listOfItemNamesToIds(item.dependencies)
		dependenciesIdsArray = listToArray(dependenciesIds)
		for ( dependenciesId in dependenciesIdsArray ) {
			if ( find(dependenciesId, itemIds) ) {	return true }
		}
		flashInsert(errorMessage="One or more of your selections does not qualify.<br/> Often this happens because a discount is selected that only applies to a full registration.")
		return false
	}

			public function test_isItemQualified(){
				var testItem = 298
				var testItems = "300,303,298,299"
				var testResult = testItem & " is qualified: " & isItemQualified(testItem,testItems)
				writeOutput(testResult);abort;
			}

	private function qualifiedItems(itemIds) {
		var itemIdsArray = listToArray(itemids)
		var newItemIdsArray = []
		for ( itemId in itemIdsArray ) {
			var item = model("Focusitem").findOne(where="id = #itemid#")
			if ( isItemQualified(itemId,itemIds) ) {
				arrayAppend(newItemIdsArray,itemId)	
			}
		}
		newItemIds = arrayToList(newItemIdsArray)
		return newItemIds
	}

			public function test_qualifiedItems() {
				var test_items  = "300,303,298"
				var test_results = qualifiedItems(test_items)
				writeOutput(test_results);abort;
			}

	private function getItemIdFromItemName(itemName) {
		var item = model("Focusitem").findOne(where="name = '#itemName#'")
		if (isObject(item)) {
			return item.id
		}
	}

	private function listOfItemNamesToIds(itemNames) {
		var newListOfItemIds = ""
		var itemNamesArray = listToArray(itemNames)
		var itemIdsArray = []
		for (itemName in itemNames) {
			var thisItemId = getItemIdFromItemName(itemName)
			arrayAppend(itemIdsArray,thisItemId)
		}
		newListOfItemIds = arrayToList(itemIdsArray)
		return(newListOfItemIds)
	}

</cfscript>

