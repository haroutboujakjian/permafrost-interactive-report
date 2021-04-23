<template>
  <section class="sensorDepthsSection">
    <div class="legendContainer">
      <BaseLegend :legend-data="legendData"></BaseLegend>
    </div>

    <div class="sensorDepthsContainer">
      <div class="depthColumn">
        <h3>BONA</h3>
        <h3>DEJU</h3>
        <h3>HEAL</h3>
      </div>

      <div class="depthColumn" ref="sensorChartContainer">
        <LineChart :plot-data="sensor_depths_split.BONA" x_key="week"
                   :width="width" :height="height - 10" :margin="margin" :colors="color">
        </LineChart>

        <LineChart :plot-data="sensor_depths_split.DEJU" x_key="week"
                   :width="width" :height="height - 10" :margin="margin" :colors="color">
        </LineChart>

        <LineChart :plot-data="sensor_depths_split.HEAL" x_key="week"
                   :width="width" :height="height - 10" :margin="margin" :colors="color">
        </LineChart>
      </div>


    </div>

  </section>

</template>

<script>
import weekly_sensor_depth_data from "@/data/weekly_co2_sensors_depth_3_sites.json"
import LineChart from "@/components/LineChart";
import BaseLegend from "@/components/BaseLegend";

export default {
  name: "SensorDepths",
  components: {
    BaseLegend,
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
    },
    legendData() {
      const verPos = ["503", "502", "501"]
      return this.color.map((color, i) => ({name: verPos[i], color}))
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
      this.width = this.$refs.sensorChartContainer.clientWidth - 1
      this.height = (this.$refs.sensorChartContainer.clientHeight - 1)/ 3
    }
  }
}
</script>

<style scoped>
.sensorDepthsSection {
  height: 90vh;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
}

.sensorDepthsContainer {
  height: calc(100% - 2rem);
  width: 100%;
  display: flex;
  flex-direction: row;
}

.legendContainer {
  height: 2rem;
}

.depthColumn {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.depthColumn:first-child {
  width: 70px;
}

.depthColumn:last-child {
  width: calc(100% - 70px);
}

h3 {
  height: 33%;
  display: flex;
  align-items: center;
}

</style>