component extends="controllers.Controller" {

  function getRetreatRegions(){
    retreatRegions = model("Handbookdistrict").findall(order="focusretreat")
  }

  function itemIsSoldOut(required numeric itemId){
    if ( isDefined("params.itemid") ) {
      arguments.itemid = params.itemid
    }
    item = model("Focusitem").findOne(where="id=#arguments.itemid#")
    itemCount = model("Focusitem").findCountSold(arguments.itemid)
    if ( val(item.maxToSell) == 0 || item.maxToSell GT itemCount ) {
      return false
    } else {
      return true
    }
  }

	function showRegsFor(){
		return model("Focusretreat").findAll(where="showregs = 'yes'", order="startAt DESC")
	}

	function showOptionsFor(){
		return model("Focusretreat").findAll(where="active = 'yes'", order="startAt DESC")
  }
  
	function getRetreats() {
		retreats = model("Focusretreat").findAll(where="active='yes' && startAt > now()", order="startAt");
  }
  
  function getFocusContent(required id) {
		if ( isnumeric("arguments.id") ) {
			content = model("Focuscontent").findOne(where="id=#arguments.id#");
		} else {
			content = model("Focuscontent").findOne(where="name='#arguments.id#'");
		}
		if ( isObject(content) ) {
			return content.content;
		} else {
			return "no Content";
		}
	}

}

 
