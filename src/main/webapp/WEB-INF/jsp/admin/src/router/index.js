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
      path: '/admin',
      name: 'Home',
      component: Home,
      redirect:"/admin/article/page/1",
      children:[
        {
          path:"article/page/",
          component: ArticleList,
          redirect:"/admin/article/page/1",
        },
        {
          path:"article/page/:id",
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
