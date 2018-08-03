<template>
  <ul id="pagination" class="pagination clear right">
    <li>
      <router-link v-bind:to="url + ($route.params.id == 1 ? 1 : $route.params.id - 1) " tag="a">«
      </router-link>
    </li>
    <li v-if="index !== '...'" v-for="index in pagination">
      <router-link  v-bind:to="url + index" tag="a">{{index}}</router-link>
    </li>
    <li v-else>
      <a>{{index}}</a>
    </li>
    <li>
      <router-link v-bind:to="url+ ($route.params.id == pageMsg.totalPages ? pageMsg.totalPages : Number($route.params.id) + 1) " tag="a">»
      </router-link>
    </li>
  </ul>
</template>

<script>
  export default {
    name: "my-pagination",
    props:["pageMsg","url"],
    data (){
      return {

      }
    },
    computed:{
      pagination(){
        let num = this.pageMsg.totalPages;
        let currentVal = this.pageMsg.pageIndex;
        let paginationArr = [];
        let medium = 7;
        let ellipsis = "...";
        if (num <= medium){
          paginationArr = num;
        }else {
          if (currentVal <= 3){
            for (let i=1;i<= currentVal+1;i++ ){
              paginationArr.push(i)
            }
            paginationArr.push(ellipsis,num);
          }else if(currentVal >= num - 2){
            paginationArr = [1,ellipsis];
            for (let i=currentVal-1;i<= num;i++ ){
              paginationArr.push(i);
            }
          }else {
            paginationArr = [1,ellipsis,currentVal-1,currentVal,currentVal+1,ellipsis,num]
          }
        }
        return paginationArr;
      }
    }
  }
</script>

<style scoped>
  .pagination {
    display: flex;
    justify-content: flex-end;
    border: none;
    margin: 10px;
  }

  .pagination > li {
    display: inline-block;
  }

  .pagination > li:first-child > a {
    border-top-left-radius: 3px;
    border-bottom-left-radius: 3px;
  }

  .pagination > li:last-child > a {
    border-top-right-radius: 3px;
    border-bottom-right-radius: 3px;
  }

  .pagination > li.pageActive > a {
    background: #dddde4 !important;
  }

  .pagination > li > a {
    display: block;
    background: #fafafa;
    color: #666;
    padding: 5px 10px;
    font-size: 12px;
    line-height: 1.5;
    border: 1px solid #dddddd;
    margin-left: -1px;
  }

  .pagination > li > a.router-link-active{
    background-color: #2b3438;
  }
</style>
