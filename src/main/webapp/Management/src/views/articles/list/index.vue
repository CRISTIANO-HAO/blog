<template>
  <div>
    <section class="content">
      <div class="box">
        <div class="box-header with-border clear">
          <el-select v-model="status" placeholder="请选择">
            <el-option label="全部文章" value=""></el-option>
            <el-option label="草稿文章" value="0"></el-option>
            <el-option label="发布文章" value="1"></el-option>
          </el-select>
          <div class="addArticle">
            <router-link to="create" tag="a" title="新增文章">
              <svg-icon :icon-class="'add'"></svg-icon>
            </router-link>
          </div>
        </div>
        <div class="box-body">
          <table class="table">
            <thead>
            <tr>
              <th>序号</th>
              <th>状态</th>
              <th>时间</th>
              <th>文章标题</th>
              <th>文章标签</th>
              <th>编辑</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(article , index) in articles">
              <td>{{pageMsg.offsetCount + index + 1}}</td>
              <td>
                <div v-if="article.status == 0">
                  <svg-icon :icon-class="'draft'"></svg-icon><span>草稿</span>
                </div>
                <div v-if="article.status == 1">
                  <svg-icon :icon-class="'publish'"></svg-icon><span>发布</span>
                </div>
              </td>
              <td>{{article.publishTime || article.saveTime}}</td>
              <td>
                <span>{{article.title}}</span>
              </td>
              <td>
                <span v-for="category in article.categories">{{category.categoryName}} ;</span>
              </td>
              <td>
                <div>
                  <router-link :to="'edit/' + article.articleId" tag="a">
                    <el-button type="text">
                      <svg-icon :icon-class="'edit'"></svg-icon><span>编辑</span>
                    </el-button>
                  </router-link>
                  <el-button type="text" @click="deleteArticle(article.articleId)">
                    <svg-icon :icon-class="'delete'"></svg-icon><span>删除</span>
                  </el-button>
                </div>
              </td>
            </tr>
            </tbody>
          </table>
          <div v-if="articles.length == 0" class="noContent">It is over !!</div>
        </div>
        <div class="box-footer clear">
          <el-pagination
            background
            @current-change="handleCurrentChange"
            layout="prev, pager, next"
            :page-count="pageMsg.totalPages"
            pager-count="5"
            :current-page="pageIndex"
          >
          </el-pagination>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
  import { getArticleList , deleteArticleById } from "@/api/article";
  import {getTimeUtil} from "@/utils/timeTranslator";
  export default {
    components: {},
    name: "article-list",
    props:["id"],
    data() {
      return {
        articleList:[],
        pageMsg:{},
        status:"",
        pageIndex: 1 ,
        pageSize:5
      }
    },
    mounted() {
      this.getArticleList();
    },
    computed:{
      articles(){
        return this.articleList.map(article =>{
          article.publishTime = getTimeUtil(article.publishTime);
          article.saveTime = getTimeUtil(article.saveTime);
          return article;
        })
      }
    },
    watch:{
      status(){
        //重置开始页
        this.pageIndex = 1;
        //重新请求文章列表
        this.getArticleList();
      },
      $route(){
        //监控路由是否刷新的信息
        if (this.$route.params.refresh){
          location.reload();
        }
      }
    },
    methods:{
      getArticleList(){
        getArticleList({
          pageIndex: this.pageIndex ,
          pageSize: this.pageSize,
          status: this.status
        }).then(res => {
          this.articleList = res.data.result.articleList;
          this.pageMsg = res.data.result.pageMsg;
        }).catch(err => {
          console.log(err)
        });
      },
      handleCurrentChange(val){
        this.pageIndex = val;
        this.getArticleList();
      },
      deleteArticle(articleId){
        this.$confirm('即将删除该文章, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
          deleteArticleById({articleId: articleId}).then(res => {
            let data = res.data;
            if (data.status === 200){
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
              //重置开始页
              this.pageIndex = 1;
              //重新获取文章列表
              this.getArticleList();
            }else {
              this.$message({
                type: 'error',
                message: '删除失败!'
              });
            }
          }).catch(err => {
            console.log(err)
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });
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
    padding: 20px;
    position: relative;
    border-bottom: 1px solid #f4f4f4;
  }

  .box .box-header .addArticle svg{
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 30px;
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

  .box-footer{
    text-align: right;
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

  .table thead > tr > th:nth-of-type(2) {
    width: 10%;
  }

  .table thead > tr > th:nth-of-type(4) {
    width: 40%;
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

