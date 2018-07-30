<template>
  <div>
    <section class="content">
      <div class="box">
        <div class="box-header with-border clear">
          <h3 class="box-title">全部文章</h3>
          <div class="addArticle">
            <a href="<%=basePath %>admin/article/articleAdd">
              <i class="fa fa-plus-square" title="添加新博客"></i>
            </a>
          </div>
        </div>
        <div class="box-body">
          <table class="table">
            <thead>
            <tr>
              <th>序号</th>
              <th>状态</th>
              <th>文章标题</th>
              <th>文章标签</th>
              <th>文章编辑</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(article , index) in articles">
              <td>{{index + 1}}</td>
              <td>
                <div v-if="article.status == 0">
                  <i class="fa fa-save"></i><span>草稿</span>
                </div>
                <div v-if="article.status == 1">
                  <i class="fa fa-expeditedssl"></i><span>发布</span>
                </div>
              </td>
              <td>
                <a href="<%=basePath %>admin/article/get/${article.articleId}">{{article.title}}</a>
              </td>
              <td>
                <span v-for="category in article.categories">{{category.categoryName}} ;</span>
              </td>
              <td>
                <div>
                  <a href="<%=basePath %>admin/article/edit/${article.articleId}">
                    <span>编辑</span>
                    <i class="fa fa-eraser"></i>
                  </a>
                </div>
              </td>
            </tr>
            </tbody>
          </table>
          <div v-if="articles.length == 0" class="noContent">It is over !!</div>
        </div>
        <div class="box-footer clear">
          <my-pagination v-bind:url="url" v-bind:page-msg="pageMsg"></my-pagination>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
  import ajax from "../assets/js/ajax";
  import MyPagination from "./MyPagination";
  export default {
    components: {MyPagination},
    name: "article-list",
    data() {
      return {
        articles: [],
        pageMsg:{},
        url:"/admin/article/page/",
        pageIndex: this.$route.params.id ,
        pageSize:2
      }
    },
    mounted() {
      this.getArticles();
    },
    watch:{
      $route(){
        this.pageIndex = this.$route.params.id;
        this.getArticles();
      }
    },
    methods:{
      async getArticles (){
        ajax({
          url: "http://localhost:8080/blog/admin/article/page",
          type:"post",
          data:{
            pageIndex: this.pageIndex ,
            pageSize: this.pageSize
          }
        }).then((res) => {
          this.articles = res.result.articleList;
          this.pageMsg = res.result.pageMsg;
        }).catch((err) => {
          console.log(err)
        })
      }
    }
  }
</script>

<style scoped>
  section.content {
    min-height: 250px;
    padding: 15px;
    margin-right: auto;
    margin-left: auto;
    padding-left: 15px;
    padding-right: 15px;
  }

  .box {
    position: relative;
    border-radius: 3px;
    background: #ffffff;
    border-top: 3px solid #d2d6de;
    margin-bottom: 20px;
    width: 100%;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
  }

  .box .box-header {
    color: #444;
    display: block;
    padding: 10px;
    position: relative;
    border-bottom: 1px solid #f4f4f4;
  }

  .box .box-header .addArticle {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
  }

  .box .box-header .addArticle:hover {
    color: #bbb;
  }

  .box .box-header .addArticle a {
    display: block;
    height: 5px;
    width: 5px;
  }

  .box .box-body {
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
    padding: 10px;
  }

  .box-body > .table {
    width: 100%;
    margin-bottom: 0;
    border: 1px solid #f4f4f4;
    border-collapse: collapse;
  }

  .table tbody > tr > td, .table thead > tr > th {
    border: 1px solid #a59d9d;
    padding: 8px;
    font-weight: 400;
    font-size: 12px;
    vertical-align: middle;
  }

  .table thead > tr > th {
    border: 1px solid #000000;
    padding: 12px;
    font-weight: 800;
    font-size: 14px;
    vertical-align: middle;
    text-align: center;
  }

  .table thead > tr > th:nth-of-type(1) {
    width: 10%;
  }

  .table thead > tr > th:nth-of-type(2) {
    width: 10%;
  }

  .table thead > tr > th:nth-of-type(3) {
    width: 40%;
  }

  .table thead > tr > th:nth-of-type(4) {
    width: 20%;
  }

  .table thead > tr > th:nth-of-type(5) {
    width: 20%;
  }

  .table tbody > tr > td:nth-of-type(1), .table tbody > tr > td:nth-of-type(2) {
    text-align: center;
  }

  .table tbody > tr > td:nth-of-type(2) span {
    padding-left: 5px;
    font-size: 11px;
  }

  .table tbody > tr > td:nth-of-type(2) i.fa-expeditedssl {
    color: #31ba29;
  }

  .table tbody > tr > td:nth-of-type(2) i.fa-save {
    color: #3c8dbc;
  }

  .main-right .box-footer {
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
    border-top: 1px solid #f4f4f4;
    padding: 10px;
    background-color: #fff;
  }



</style>
