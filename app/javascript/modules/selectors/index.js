function selectUser(state) {
  return state.session.user;
}

function selectUsers(state) {
  if(!state.users){ return null; }

  return state.users.users;
}

function selectBikes(state) {
  if(!state.bikes){ return null; }

  return state.bikes.bikes;
}

function selectModels(state) {
  if(!state.models){ return null; }

  return state.models.models;
}

export {selectUser, selectModels, selectBikes, selectUsers};
