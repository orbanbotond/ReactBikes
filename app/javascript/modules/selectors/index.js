function selectUser(state) {
  return state.session.user;
}

function selectAuthenticated(state) {
  return state.session.authenticated;
}

function selectUsers(state) {
  if(!state.users){ return null; }

  return state.users.collection;
}

function selectBikes(state) {
  if(!state.bikes){ return null; }

  return state.bikes.collection;
}

function selectModels(state) {
  if(!state.models){ return null; }

  return state.models.collection;
}

function selectForm(state, formKey) {
  if(!state.form[formKey]){ return null; }

  return state.form[formKey].values;
}

function selectSearchResults(state) {
  if(!state.searchResults){ return null; }

  return state.searchResults.collection;
}

export {selectSearchResults, selectForm, selectUser, selectAuthenticated, selectModels, selectBikes, selectUsers};
