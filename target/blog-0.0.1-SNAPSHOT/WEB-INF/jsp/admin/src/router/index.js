import Vue from 'vue'
import Router from 'vue-router'
import App from "../App"
import Home from '@/components/Home'
import ArticleList from "@/components/ArticleList"
import UserList from "@/components/UserList"

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/admin',
      component: Home,
      children:[
        {
          path:"",
          redirect:"/admin/article"
        },
        {
          path:"article",
          component: ArticleList,
          name:"article",
          redirect:"/admin/article/page/1",
          children:[
            {
              path:"page/:id",
              name:"articleList"
            },
            {
              path:"publish/page/:id",
              name:"articlePublish",
            },
            {
              path:"draft/page/:id",
              name:"articleDraft",
            },
          ]
        },
        {
          path: "user/list",
          component: UserList
        }
      ]
    }
  ]
})
