<template>
  <div class="home">
    <my-header></my-header>
    <div id="container">
      <my-sidebar></my-sidebar>
      <my-content></my-content>
    </div>
  </div>
</template>

<script>
  import MyHeader from "./MyHeader";
  import MySidebar from "./MySidebar";
  import MyContent from "./MyContent";
export default {
  components: {
    MyContent,
    MyHeader,
    MySidebar},
  name: 'Home',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
  #app,.home{
    min-height: 100%;
  }
 #container{
   display: flex;
   justify-content: space-between;
   align-items: flex-start;
   position: absolute;
   width: 100%;
   height: 100%;
   padding-top: 3rem;
 }
</style>
