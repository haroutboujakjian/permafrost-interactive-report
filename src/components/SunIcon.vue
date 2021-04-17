<template>
  <svg width="80" height="80" viewBox="110 110 420 420">
    <defs>
      <radialGradient id="sunGradient" cx="50%" cy="50%" r="50%">
        <stop offset="0%" stop-color="#FFF76B"></stop>
        <stop offset="50%" stop-color="#FFF845"></stop>
        <stop offset="90%" stop-color="#FFDA4E"></stop>
        <stop offset="100%" stop-color="#FB8933"></stop>
      </radialGradient>
    </defs>
    <polygon id="sunPoints"
             points="420,210 375.774,247.857 399.238,301.145 342.926,315.986 340.945,374.184 283.764,363.211
		256.724,414.779 210,380 163.276,414.779 136.236,363.211 79.055,374.184 77.073,315.986 20.762,301.144 44.226,247.858 0,210
		44.226,172.143 20.762,118.855 77.074,104.014 79.055,45.816 136.236,56.789 163.276,5.221 210,40 256.723,5.221 283.764,56.789
		340.945,45.816 342.927,104.014 399.238,118.856 375.774,172.142 	"/>
    <circle cx="210" cy="210" r="140" fill="url(#sunGradient)"/>
  </svg>
</template>

<script>
export default {
  name: "SunIcon"
}
</script>

<style scoped>
#sunPoints {
  fill: #facb2b;
  animation: rotateSun 3s linear;
  transform-origin: 50% 50%;
}

@keyframes rotateSun {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

</style>