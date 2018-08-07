import axios from 'axios'
import { Message } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'

// create an axios instance
const service = axios.create({
  baseURL: process.env.BASE_API,
  timeout: 5000
});

// request interceptor
service.interceptors.request.use(config => {
  // Do something before request is sent
  //config.headers["Content-type"] = "application/x-www-form-urlencoded";
  return config;
}, error => {
  // Do something with request error
  console.log(error) // for debug
  Promise.reject(error)
});

// respone interceptor
service.interceptors.response.use(
  response => response,
  error => {
    console.log('err' + error) // for debug
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  })

export default service
