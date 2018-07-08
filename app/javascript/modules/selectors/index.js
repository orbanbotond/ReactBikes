function selectUser(state) {
  return state.session.user;
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

export {selectUser, selectModels, selectBikes, selectUsers};
