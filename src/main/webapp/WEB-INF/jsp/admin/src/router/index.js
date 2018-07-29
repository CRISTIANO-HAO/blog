import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import ArticleList from "@/components/ArticleList"
import UserList from "@/components/UserList"

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home,
      redirect:"/article/list",
      children:[
        {
          path:"article/list",
          component: ArticleList
        },
        {
          path: "user/list",
          component: UserList
        }
      ]
    }
  ]
})
