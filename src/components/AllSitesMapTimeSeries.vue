<template>
  <div class="AllSiteContainer">
    <form class="dateSelectionForm">
      <label for="startdate">Start Date: </label>
      <input id="startdate" type="date" class="input is-small" required v-model="startDate">
      <label for="enddate">End Date: </label>
      <input id="enddate" type="date" class="input is-small" required v-model="endDate">
      <button type="button" class="button is-small" @click="resetDates()">Reset Dates</button>
    </form>
    <BaseLegend class="legendContainer" :legend-data="siteIDColors"></BaseLegend>

    <div ref="chartsContainer" class="charts">
      <LineChart :width="chartSizes.line.width" :height="chartSizes.line.height" :margin="margin"
                 :plot-data="plotDataFilter" :x_key="'endWeek'" :xaxis-label="'ppm CO2'"
                 :colors="colors" :inactive-lines="inactiveSiteIDs">
      </LineChart>
      <Choropleth v-if="chartSizes.map.width"
                  :width="chartSizes.map.width" :height="chartSizes.map.height" :color-scale="colorScale"
                  :inactive-points="inactiveSiteIDs" @click="addSiteID($event)"
                  class="map">
      </Choropleth>
    </div>
  </div>

</template>

<script>
import LineChart from "@/components/LineChart";
import Choropleth from "@/components/Choropleth";
import BaseLegend from "@/components/BaseLegend";
import {scaleOrdinal} from "d3-scale";
import weekly_mean_of_means from "@/data/weekly_mean_of_means_zero.json";

export default {
  name: "AllSitesMapTimeSeries",
  components: {
    LineChart,
    Choropleth,
    BaseLegend,
  },
  data() {
    return {
      plotDataMap: weekly_mean_of_means,
      width: null,
      height: null,
      chartSizes: {
        map: {width: null, height: null},
        line: {width: null, height: null},
      },
      margin: {top: 20, bottom: 20, left: 50, right: 10},
      colors: [
        '#FDE725FF', '#440154FF', '#39568CFF',
        '#1F968BFF', '#9355d0'
      ],
      startDate: "",
      endDate: "",
      inactiveSiteIDs: [],
    }
  },
  computed: {
    plotDataFilter() {
      return this.plotDataMap
          .filter(item => item.endWeek > this.startDate && item.endWeek < this.endDate)
    },
    siteIDs() {
      return Object.keys(this.plotDataMap[0])
          .filter(e => e !== 'endWeek')
    },
    colorScale() {
      return scaleOrdinal()
          .domain(this.siteIDs)
          .range(this.colors)
    },
    siteIDColors() {
      return this.siteIDs.map(item => ({name: item, color: this.colorScale(item)}))
    }
  },
  created() {
    this.resetDates()
  },
  mounted() {
    this.resizeWidth()
    window.addEventListener('resize', this.resizeWidth)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.resizeWidth)
  },
  methods: {
    resetDates() {
      this.startDate = this.plotDataMap[0].endWeek
      this.endDate = this.plotDataMap[this.plotDataMap.length - 1].endWeek
    },
    resizeWidth() {
      const width = this.$refs.chartsContainer.clientWidth - 1
      const height = this.$refs.chartsContainer.clientHeight - 1

      if (window.innerWidth < 800) {
        this.chartSizes.map.width = width - 20
        this.chartSizes.line.width = width - 10

        this.chartSizes.map.height = height / 2
        this.chartSizes.line.height = height / 2
      } else {
        this.chartSizes.map.width = width / 2 - 20
        this.chartSizes.line.width = width / 2 + 20

        this.chartSizes.map.height = height - 10
        this.chartSizes.line.height = height
      }
    },
    addSiteID(siteID) {
      if (this.inactiveSiteIDs.includes(siteID)) {
        this.inactiveSiteIDs = this.inactiveSiteIDs.filter(e => e !== siteID)
      } else {
        this.inactiveSiteIDs.push(siteID)
      }
    }
  }
}
</script>

<style scoped>

.AllSiteContainer {
  margin: 2rem auto;
  padding: 3rem 1rem;
}

.dateSelectionForm {
  margin-bottom: 1rem;
  padding: 0.1rem 0 5px;
  display: flex;
  align-items: center;
  justify-content: center;
  align-self: center;
}

.dateSelectionForm > input {
  width: clamp(120px, 15%, 140px);
  height: 90%;
  margin: 0 15px 0 8px;
}

.dateSelectionForm > h2 {
  font-weight: bold;
  font-size: 1.5rem;
}

.dateSelectionForm > label {
  font-weight: bold;
  font-size: 0.9rem;
  color: var(--main-color);
}

.dateSelectionForm button {
  width: 90px;
}

.legendContainer {
  align-self: center;
}

.charts {
  align-self: center;
  display: flex;
  height: 450px;
}

@media (max-width: 800px) {
  .charts {
    flex-direction: column;
  }

  .map {
    margin-top: 1rem;
  }
}

</style>