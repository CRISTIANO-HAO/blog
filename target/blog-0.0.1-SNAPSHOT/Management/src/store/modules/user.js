import { loginByUsername, logout, getUserInfo } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'

const user = {
  state: {
    user: '',
    status: '',
    code: '',
    token: getToken(),
    name: '',
    avatar: '',
    introduction: '',
    roles: [],
    setting: {
      articlePlatform: []
    }
  },
  actions:{
    // 用户名登录
    LoginByUsername({ commit }, userInfo) {
      const username = userInfo.username.trim();
      const password = userInfo.password.trim();
      return new Promise((resolve, reject) => {
        loginByUsername(username, password).then(response => {
          console.log(response)
          //const data = response.data;
          // commit('SET_TOKEN', data.token)
          // setToken(response.data.token)
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },
  }
};

export default user;
