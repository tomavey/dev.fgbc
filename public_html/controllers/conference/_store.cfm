private void function setStateType(){
  if ( isDefined("params.type") ) {
    setState("type",params.type)
  }
}

private void function setStore(required string storeName){
  session.store[arguments.storeName] = {}
}

private void function setState(required string name, required string value, storeName="conferenceHomes"){
  session.store[arguments.storeName][arguments.name] = arguments.value
}

function getState(required string name, storeName="conferenceHomes") {
  return session.store[arguments.storeName][arguments.name]
}

function clearStore(storeName="conferenceHomes") {
  structClear(session.store)
  writeDump(session);abort;
}

function showSession(){
  writeDump(session);abort;
}


filters(through="setStore", storeName="conferenceHomes")
filters(through="setStateType")
