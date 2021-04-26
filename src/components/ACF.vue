<template>
  <section class="acfGraphicSection">

    <form>
      <div class="inputGroup">
        <input id="radioLM" type="radio" value="lm" v-model="chartSelection">
        <label for="radioLM">Linear</label>
      </div>

      <div class="inputGroup">
        <input id="radioFourier" type="radio" value="fourier" v-model="chartSelection">
        <label for="radioFourier">Fourier</label>
      </div>

      <div class="inputGroup">
        <input id="radioSeasonal" type="radio" value="seasonal" v-model="chartSelection">
        <label for="radioSeasonal">Seasonal</label>
      </div>

      <div class="inputGroup">
        <input id="radioAdjusted" type="radio" value="adjusted" v-model="chartSelection">
        <label for="radioAdjusted">Adjusted</label>
      </div>
    </form>

    <div class="acfChartContainer" ref="acfChartContainer">
      <StackedBarChart :plot-data="plotDataFiltered" x-key="lag" :colors="colors"
                       :width="width" :height="height" :margin="margin" :bar-axis-tick-values="axisTickVals"
                       :linear-axis-min="-0.15" :annotations="annotations"
                       y-axis-label="ACF" :y-axis-margins="{dx: -10, dy: 75}"
                       x-axis-label="Lag">
      </StackedBarChart>
    </div>

    <table class="table">
      <thead>
      <tr>
        <th></th>
        <th>Estimate</th>
        <th>Std. Error</th>
        <th>t-statistic</th>
        <th>p-value</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(values, model) in regressionResultsFiltered" :key="model">
        <td>{{values.type}}</td>
        <td>{{values.Estimate}}</td>
        <td>{{values.err}}</td>
        <td>{{values.tVal}}</td>
        <td>{{values.pVal}}</td>
      </tr>
      </tbody>
    </table>

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
      chartSelection: "lm",
      plotdata: ACFdata,
      width: 1000,
      height: 300,
      colors: ["#002480"],
      margin: {top: 20, bottom: 40, left: 55, right: 20},
      axisTickVals: [0, 100, 200, 300],
      annotations: [
        {type: 'line', value: 0.05713, axis: "y", dash: true},
        {type: 'line', value: -0.05713, axis: "y", dash: true},
      ],
      regressionResults: {
        "lm": [
          {type: "Intercept", Estimate: 6.4031, err: 0.0043800, tVal: 1461.90, pVal: "<0.0001"},
          {type: "Soil Temperature", Estimate: 0.0331, err: 0.0006013, tVal: 55.18, pVal: "<0.0001"},
        ],
        "fourier": [
          {type: "Intercept", Estimate: 0.0000535, err: 0.00150, tVal: 0.0356, pVal: 0.972},
          {type: "Soil Temperature", Estimate: 0.0201, err: 0.00124, tVal: 16.2, pVal: "<0.0001"},
        ],
        "seasonal": [
          {type: "Intercept", Estimate: "N/A", err: "N/A", tVal: "N/A", pVal: "N/A"},
          {type: "Soil Temperature", Estimate: 0.0217, err: 0.00142, tVal: 15.2, pVal: "<0.0001"},
        ],
        "adjusted": [
          {type: "Intercept", Estimate: -0.0000420, err: 0.000731, tVal: -0.0575, pVal: 0.954},
          {type: "Soil Temperature", Estimate: 0.0205, err: 0.00126, tVal: 16.2, pVal: "<0.0001"},
        ],
      }
    }
  },
  computed: {
    plotDataFiltered() {
      return this.plotdata[this.chartSelection]
    },
    regressionResultsFiltered(){
      return this.regressionResults[this.chartSelection]
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
      this.width = this.$refs.acfChartContainer.clientWidth - 1
      this.height = this.$refs.acfChartContainer.clientHeight - 1
    }
  }

}
</script>

<style scoped>
.acfGraphicSection {
  margin: 0 auto 2rem;
  height: 70vh;
}

form {
  height: 50px;
  padding-left: 10px;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}

form .inputGroup {
  display: flex;
  align-items: center;
}

form label {
  margin-right: 15px;
  margin-left: 4px;
}

table {
  height: 120px;
  font-size: 0.88rem;
  margin: 0 auto;
}

.acfChartContainer {
  height: calc(100% - 120px - 50px);
  width: 100%;
}
</style>