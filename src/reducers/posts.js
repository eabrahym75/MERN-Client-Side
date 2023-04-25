// ? What is reducers
// ! Reducer is the function which accepts the state and action
// ! our state is always going to be post so we write it as posts=[] array
// Below code is for reference


import { FETCH_ALL, CREATE, UPDATE, DELETE, LIKE } from '../constants/actionTypes';

export default (posts = [], action) => {
  switch (action.type) {
    case FETCH_ALL:
      return action.payload;
    case LIKE:
      return posts.map((post) => (post._id === action.payload._id ? action.payload : post));
    case CREATE:
      return [...posts, action.payload];
    case UPDATE:
      return posts.map((post) => (post._id === action.payload._id ? action.payload : post));
    case DELETE:
      return posts.filter((post) => post._id !== action.payload);
    default:
      return posts;
  }
};
