<template>
  <div id="article-container">
    <sticky style="text-align: right">
      <el-button v-loading="loading_publish" style="margin-left: 10px;" type="success" @click="publishForm">发布
      </el-button>
      <el-button v-loading="loading_draft" type="warning" @click="draftForm">草稿</el-button>
    </sticky>
    <el-form :model="articleForm" :rules="rules" ref="articleForm">
      <el-form-item style="margin-bottom: 40px;" prop="title">
        <MDinput @blur="ifexist" name="'title'" v-model="articleForm.title" required :maxlength="100">
          标题
        </MDinput>
      </el-form-item>
      <el-row>
        <el-col :span="8">
          <el-form-item prop="categories" label-width="60px" label="分类:" class="postInfo-container-item">
            <el-select v-model="articleForm.categories" multiple placeholder="请选择">
              <el-option
                v-for="item in categoryArr"
                :key="item.categoryId"
                :label="item.categoryName"
                :value="item.categoryId">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>

        <el-col :span="8">
          <el-form-item prop="columns" label-width="60px" label="专栏:" class="postInfo-container-item">
            <el-select v-model="articleForm.columns" multiple placeholder="请选择">
              <el-option
                v-for="item in columnArr"
                :key="item.columnId"
                :label="item.columnName"
                :value="item.columnId">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>

        <el-col :span="8">
          <el-form-item prop="tags" label-width="60px" label="标签:" class="postInfo-container-item">
            <el-input
              placeholder="请输入内容"
              v-model="articleForm.tags"
              clearable>
            </el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>

    <div style="margin-bottom: 20px;">
      <el-row>
        <el-col :span="12">
          <h3>文章内容上传</h3>
          <el-upload
            drag
            :limit="1"
            :multiple="false"
            :before-upload="uploadContent"
            :auto-upload="true"
            action="/">
            <i class="el-icon-upload" style="margin-top: 30px;"></i>
            <div class="el-upload__text">
              <div style="margin-bottom: 10px;font-size: 15px;" class="el-upload__tip" slot="tip" ref="uploadArticleContent"></div>
              将文件拖到此处，或
              <el-button style="margin-left: 10px;" size="small" type="success">点击上传到本地</el-button>
            </div>
            <div class="el-upload__tip" slot="tip">只能上传html文件，且不超过5000kb</div>
          </el-upload>
        </el-col>
        <el-col :span="12">
          <h3>文章摘要上传</h3>
          <el-upload
            drag
            :limit="1"
            :multiple="false"
            :before-upload="uploadSummary"
            :auto-upload="true"
            action="/">
            <i class="el-icon-upload" style="margin-top: 30px;"></i>
            <div class="el-upload__text">
              <div style="margin-bottom: 10px;font-size: 15px;" class="el-upload__tip" slot="tip" ref="uploadArticleSummary"></div>
              将文件拖到此处，或
              <el-button style="margin-left: 10px;" size="small" type="success">点击上传到本地</el-button>
            </div>
            <div class="el-upload__tip" slot="tip">只能上传html文件，且不超过5000kb</div>
          </el-upload>
        </el-col>
      </el-row>
    </div>

  </div>
</template>

