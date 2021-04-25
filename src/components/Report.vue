<template>
  <main>
    <SunIcon/>
    <h1>Carbon Dioxide Soil Analysis in Alaskan Permafrost Sites</h1>

    <h2>What is Permafrost?</h2>
    <p>
      Understanding the melting of permafrost helps in piecing together the larger global climate change issue.
      Permafrost is defined as the sublayer of soil that remains below 0&#730;C for two or more years. Figure 1
      depicts what permafrost commonly looks like, as well as showing the active layer. This layer above permafrost
      is the normal soil which melts and freezes based on the season.
    </p>
    <figure>
      <img src="../assets/permafrost2.png" alt="Image showing difference in permafrost and active layer">
      <figcaption>
        Figure 1: The active layer freezes and melts based on the season while the permafrost below it stays frozen
        all year long.
      </figcaption>
    </figure>

    <h2>Data</h2>

    <p>
      The <a href="https://www.neonscience.org/" target="_blank">National Ecological Observatory Network (NEON)</a>
      is a country-wide, open-source ecological data repository. Data
      collection sites are located in the tropical forests of Hawaii, on both sides of the Rocky Mountains, in the
      glades of Florida, and (notably for this work) in several permafrost locations in Alaska. Sites are either aquatic
      or terrestrial. Sites are also designated as core or relocatable, meaning that they are fixed or move around a
      small area over the 30-year data collection period. As much as possible, these different types of sites are
      located near each other to examine how different types of substrates absorb nutrients and other molecules. The
      primary mission of collecting NEON data is to support a “greater understanding of ecological change and enables
      forecasting of future ecological conditions” (Battelle, 2021).
    </p>

    <h3>Description</h3>
    <p>
      The data repository is broken down into “Data Products”; these are individual (or sometimes groups of) features
      that are collected across several sites. As of April 2021, there are
      <a href="https://data.neonscience.org/data-products/explore" target="_blank">181 data products</a> spanning 81
      sites, though at some of the Alaskan permafrost sites, there are over 100 different data products.
    </p>

    <p>
      All of the data products report findings are aggregated over 1 minute or 30 minutes. When aggregating the values
      from the sensors, they report the <span>minimum</span>, <span>mean</span>, <span>maximum</span>,
      <span>variance</span>, <span>number of observations</span>, <span>expected uncertainty</span>,
      <span>standard error of the mean</span>, and a <span>final quality</span> field over a collection interval. The
      final quality field records if a sensor error occurred over a given interval. Depending on the data product,
      this field can be very important to filter the data on. The <span>start time</span> and <span>end time</span>
      of each aggregation are also recorded.
    </p>

    <h3>Leveraged Data Sets</h3>
    <figure>
      <DataProductsTable/>
      <figcaption>Table 1: Data products used this analysis.</figcaption>
    </figure>


    <h2>Data Preprocessing</h2>

    <h3>How we selected the BONA, DEJU, and HEAL sites?</h3>
    <p>
      Soil CO<sub>2</sub> contentration fluctuates at the 5 different National Ecological Observatory Network sites in
      Alaska. The map shows the locations of each of the sites, and the line chart shows mean CO<sub>2</sub>
      concentration level per week for each site. Observing the line chart, there are some apparent trends when
      comparing soil CO<sub>2</sub> concentration levels at each site.
    </p>
    <p>
      The BARR site is the NEON Program's northernmost field site near Utqiaġvik, Alaska (which used to be known as
      Barrow). It appears to have the highest spikes in soil CO<sub>2</sub>
      concentration. The NEON group describes the climate at the BARR sites as having
      "long, cold winters; short, cool summers; persistent wind driven by the nearby Arctic Ocean; and extreme seasonal
      variation."<sup><a href="https://www.neonscience.org/field-sites/barr" target="_blank">[1]</a></sup>
      This may explain the large spikes in Soil CO<sub>2</sub>.
      Both the BARR and TOOL sites are in the NEON Tundra Domain (D18), but the TOOL site sits at the border of the
      taiga and tundra lines. Climate at the TOOL site is also described similarly as BARR, but the Soil CO<sub>2</sub>
      does not have outliers quite as large.
    </p>
    <p>
      On the other hand, the 3 sites clustered in the middle of Alaska, BONA, DEJU, and HEAL, experience the same
      typified cold winters and short summers, but without the extreme seasonal variation of the tundra sites. Observing
      the line plot, the 3 central sites have similar soil CO<sub>2</sub> concentration trends without the large peaks
      and don't have gaps of missing data as large as the tundra sites.
    </p>
    <AllSitesMapTimeSeries class="graphicContainer"></AllSitesMapTimeSeries>
    <small>
      Figure 2: Click
      <font-awesome-icon icon="mouse-pointer" class="faIcon"></font-awesome-icon>
      the points on the map to select/deselect specific sites from the line chart, and use the start and end date inputs
      to render different time durations.
    </small>

    <h3>Should we always eliminate bad observations?</h3>
    <p>
      The <span>finalQF</span> field in the dataset indicates whether a data product has passed or failed an overall
      assessment of its quality. This is helpful in determining when sensor malfunctions still result in reported data,
      but perhaps the quality of the observation cannot be trusted. More detailed information on understanding the
      overall quality of each NEON instrumented systems data product using <span>finalQF</span> can be found in
      <a href="https://data.neonscience.org/api/v0/documents/NEON.DOC.001113vB"
         rel="noreferrer noopener" target="_blank">NEON.DOC.001113 document</a>
      attached in any data download. In some cases, observations that do not pass the quality check appear very
      different from data that does pass the quality field.
    </p>
    <p>
      In the interactive plots below, we have added a threshold slider to show the effect the finalQF has on the data
      reported from the BONA and HEAL sites. The slider is programmed to go through five values:
      <span>500</span>, <span>400</span>, <span>200</span>, <span>16</span>, and <span>3</span>.
    </p>
    <SiteThreshold class="graphicContainer"></SiteThreshold>
    <small>Figure 3:</small>

    <h3>How do we use various sensor positions?</h3>
    <p>
      All data products report measurements from various positions across the site and at different depths beneath the
      surface of the Earth; these are usually placed at most one meter deep. Different soil depths can provide very
      different results and different positions relative to the sensor tower can provide additional replicates, as they
      do not tend to vary widely. These positions need to be considered when working with the data and are encoded as
      <span>verticalPosition</span> and <span>horizontalPosition</span>.

      There are two important considerations when investigating sensor positions: when a sensor is repositioned and how
      to aggregate observations across different sensors. Because these are detailed and separate considerations, they
      are separated into different subsections.
    </p>

    <h3>What happens when a sensor is repositioned?</h3>
    <p>Fill in</p>

    <h3>How do we aggregate between sensors?</h3>
    <p>
      Many of the data products gather measurements from various positions across the site. Different soil depths can
      provide drastically varying results and different positions relative to the sensor tower can provide additional
      replicates. These positions need to be considered when working with the data and are encoded as verticalPosition
      and horizontalPosition.

      The example below illustrates the resulting differences in measurements from the three verticalPositions in the
      Soil CO2 data product. Deeper sensors tend to report higher and more volatile values of CO2 in the soil, whereas
      shallower sensors produce smaller and less volatile measurements. This makes sense, as values closer to the
      surface of the Earth have more exposure to atmospheric air. Each of the values of sensor depth are aggregated over
      all of the horizontalPositions for a given day. This demonstrates how verticalPosition and horizontalPosition
      should not be aggregated in the same way, specifically that different levels of vertical position report
      meaningfully different measurements, whereas different levels of horizontal position can provide replicates
      relative to one vertical position.
    </p>
    <SensorDepths id="figure4" class="graphicContainer"></SensorDepths>
    <small>Figure 4: </small>

    <h3>How do we re-index to the best time scale?</h3>
    <p>
      The regression and time-series models in the following section require data to reported at a given date or time.
      This analysis focuses on changes to soil CO<sub>2</sub> content over a large time window, so it is rarely
      necessary to perform analysis on the 1-minute or 30-minute intervals that are provided directly from NEON. Thus,
      for much of the analysis this data is re-indexed into a daily rate, which also removes any seasonality derived
      from the day to night cycle. In order to re-index to a single value for the day, a weighted mean of means is
      calculated, which accounts for differences in number of observations seen in the reported measurements. Daily
      minimum and maximum values are also created in the re-indexing, and a pooled variance is calculated, again relying
      on the number of observations reported during each of the default time windows. While the work in this report
      aggregates data to single days, this process could be reindexed to any time resolution. Filtering out observations
      based on issues discussed in the previous paragraph should be done prior to a re-indexing step.
    </p>

    <p>
      Another reason to consider re-indexing is for computational cost. Many of the visualizations in the interactive
      report are designed to react in real-time, and they show insights into how decisions were made in preprocessing
      and modeling. In some multiplot visualizations (Figure 2 and 4), a daily re-indexing can still produce too much
      data to filter and replot in real-time. For these cases, a weekly index is used. Similar issues can occur with
      more complex models, or if more covariates are added to models in the following section.
    </p>

    <h2>Seasonality and Trend Analysis</h2>
    <p>Fill in</p>

    <h2>Regression Analysis</h2>
    <ACF class="graphicContainer"></ACF>

    <h3>Ordinary Least Squares Linear Regression</h3>
    <p>Fill in</p>

    <h3>Regression with ARIMA Errors</h3>
    <p>Fill in</p>

    <h3>Regression with Seasonal ARIMA Errors</h3>
    <p>Fill in</p>

    <h3>Modeling Seasonally Adjusted Data</h3>
    <p>Fill in</p>

    <h2>Conclusions</h2>
    <p>Fill in</p>

  </main>
