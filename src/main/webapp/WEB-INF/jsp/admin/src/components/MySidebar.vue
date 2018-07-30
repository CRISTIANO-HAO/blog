<template>
    <div id="sidebar">
      <ul>
        <router-link tag="li" to="">
          <span>文章管理</span>
        </router-link>
        <router-link tag="li" to="/user/list">
          <span>用户管理</span>
        </router-link>
      </ul>
    </div>
</template>

<script>
    export default {
        name: "sidebar"
    }
</script>

<style scoped lang="less">
  #sidebar{
    background-color: #222d32;
    color: #ffffff;
    width: 20rem;
    min-height: 100%;
    height: 100%;
    ul{
      text-align: center;
      li{
        line-height: 3.0;
        border-top: 1px solid #3b474c;
        border-bottom: 1px solid #3b474c;
        margin-top: -1px;
        padding-right: 0.5rem;
        color: #859399;
        cursor: pointer;
      }
      li:hover{
        background-color: #2b3438;
        opacity: 0.9;
      }
      li.router-link-active{
        background-color: #2b3438;
      }
    }
  }
</style>
