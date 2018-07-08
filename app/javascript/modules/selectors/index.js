function selectUser(state) {
  return state.session.user;
}

function selectBikes(state) {
  if(!state.bikes){ return null; }

  return state.bikes.bikes;
}

function selectModels(state) {
  if(!state.models){ return null; }

  return state.models.models;
}

export {selectUser, selectModels, selectBikes};