<script>
  import Sticky from '@/components/Sticky' // 粘性header组件
  import MDinput from '@/components/MDinput';
  import {getArticleAsset , titleIfExist , addArticle , getArticleById , updateArticle} from "@/api/article";

  export default {
    name: "index",
    components: {MDinput, Sticky},
    data() {
      const validateRequire = (rule, value, callback) => {
        if (value === '' || value.length === 0) {
          this.$message({
            message: rule.field + '为必传项',
            type: 'error'
          });
          //callback(null)
        } else {
          callback()
        }
      }
      return {
        article:{},
        articleForm:{
          articleId:"",
          title:"",
          categories: "" ,
          columns: "" ,
          tags:"",
          htmlContent:"",
          summaryHtmlContent:""
        },
        loading_publish: false,
        loading_draft: false,
        exist_flag: false,
        categoryArr: [],
        columnArr: [],
        rules:{
          title: [{ required: true,validator: validateRequire , trigger: 'blur'}],
          tags: [{ required: true,validator: validateRequire , trigger: 'blur'}],
          categories: [{ required: true, message: '请选择文章分类', trigger: 'change' }],
          columns: [{ required: true, message: '请选择所属专栏', trigger: 'change' }]
        }
      }
    },
    computed: {
      tagArr() {
        let val = this.articleForm.tags.trim();
        //匹配不是中文，字母，数字跟空格的字符，也就是匹配标点符号
        let reg = /[^\u4E00-\u9FA5\w\s]+/g;
        if (val) {
          //用分号分隔
          val = val.replace(reg, ";").replace(/;$/, "");
          return val.split(";");
        } else {
          return [];
        }
      },
      submitForm() {
        let data = Object.assign({},this.articleForm);
        data.tags = this.tagArr.map(item => {
          return {tagName: item}
        });
        data.status = 0;
        data.categories = data.categories.map(item => {
          return {categoryId:item};
        });
        data.columns = data.columns.map(item => {
          return {columnId:item};
        });
        return data;
      }
    },
    mounted() {
      this.getArticleById(this.$route.params);
    },
    created(){
      this.getArticleAsset();
    },
    methods: {
      getArticleAsset() {
        getArticleAsset().then(res => {
          let data = res.data.result;
          this.categoryArr = data.categories;
          this.columnArr = data.columns;
        }).catch(err => {
          console.log(err)
        })
      },
      getArticleById(articleId){
        getArticleById(this.$route.params).then(res => {
          this.article = res.data.result;
          this.articleForm.articleId = this.article.articleId;
          this.articleForm.title = this.article.title;
          this.articleForm.categories = this.article.categories.map(item => { return item.categoryId });
          this.articleForm.columns = this.article.columns.map(item => { return item.columnId });
          this.articleForm.tags = this.article.tags.map(item => { return item.tagName }).join("；");
        })
      },
      updateArticle(status){
        this.$refs.articleForm.validate(valid => {
          if (valid === true){
            if (this.exist_flag){
              this.$notify({
                title: '提示',
                message: '已经存在相同的文章标题！',
                type: 'warning',
                duration: 3000
              });
            }else {
              //发布文章或者是草稿文章
              this.submitForm.status = status !== undefined ? status : 0;
              if (status === 0){
                this.loading_draft = true;
              }else if (status === 1){
                this.loading_publish = true;
              }
              updateArticle(this.submitForm).then(res => {
                let data = res.data;
                this.$notify({
                  title: '提示',
                  message: data.result,
                  type: data.status === 200 ? "success" : "warning",
                  duration: 5000
                });
                //提交一次后，若成功，则跳转到首页
                if (data.status === 200){
                  this.$router.push({ name: 'articleList',params:{refresh:true}});
                }else {
                  this.$notify({
                    title: '提示',
                    message: '更新文章失败！',
                    type: 'error',
                    duration: 5000
                  });
                }
                //loading终止
                this.loading_draft = false;
                this.loading_publish = false;
              }).catch(err => {
                //loading终止
                this.loading_draft = false;
                this.loading_publish = false;
                console.log(err);
              });
            }
          }
        });
      },
      publishForm() {
        this.updateArticle(1);
      },
      draftForm() {
        this.updateArticle(0);
      },
      ifexist(){
        if (this.articleForm.title && this.articleForm.title !== this.article.title){
          titleIfExist({title: this.articleForm.title}).then(res => {
            if(res.data.result.ifExist){
              this.$notify({
                title: '提示',
                message: '已经存在相同的文章标题！',
                type: 'warning',
                duration: 3000
              });
              this.exist_flag = true;
            }else {
              this.exist_flag = false;
            }
          }).catch(err => {
            console.log(err)
          });
        }
      },
      uploadContent(file){
        this.beforeUpload(file,"content");
        //阻止直接上传
        return false;
      },
      uploadSummary(file){
        this.beforeUpload(file,"summary");
        //阻止直接上传
        return false;
      },
      beforeUpload(file,key){
        let reader = new FileReader();
        let self = this;
        reader.readAsText(file,"utf8");
        reader.onload = function (){
          //读取完毕后输出结果
          let html = document.createElement("html");
          html.innerHTML = this.result;
          html.getElementsByTagName("footer")[0] && html.getElementsByTagName("footer")[0].remove();
          //获取body下的所有内容
          if (key === "content"){
            self.articleForm.htmlContent = html.getElementsByTagName("body")[0].innerHTML;
            self.$refs.uploadArticleContent.innerHTML = file.name;
          }else if (key === "summary"){
            self.articleForm.summaryHtmlContent = html.getElementsByTagName("body")[0].innerHTML;
            self.$refs.uploadArticleSummary.innerHTML = file.name;
          }
        };
        self.$notify({
          title: '提示',
          message: '本地上传成功！',
          type: 'success',
          duration: 3000
        });
      }
    }
  }
</script>

<style scoped>
  #article-container {
    padding: 40px 45px 20px 50px;
  }
</style>
