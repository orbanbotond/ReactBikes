function selectUser(state) {
  return state.session.user;
}

function selectBikes(state) {
  return state.session.bikes;
}

function selectModels(state) {
  return state.session.models;
}

export {selectUser, selectModels, selectBikes};