</template>

<script>
import SiteThreshold from "@/components/SiteThreshold";
import AllSitesMapTimeSeries from "@/components/AllSitesMapTimeSeries";
import SensorDepths from "@/components/SensorDepths";
import SunIcon from "@/components/SunIcon";
import DataProductsTable from "@/components/DataProductsTable";
import ACF from "@/components/ACF";

export default {
  name: "Report",
  components: {
    SiteThreshold,
    AllSitesMapTimeSeries,
    SensorDepths,
    SunIcon,
    DataProductsTable,
    ACF
  },
  data() {
    return {}
  },

}
</script>

<style scoped>
main {
  display: flex;
  flex-direction: column;
  height: 100%;
  padding-bottom: 100px;
  background-color: #a0cbdb;
  --main-color: #002480;
  --main-width: clamp(250px, 68%, 800px);
  --chart-background: #9dc5d5;
  /*--chart-background: #99c4d4;*/
}

h1, h2, h3 {
  font-weight: bold;
  text-align: left;
  color: var(--main-color);
  width: var(--main-width);
  align-self: center;
}

h1 {
  font-size: 1.9rem;
  text-align: center;
  margin: 0.25rem 0 0.6rem;
}

h2 {
  font-size: 1.60rem;
  margin: 2rem 0 0.5rem;
}

