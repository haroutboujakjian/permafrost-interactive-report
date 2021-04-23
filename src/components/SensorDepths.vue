<template>
  <section class="sensorDepthsSection">
    <div class="legendContainer">
      <BaseLegend :legend-data="legendData"></BaseLegend>
    </div>

    <div class="sensorDepthsContainer">
      <div class="depthColumn">
        <GrassSoil :inactive-sensors="inactiveSensorDepths"
                   @click="addOrRemoveSensorFromInactive($event)">
        </GrassSoil>
      </div>

      <div class="depthColumn" ref="sensorChartContainer">
        <h4>BONA</h4>
        <LineChart :plot-data="sensor_depths_split.BONA" x_key="week"
                   :width="width" :height="height - 35" :margin="margin" :colors="color"
                   xaxis-label="ppm CO2" :inactive-lines="inactiveSensorDepths">
        </LineChart>

        <h4>DEJU</h4>
        <LineChart :plot-data="sensor_depths_split.DEJU" x_key="week"
                   :width="width" :height="height - 35" :margin="margin" :colors="color"
                   xaxis-label="ppm CO2" :inactive-lines="inactiveSensorDepths">
        </LineChart>

        <h4>HEAL</h4>
        <LineChart :plot-data="sensor_depths_split.HEAL" x_key="week"
                   :width="width" :height="height - 35" :margin="margin" :colors="color"
                   xaxis-label="ppm CO2" :inactive-lines="inactiveSensorDepths">
        </LineChart>
      </div>


    </div>

  </section>

</template>

<script>
import weekly_sensor_depth_data from "@/data/weekly_co2_sensors_depth_3_sites.json"
import LineChart from "@/components/LineChart";
import BaseLegend from "@/components/BaseLegend";
import GrassSoil from "@/components/GrassSoil";

export default {
  name: "SensorDepths",
  components: {
    BaseLegend,
    LineChart,
    GrassSoil
  },
  data() {
    return {
      sensor_depths: weekly_sensor_depth_data,
      margin: {top: 15, bottom: 25, left: 50, right: 20},
      color: ["#FFC6C6", "#FF5F5F", "#900101"],
      width: null,
      height: null,
      inactiveSensorDepths: []
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
      const verPos = ["501", "502", "503"]
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
      this.height = (this.$refs.sensorChartContainer.clientHeight - 1) / 3
    },
    addOrRemoveSensorFromInactive(sensor_id) {
      if (this.inactiveSensorDepths.includes(sensor_id)) {
        this.inactiveSensorDepths = this.inactiveSensorDepths
            .filter(sensor => sensor !== sensor_id)
      } else {
        this.inactiveSensorDepths.push(sensor_id)
      }
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
  width: 230px;
}

.depthColumn:last-child {
  width: calc(100% - 230px);
}

h4 {
  height: 33%;
  display: flex;
  align-items: center;
}

</style>