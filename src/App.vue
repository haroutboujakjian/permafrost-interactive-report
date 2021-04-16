<template>
  <body id="app">
  <Dashboard></Dashboard>
  </body>
</template>

<script>
import Dashboard from "@/components/Dashboard";

export default {
  name: 'App',
  components: {
    Dashboard
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
