<template>
  <div class="verticalPositionSection">
    <form>
      <label for="threshold">CO<sub>2</sub> IQR Threshold: {{ thresholdValue }}</label>
      <vue-slider id="threshold" v-model="thresholdValue" :data="thresholdData"
                  :marks="true" :absorb="true" :contained="true">
      </vue-slider>
    </form>
    <div ref="chartContainer" class="chartContainer">
      <h4>BONA Mean CO<sub>2</sub></h4>
      <LineChart :plot-data="plotDataSites.DEJU" x_key="date"
                 :width="width" :height="height/2 - 55" :margin="margin"
                 :colors="[colors['DEJU']]" :y-axis-max="6000"
                 xaxis-label="ppm CO2" :y-axis-margins="{dx: -35, dy: 65}"
                 :area-chart="true">
      </LineChart>
      <h4>HEAL Mean CO<sub>2</sub></h4>
      <LineChart :plot-data="plotDataSites.HEAL" x_key="date"
                 :width="width" :height="height/2 - 55" :margin="margin"
                 :colors="[colors['HEAL']]" :y-axis-max="8500"
                 xaxis-label="ppm CO2" :y-axis-margins="{dx: -35, dy: 65}"
                 :area-chart="true">
      </LineChart>
    </div>
  </div>
</template>

<script>
import co2_by_threshold_two_sensors from '@/data/co2_by_threshold_two_sensor_shortcol_ints.json'
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
      margin: {top: 8, bottom: 25, left: 55, right: 5},
      thresholdData: [500, 400, 200, 16, 3],
      thresholdValue: 500,
      width: null,
      height: null,
    }
  },
  computed: {
    plotDataSites() {
      const filteredByThreshold = this.plotData.filter(row => row.thresh === this.thresholdValue)

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
  height: 85vh;
  margin: 3rem 0 2rem;
  padding: 2rem 2rem 1rem;
}

form {
  display: flex;
  flex-direction: column;
  height: 10%;
  width: 100%;
  margin: 0 auto;
}

form > label {
  font-weight: bold;
  color: var(--main-color);
}

form #threshold {
  max-width: 20rem !important;
}

.chartContainer {
  width: 100%;
  height: 100%;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.chartContainer h4 {
  margin-top: 1rem;
  font-weight: bold;
  align-self: flex-end;
  color: var(--main-color)
}

</style>