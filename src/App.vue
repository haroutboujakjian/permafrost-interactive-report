<template>
  <body id="app">
  <Header/>
  <Report/>
  <Footer/>
  </body>
</template>

<script>
import Header from "@/components/Header";
import Report from "@/components/Report";
import Footer from "@/components/Footer";

export default {
  name: 'App',
  components: {
    Footer,
    Header,
    Report
  }
}
</script>

<style>

</style>
