import request from '@/utils/request'

export function loginByUsername(username, password) {
  const data = {
    username,
    password
  }
  return request({
    url: '/login/login',
    method: 'post',
    data
  })
}

export function logout() {
  return request({
    url: '/login/logout',
    method: 'get'
  })
}

export function getUserInfo(username) {
  return request({
    url: '/user/info',
    method: 'get',
    params: { username }
  })
}

