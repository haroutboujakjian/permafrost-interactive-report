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
      <td>Temperature of the soil at various depth below the soil surface from 2 cm up to 200 cm.</td>
      <td>A data product that is very associated with soil CO<sub>2</sub> concentration.</td>
    </tr>
    <tr>
      <td>
        <a href="https://data.neonscience.org/data-products/DP1.00094.001" target="_blank">
          Soil water content and salinity</a>
      </td>
      <td>
        Soil volumetric water content and an index of salinity at various depth below the soil surface from 2 cm up to
        200 cm.
      </td>
      <td>

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


</style>