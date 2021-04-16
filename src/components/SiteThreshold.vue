<template>
  <div class="verticalPositionSection">
    <form>
      <label for="threshold">Threshold: {{ thresholdEnum[thresholdValue] }}</label>
      <input type="range" id="threshold" min="1" max="5" step="1" v-model.number="thresholdValue">
    </form>
    <div ref="chartContainer" class="chartContainer">
      <h4>BONA Mean CO<sub>2</sub></h4>
      <LineChart :plot-data="plotDataSites.DEJU" :x_key="'date'"
                 :width="width" :height="height/2 - 50" :margin="margin"
                 :colors="[colors['DEJU']]">
      </LineChart>
      <h4>HEAL Mean CO<sub>2</sub></h4>
      <LineChart :plot-data="plotDataSites.HEAL" :x_key="'date'"
                 :width="width" :height="height/2 - 50" :margin="margin"
                 :colors="[colors['HEAL']]">
      </LineChart>
    </div>
  </div>
</template>

<script>
import co2_by_threshold_two_sensors from '@/data/co2_by_threshold_two_sensor_shortcol.json'
import LineChart from "@/components/LineChart";

export default {
  name: "SiteThreshold",
  components: {
    LineChart
  },
  data() {
    return {
      plotData: co2_by_threshold_two_sensors,
      colors: {"BONA": '#440154FF', "DEJU": '#39568CFF', "HEAL": '#1F968BFF'},
      margin: {top: 20, bottom: 20, left: 50, right: 5},
      thresholdEnum: {1: 500, 2: 400, 3: 200, 4: 16, 5: 3},
      thresholdValue: 1,
      width: null,
      height: null,
    }
  },
  computed: {
    plotDataSites() {
      const threshold = this.thresholdEnum[this.thresholdValue]
      const filteredByThreshold = this.plotData.filter(row => row.thresh === threshold)

      const DEJU = filteredByThreshold
          .filter(row => row.site === "DEJU")
          .map(({date, co2}) => ({date, co2}))
      const HEAL = filteredByThreshold
          .filter(row => row.site === "HEAL")
          .map(({date, co2}) => ({date, co2}))

      return {DEJU, HEAL}
    },

  },
  mounted() {
    this.resizeWidthAndHeight()
    window.addEventListener('resize', this.resizeWidthAndHeight)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.resizeWidthAndHeight)
  },
  methods: {
    resizeWidthAndHeight() {
      this.width = this.$refs.chartContainer.clientWidth - 1
      this.height = this.$refs.chartContainer.clientHeight - 1
    }
  }
}
</script>

<style scoped>
.verticalPositionSection {
  align-self: center;
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 90vh;
}

form {
  display: flex;
  align-items: center;
  height: 10%;
  width: 80%;
  margin: 0 auto;
}

form .siteCheckboxes > label {
  margin: 0 1rem 0 0.3rem;
}

.chartContainer {
  width: 80%;
  height: 100%;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.chartContainer h4 {
  margin-top: 1rem;
  font-weight: bold;
}

</style>