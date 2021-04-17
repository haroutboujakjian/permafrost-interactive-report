<template>
  <body id="app">
  <Report/>
  </body>
</template>

<script>
import Report from "@/components/Report";

export default {
  name: 'App',
  components: {
    Report
  }
}
</script>

<style>
html, body {
  margin: 0;
  padding: 0;
  min-height: 100vh;
  background-color: #a0cbdb;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
