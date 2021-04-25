<template>
  <table id="dataProductsTable" class="table">
    <thead>
    <tr>
      <th>Data Product</th>
      <th>Description</th>
      <th>Notes</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>
        <a href="https://data.neonscience.org/data-products/DP1.00095.001" target="_blank">
          Soil C0<sub>2</sub> concentration</a>
      </td>
      <td>
        Reports the content of CO<sub>2</sub> in soil air from 2cm – 14cm below the surface of the earth.
      </td>
      <td>
        Not only is this data important for the typical carbon cycle, it is also thought to be an important factor
        in release of carbon from melting and refreezing permafrost.
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://data.neonscience.org/data-products/DP1.00041.001" target="_blank">
          Soil temperature</a>
      </td>
      <td>
        Soil temperature is measured up to 3m deep for the Alaskan permafrost
        sites and is important in understanding when permafrost begins to melt.
      </td>
      <td>
        Demonstrates a data product that is very associated with soil CO<sub>2</sub> concentration.
        Changes to soil temperature are known to have sort of association to soil CO<sub>2</sub> concentration,
        especially in these permafrost sites.
      </td>
    </tr>
    <tr>
      <td>
        <a href="https://data.neonscience.org/data-products/DP1.00094.001" target="_blank">
          Soil water content and salinity</a>
      </td>
      <td>
        Water salinity informs when
        water turns to ice or vice versa, and typically more water content is strongly associated with plants and
        organisms in the soil.
      </td>
      <td>
        Measured the same as soil temperature – up to 3m below the surface of the earth.
      </td>
    </tr>
    </tbody>
  </table>
</template>

<script>
export default {
  name: "DataProductsTable"
}
</script>

<style scoped>
table {
  font-size: 0.88em;
}

#dataProductsTable {
  margin-bottom: 0.4rem;
  background-color: inherit;
}

tr:nth-child(2n){
  background-color: var(--chart-background);
}

td {
  word-break: break-word;
}

@media (min-width: 600px) {
  td {
    word-break: normal;
  }
}
</style>