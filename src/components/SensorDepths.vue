<template>
  <div class="sensorDepthsSection">

    <div class="sensorDepthsContainer">

      <h3>BONA</h3>
      <div class="chartContainer" ref="chartContainer">
        <LineChart :plot-data="sensor_depths_split.BONA" x_key="week"
                   :width="width" :height="height" :margin="margin" :colors="color">
        </LineChart>
      </div>

      <h3>DEJU</h3>
      <div class="chartContainer">
        <LineChart :plot-data="sensor_depths_split.DEJU" x_key="week"
                   :width="width" :height="height" :margin="margin" :colors="color">
        </LineChart>
      </div>

      <h3>HEAL</h3>
      <div class="chartContainer">
        <LineChart :plot-data="sensor_depths_split.HEAL" x_key="week"
                   :width="width" :height="height" :margin="margin" :colors="color">
        </LineChart>
      </div>

    </div>
  </div>

</template>

<script>
import weekly_sensor_depth_data from "@/data/weekly_co2_sensors_depth_3_sites.json"
import LineChart from "@/components/LineChart";

export default {
  name: "SensorDepths",
  components: {
    LineChart
  },
  data() {
    return {
      sensor_depths: weekly_sensor_depth_data,
      margin: {top: 20, bottom: 20, left: 50, right: 5},
      color: ["#FFC6C6", "#FF5F5F", "#900101"],
      width: null,
      height: null
    }
  },
  computed: {
    sensor_depths_split() {
      const BONA = this.sensor_depths.filter(row => row.siteID === "BONA")
          // eslint-disable-next-line no-unused-vars
          .map(({siteID, ...row}) => row)
      const DEJU = this.sensor_depths.filter(row => row.siteID === "DEJU")
          // eslint-disable-next-line no-unused-vars
          .map(({siteID, ...row}) => row)
      const HEAL = this.sensor_depths.filter(row => row.siteID === "HEAL")
          // eslint-disable-next-line no-unused-vars
          .map(({siteID, ...row}) => row)

      return {BONA, DEJU, HEAL}
    }
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
      this.width = this.$refs.chartContainer.clientWidth
      this.height = this.$refs.chartContainer.clientHeight
    }
  }
}
</script>

<style scoped>
.sensorDepthsSection {
  height: 90vh;
  margin: 0 auto;
}

.sensorDepthsContainer {
  height: 100%;
  display: grid;
  grid-template-columns: 70px minmax(0, 1fr);
  grid-template-rows: repeat(3, minmax(0, 1fr));
  align-items: center;
  justify-items: center;
}
</style>