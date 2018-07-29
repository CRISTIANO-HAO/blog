<template>
    <div id="content">
      <router-view></router-view>
    </div>
</template>

<script>
    export default {
        name: "my-content"
    }
</script>

<style scoped>
 *{
   background-color: #ffffff;
 }
  #content{
    height: 100%;
    width: 100%;
  }
</style>
