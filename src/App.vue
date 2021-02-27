<template>
  <div id="app">
    <Header id=header />
    <b-container id="wrapper">
      <router-view/>
    </b-container>
  </div>
</template>

<script type="text/javascript">
  import Header from '@/components/Header'

  export default{
    components:{
      Header,
    }
  }
</script>

<style>
#wrapper{
  margin-top: 50px;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
