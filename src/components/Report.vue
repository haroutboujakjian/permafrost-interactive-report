<template>
  <main>
    <h2>Introduction</h2>
    <ul>
      <li>Permafrost is defined as the sublayer of soil that remains below 0&#730;C for two or more years.</li>
      <li>This layer above permafrost is the normal soil which melts and freezes based on the season.</li>
      <li>Permafrost is slowly melting around the world, releasing trapped CO<sub>2</sub></li>
      <li>Environmental scientists concerned this will accelerate unwanted climate change.</li>
    </ul>

    <figure>
      <img src="../assets/permafrost2.png" alt="Image showing difference in permafrost and active layer">
      <figcaption>
        Figure 1: The active layer freezes and melts based on the season while the permafrost below it stays frozen
        all year long.
      </figcaption>
    </figure>

    <h2>Data</h2>

    <ul>
      <li><a href="https://www.neonscience.org/" target="_blank">National Ecological Observatory Network (NEON)</a>
        is a country-wide, open-source ecological data repository.
      </li>
      <li>Collection sites are located in the tropical forests of Hawaii, on both sides of the Rocky Mountains,
        in the glades of Florida, and (notably for this work) in several permafrost locations in Alaska.
      </li>
      <li>Funded by National Science Foundation to support a “greater understanding of ecological change
        [that] enables forecasting of future ecological conditions” (Battelle, 2021).”
      </li>
    </ul>

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
      <figcaption>Table 1: The three data products used in the analysis.</figcaption>
    </figure>

    <h2>Data Preprocessing</h2>

    <h3>How we selected the BONA, DEJU, and HEAL sites?</h3>
    <ul>
      <li>Soil CO<sub>2</sub> contentration fluctuates at the 5 different National Ecological Observatory Network sites
        in Alaska.
      </li>
      <li>Both the BARR and TOOL sites are in the NEON Tundra Domain (D18), but the TOOL site sits at the border of the
        taiga and tundra lines.
      </li>
      <li>
        BARR is the NEON Program's northernmost field site near Utqiaġvik, Alaska (used to be known as Barrow).
        Described as having "long, cold winters; short, cool summers; persistent wind driven by the nearby Arctic
        Ocean; and extreme seasonal variation."
        <sup><a href="https://www.neonscience.org/field-sites/barr" target="_blank">[1]</a></sup>
      </li>

      <li>
        Climate at the TOOL site is also described similarly as BARR, but the Soil
        CO<sub>2</sub>
        does not have outliers quite as large.
      </li>
      <li>
        On the other hand, the 3 sites clustered in the middle of Alaska, BONA, DEJU, and HEAL, experience the same
        typified cold winters and short summers, but without the extreme seasonal variation of the tundra sites.
      </li>
    </ul>
    <AllSitesMapTimeSeries class="graphicContainer"></AllSitesMapTimeSeries>
    <small>
      Figure 2: Mean CO<sub>2</sub> values for each of the fives in Alaska. Click
      <font-awesome-icon icon="mouse-pointer" class="faIcon"></font-awesome-icon>
      the points on the map to
      select/deselect specific sites from the line chart, and use the start and end date inputs to render different
      time durations.
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
      In the plots below, the interactive slider changes the threshold for <span>residual.for.outlier</span> /
      <span>residual.IQR.for.outlier</span>, which is used in the filter for removing outliers (along with
      <span>finalQF</span>).
      The slider is programmed to go through five values (these were chosen to show large outlier removal):
      <span>500</span>, <span>400</span>, <span>200</span>, <span>16</span>, and <span>3</span>.
      Decreasing the threshold from 500 to 400 shows a large outlier getting removed from BONA in May 2020. However,
      consistently decreasing this threshold doesn't help determine the optimal value. Going from a threshold 200 to 16,
      we see an outlier get removed from February 2018 for the HEAL site, but continuing to decrease it from 16 to 3
      the forced a different outlier back.
    </p>
    <SiteThreshold class="graphicContainer"></SiteThreshold>
    <small>Figure 3:
      Mean CO<sub>2</sub> values for BONA and HEAL sites. The interactive slider changes the threshold for
      <span>residual.for.outlier</span> / <span>residual.IQR.for.outlier</span>, which is used as a filter criteria to
      remove outliers.
    </small>

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

    </p>
    <p>
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

    <h3>Seasonal and Trend Decomposition using LOESS (STL)</h3>
    <p>
      Time series data can exhibit seasonality, trend, or both phenomena. Seasonality is a tendency for an observed
      value, such as soil CO2 concentration, to increase or decrease according to a regular, repeating time period.
      Trend is an overall tendency for an observed value to increase or decrease over time, after seasonality has been
      accounted for. A time series that has been separated into components that represent seasonality, trend, and a
      remainder are said to be “decomposed.”
    </p>

    <p>
      There is an obvious seasonal pattern in the time series, with relatively low values in the winter increasing to
      relatively high values in the summer, after which values decrease again back down to winter levels.
    </p>

    <figure>
      <img src="../assets/STL_BONA.png" alt="STL Decomposition for BONA" loading="lazy">
      <figcaption>Figure 5:</figcaption>
    </figure>

    <p>
      In the first facet of the above plot denoted “raw,” the soil CO2 concentration at the BONA site with missing
      values filled in via interpolation is illustrated. The trend and seasonality inferred by STL are illustrated in
      the “trend” and “season_year” facets, respectively. Finally, the “remainder” facet contains the soil CO2
      concentration values after the trend and seasonal values have been removed.
    </p>

    <p>
      The distinct annual seasonality observed earlier accounts for large changes in soil CO2 concentration level.
      Seasonality accounts for changes of a magnitude of approximately 800 ppm from lows in the winter to highs in the
      summer.
    </p>

    <p>
      Trend is miniscule in comparison, accounting for changes of no more than 55 ppm. Furthermore, trend is not
      consistently increasing or decreasing over the 3 years of observation at the BONA site. It appears to decrease
      slightly, then increase, then decrease slightly again.
    </p>

    <p>
      There is a sizable amount of variation left in the remainder, after removal of trend and seasonal components.
      While the remainders are relatively small in magnitude during winter months, during the summer they can be as
      great as 400 ppm in magnitude, both above or below expectation from seasonality and trend.
    </p>

    <p>
      Trend inferred by STL is even more questionable when examined in light of sensors at different depths.
    </p>

    <figure>
      <img src="../assets/STL_BONA_501.png" alt="STL Decomposition for BONA" loading="lazy">
      <figcaption>Figure 6:</figcaption>
    </figure>

    <p>
      STL decomposition results in a trend for soil CO2 concentration sensors at the BONA site with
      <span>verticalPosition</span> 501 that remains fairly level from mid-2019 to 2021, staying with 5 ppm.
    </p>

    <figure>
      <img src="../assets/STL_BONA_503.png" alt="STL Decomposition for BONA" loading="lazy">
      <figcaption>Figure 7:</figcaption>
    </figure>

    <p>
      However, STL decomposition for soil CO2 concentration sensors at the BONA site with <span>verticalPosition</span>
      503 shows has a sharp decline from mid-2019 to 2021 of 30 ppm.
    </p>

    <p>
      Because the trend identified by STL decomposition is very small in magnitude compared with seasonality and with
      remainder, and the trends are not consistent between sensors even within the same site, it is likely the trends
      are spurious.
    </p>

    <p>
      Soil CO2 concentration at the BONA site may be undergoing a long-term trend. However, such a trend is of small
      enough magnitude that 3 years of data is likely insufficient to detect it, especially considering the relatively
      large seasonal and nonseasonal fluctuations.
    </p>

    <figure>
      <img src="../assets/STL_DEJU.png" alt="STL Decomposition for DEJU" loading="lazy">
      <figcaption>Figure 8:</figcaption>
    </figure>

    <p>
      Decomposition of soil CO2 concentration at the DEJU site is similar to that for the BONA site. There is a distinct
      annual seasonality that accounts for changes with magnitude of approximately 1000 ppm between extremes. Trend
      changes direction from year to year and represents magnitudes of no more than 40 ppm. The remainder highlights
      that the highest spike in soil CO2 concentration that reaches nearly 1500 ppm and occurs in 2018 before the
      expected summer seasonal highs is an outlier. A similarly timed spike occurs in the remainder with magnitude 800
      ppm, while no other spike in the remainder is greater than approximately 400 ppm.
    </p>

    <figure>
      <img src="../assets/STL_HEAL.png" alt="STL Decomposition for HEAL" loading="lazy">
      <figcaption>Figure 9:</figcaption>
    </figure>

    <p>
      Decomposition of soil CO2 concentration at the HEAL site reflects less of a regular annual seasonality than that
      observed at either the BONA or DEJU sites. Rather than there being a single high in the summer and low in the
      winter, there are multiple seasonal peaks, spiking in spring and in fall, with no observable summer increase.
      Seasonality represents magnitudes of approximately 1000 ppm in change at the extremes.
    </p>

    <p>
      Trend as decomposed by STL is much greater at the HEAL site than at either the BONA or DEJU sites, representing
      approximate magnitude of 400 ppm in changes as the extremes. Trend is not monotonic. It is estimated to increase,
      then decrease, then increase again.
    </p>

    <p>
      The magnitude of fluctuations in the remainder is greater for the HEAL site. Remainder spikes are as high as 1400
      ppm and as low as -1000 ppm.
    </p>

    <p>
      Overall, the STL decomposition of soil CO2 concentration at the HEAL site reflects the relative lack of distinct
      seasonality compared with the BONA or DEJU sites.
    </p>

    <h2>Regression Analysis</h2>
    <ACF class="graphicContainer"></ACF>
    <small>Figure 10: </small>

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
import DataProductsTable from "@/components/DataProductsTable";
import ACF from "@/components/ACF";

export default {
  name: "Report",
  components: {
    SiteThreshold,
    AllSitesMapTimeSeries,
    SensorDepths,
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
  padding: 0 3px;
  margin: 0 1px;
  font-size: 0.88rem;
}

ul {
  width: var(--main-width);
  color: #3e3e3e;
  align-self: center;
  font-size: 0.93rem;
}

ul li {
  list-style-type: circle;
  margin: 1rem 1rem;
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
