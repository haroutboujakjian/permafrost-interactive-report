<template>
  <figure>
    <svg :width="width" :height="height">
      <path :d="geopath(alaska_border.features[0])"></path>
      <circle v-for="sensor in sensors_points.features"
              :key="sensor.properties.siteID" r="6"
              :cx="projection(sensor.geometry.coordinates)[0]"
              :cy="projection(sensor.geometry.coordinates)[1]"
              :fill="!inactivePoints.includes(sensor.properties.siteID) ? colorScale(sensor.properties.siteID) : 'transparent'"
              :stroke="colorScale(sensor.properties.siteID)"
              @click="$emit('click', sensor.properties.siteID)">
        <title>{{ sensor.properties.siteID }}</title>
      </circle>
    </svg>
  </figure>
</template>

<script>
import alaska_geojson from "@/data/alaska.json"
import sensors_data from "@/data/sensors.json"
import {geoPath, geoAlbersUsa} from "d3-geo";

export default {
  name: "Choropleth",
  props: {
    width: Number,
    height: Number,
    colorScale: Function,
    inactivePoints: {
      type: Array,
      default: function () {
        return []
      }
    }
  },
  data() {
    return {
      alaska_border: alaska_geojson,
      sensors_points: sensors_data,
    }
  },
  computed: {
    projection() {
      return geoAlbersUsa()
          .fitExtent([[-80,10], [this.width, this.height]], this.alaska_border)
    },
    geopath() {
      return geoPath().projection(this.projection)
    }
  }
}
</script>

<style scoped>
path {
  fill: transparent;
  stroke: black;
}

circle {
  cursor: pointer;
  stroke-width: 2;
}
</style>