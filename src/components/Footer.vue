<template>
  <footer>
    <small>
      Find source code and data on
      <a href="https://github.com/haroutboujakjian/permafrost-interactive-report"
         target="_blank" rel="noreferrer noopener">
        <GithubIcon></GithubIcon>
      </a>
    </small>
  </footer>
</template>

<script>
import GithubIcon from "@/components/GithubIcon";
export default {
  name: "Footer",
  components: {GithubIcon}
}
</script>

<style scoped>
footer{
  width: var(--main-width);
  margin: 0 auto 5rem;
}

a {
  color: #323232;
}

a:hover {
  color: black;
}
</style>