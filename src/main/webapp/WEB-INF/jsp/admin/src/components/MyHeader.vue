<template>
    <header>
      <div id="head">博客后台管理系统</div>
      <div id="profie">
        <span>Hello Mr.Hao</span>
        <img src="../assets/image/user.png"/>
      </div>
    </header>
</template>

<script>
    export default {
        name: "my-header"
    }
</script>

<style scoped lang="less">
 *{
   background-color: #f0ad4e;
 }
  header{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 2rem;
    height: 3rem;
    img{
      width: 2.5rem;
      vertical-align: middle;
      border-radius: 50%;
    }
  }
</style>
