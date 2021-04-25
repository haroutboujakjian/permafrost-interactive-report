<template>
  <section class="acfGraphicSection">

    <form>
      <input id="radioAdjusted" type="radio" value="adjusted" v-model="chartSelection">
      <label for="radioAdjusted">Adjusted</label>
      <input id="radioFourier" type="radio" value="fourier" v-model="chartSelection">
      <label for="radioFourier">Fourier</label>
      <input id="radioSeasonal" type="radio" value="seasonal" v-model="chartSelection">
      <label for="radioSeasonal">Seasonal</label>
      <input id="radioLM" type="radio" value="lm" v-model="chartSelection">
      <label for="radioLM">LM</label>
    </form>

    <div class="acfChartContainer" ref="acfChartContainer">
      <StackedBarChart :plot-data="plotDataFiltered" x-key="lag" :colors="colors"
                       :width="width" :height="height" :margin="margin" :bar-axis-tick-values="axisTickVals"
                       :enable-tooltip="false" :linear-axis-min="-0.15" :annotations="annotations">
      </StackedBarChart>
    </div>

  </section>
</template>

<script>
import ACFdata from "@/data/acf.json"
import StackedBarChart from "@/components/StackedBarChart";

export default {
  name: "ACF",
  components: {StackedBarChart},
  data() {
    return {
      chartSelection: "adjusted",
      plotdata: ACFdata,
      width: 1000,
      height: 300,
      colors: ["#002480"],
      margin: {top: 20, bottom: 20, left: 50, right: 5},
      axisTickVals: [0, 100, 200, 300],
      annotations: [
        {type: 'line', value: 0.05713, axis: "y", dash: true},
        {type: 'line', value: -0.05713, axis: "y", dash: true},
      ]
    }
  },
  computed: {
    plotDataFiltered() {
      return this.plotdata[this.chartSelection]
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
    resizeWidthAndHeight(){
      this.width = this.$refs.acfChartContainer.clientWidth - 1
      this.height = this.$refs.acfChartContainer.clientHeight - 1
    }
  }

}
</script>

<style scoped>
.acfGraphicSection {
  margin: 0 auto;
  height: 50vh;
}

form {
  height: 50px;
  padding-left: 10px;
  display: flex;
  align-items: center;
}

form label {
  margin-right: 15px;
  margin-left: 4px;
}

.acfChartContainer {
  height: calc(100% - 50px);
  width: 100%;
}
</style>