h3 {
  font-size: 1.2rem;
  margin: 2rem 0 0.5rem;
}

p {
  width: var(--main-width);
  color: #3e3e3e;
  align-self: center;
  font-size: 0.93rem;
  margin-top: 20px;
}

p > span {
  font-style: italic;
  background-color: #f8f8f8;
  border: solid 1px #ddd;
  border-radius: 3px;
  padding: 0 5px;
  margin: 0 1px;
  font-size: 0.9rem;
}

.faIcon {
  transform: scale(0.9);
}

.graphicContainer {
  background-color: var(--chart-background);
  border-top: solid 1px var(--main-color);
  border-bottom: solid 1px var(--main-color);
  width: 80%;
  box-shadow: none;
  transition: box-shadow 0.5s;
}

.graphicContainer:hover {
  box-shadow: 0 7px 30px -10px rgba(150, 170, 180, 0.8);
  transition: box-shadow 0.3s;
}

small {
  width: var(--main-width);
  margin: -0.6rem auto 0;
  font-size: 0.82rem;
  font-style: italic;
}

figure {
  width: var(--main-width);
  margin: 1rem auto 0;
  display: flex;
  flex-direction: column;
}

figure img {
  width: clamp(450px, 80%, 680px);
  align-self: center;
}

figcaption {
  font-size: 0.82rem;
  font-style: italic;
  margin-top: 0.5rem;
}
</style>