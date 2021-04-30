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

    <h3>Description</h3>
    <ul>
      <li>The data repository is broken down into “Data Products”; these are individual (or sometimes groups of)
        features that are collected across several sites.
      </li>
      <li>As of April 2021, there are
        <a href="https://data.neonscience.org/data-products/explore" target="_blank">181 data products</a> spanning 81
        sites.
      </li>
      <li>All of the data products report findings are aggregated over 1 minute or 30 minutes.</li>
      <li>
        Values report are <span>minimum</span>, <span>mean</span>, <span>maximum</span>,
        <span>variance</span>, <span>number of observations</span>, <span>expected uncertainty</span>,
        <span>standard error of the mean</span>, <span>finalQF</span>, <span>start time</span> and
        <span>end time</span> of each aggregation are also recorded.
      </li>
    </ul>


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
        Ocean; and extreme seasonal variation" (NEON, Utqiaġvik, 2021).
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
    <ul>
      <li><span>finalQF</span> field indicates whether a measurement has passed or failed an overall quality assessment.
      </li>
      <li>Measurements that fail a quality assessment can still be useful in many circumstances but are sometimes
        unusable
        (see figures 3 and 4).
      </li>
      <li>Detailed information about quality assessments can be found in
        <a href="https://data.neonscience.org/api/v0/documents/NEON.DOC.001113vB"
           rel="noreferrer noopener" target="_blank">NEON.DOC.001113 document</a>
        (attached to any data product download).
      </li>
    </ul>

    <figure>
      <img src="../assets/finalqfgood.png" alt="Reasonable Soil CO<sub>2</sub> values with quality check failures."
           loading="lazy">
      <figcaption>Figure 3: Soil CO<sub>2</sub> Concentration at site HEAL in June of 2018. Most of the plot shows that
        the sensor raised a
        quality flag (green background), yet the data still appear reasonable. (NEON, Soil CO<sub>2</sub>, 2021).
      </figcaption>
    </figure>

    <figure>
      <img src="../assets/finalqfbad.png" alt="Unreasonable Soil temperature values with quality check failures."
           loading="lazy">
      <figcaption>Figure 4: Soil temperature at site DEJU from 2017 to 2021. A span of a few months in late 2018 fails a
        quality check and reported values that are clearly unreasonable. (NEON, Soil temperature, 2021).
      </figcaption>
    </figure>

    <ul>
      <li>Figure 5 shows another way to filter outlier/bad values by large ratios of residual to IQR values.</li>
      <li>Large values do not eliminate large outliers while small values exclude reasonable measurements.</li>
    </ul>

    <SiteThreshold class="graphicContainer"></SiteThreshold>
    <small>Figure 5:
      Mean CO<sub>2</sub> values for BONA and HEAL sites. The interactive slider changes the threshold for
      <span>residual.for.outlier</span> / <span>residual.IQR.for.outlier</span>, which is used as a filter criteria to
      remove outliers. The slider is programmed to go through five values (these were chosen to show large outlier
      removal):
      <span>500</span>, <span>400</span>, <span>200</span>, <span>16</span>, and <span>3</span>.
    </small>

    <h3>What happens when a sensor is repositioned?</h3>
    <ul>
      <li>Sensors are repositioned because of failures or incorrect placements.</li>
      <li>Sometimes sensors are repositioned at slightly different depths, resulting in sharp changes in the data
        values.
      </li>
    </ul>

    <figure>
      <img src="../assets/sensor_reposition.png" alt="Unreasonable Soil temperature values with quality check failures."
           loading="lazy">
      <figcaption>Figure 6: Sensor repositionings, represented with vertical red lines, can lead to sharp changes in
        soil temperature
        across all reading depths. The rows of this plot represent different sensor reading depths, where lower rows
        represent deeper sensor placements.
      </figcaption>
    </figure>

    <h3>How do we aggregate between sensors?</h3>
    <ul>
      <li>Vertical sensor positions denote how deep a sensor is into the ground, and report differing results (see
        figure 7).
      </li>
      <li>Horizontal sensor positions denote location along the surface relative to the sensor tower (replicates).</li>
    </ul>

    <SensorDepths id="figure7" class="graphicContainer"></SensorDepths>
    <small>Figure 7: Soil CO<sub>2</sub> concentration at different sensor depths, aggregated across horizontal
      positions. Deeper sensors exhibit
      larger and more volatile values where as sensors as shallower depths are smaller and less volatile.</small>

    <h3>How do we re-index to the best time scale?</h3>
    <ul>
      <li>Investigating for trends over years. 30-minute measurements are too small.</li>
      <li>Start with 30-minute average measurements (comes with number of points).</li>
      <li>Compute weighted mean and pooled variance for a single day.</li>
    </ul>

    <h2>Seasonality and Trend Analysis</h2>

    <h3>Seasonal and Trend Decomposition using LOESS (STL)</h3>
    <p>
      Time series data can exhibit seasonality, trend, or both phenomena. Seasonality is a tendency for an observed
      value, such as soil CO<sub>2</sub> concentration, to increase or decrease according to a regular, repeating time
      period.
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
      <figcaption>Figure 8:</figcaption>
    </figure>

    <p>
      In the first facet of the above plot denoted “raw,” the soil CO<sub>2</sub> concentration at the BONA site with
      missing
      values filled in via interpolation is illustrated. The trend and seasonality inferred by STL are illustrated in
      the “trend” and “season_year” facets, respectively. Finally, the “remainder” facet contains the soil
      CO<sub>2</sub>
      concentration values after the trend and seasonal values have been removed.
    </p>

    <p>
      The distinct annual seasonality observed earlier accounts for large changes in soil CO<sub>2</sub> concentration
      level.
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
      <figcaption>Figure 9:</figcaption>
    </figure>

    <p>
      STL decomposition results in a trend for soil CO<sub>2</sub> concentration sensors at the BONA site with
      <span>verticalPosition</span> 501 that remains fairly level from mid-2019 to 2021, staying with 5 ppm.
    </p>

    <figure>
      <img src="../assets/STL_BONA_503.png" alt="STL Decomposition for BONA" loading="lazy">
      <figcaption>Figure 10:</figcaption>
    </figure>

    <p>
      However, STL decomposition for soil CO<sub>2</sub> concentration sensors at the BONA site with <span>verticalPosition</span>
      503 shows has a sharp decline from mid-2019 to 2021 of 30 ppm.
    </p>

    <p>
      Because the trend identified by STL decomposition is very small in magnitude compared with seasonality and with
      remainder, and the trends are not consistent between sensors even within the same site, it is likely the trends
      are spurious.
    </p>

    <p>
      Soil CO<sub>2</sub> concentration at the BONA site may be undergoing a long-term trend. However, such a trend is
      of small
      enough magnitude that 3 years of data is likely insufficient to detect it, especially considering the relatively
      large seasonal and nonseasonal fluctuations.
    </p>

    <figure>
      <img src="../assets/STL_DEJU.png" alt="STL Decomposition for DEJU" loading="lazy">
      <figcaption>Figure 11:</figcaption>
    </figure>

    <p>
      Decomposition of soil CO<sub>2</sub> concentration at the DEJU site is similar to that for the BONA site. There is
      a distinct
      annual seasonality that accounts for changes with magnitude of approximately 1000 ppm between extremes. Trend
      changes direction from year to year and represents magnitudes of no more than 40 ppm. The remainder highlights
      that the highest spike in soil CO<sub>2</sub> concentration that reaches nearly 1500 ppm and occurs in 2018 before
      the
      expected summer seasonal highs is an outlier. A similarly timed spike occurs in the remainder with magnitude 800
      ppm, while no other spike in the remainder is greater than approximately 400 ppm.
    </p>

    <figure>
      <img src="../assets/STL_HEAL.png" alt="STL Decomposition for HEAL" loading="lazy">
      <figcaption>Figure 12:</figcaption>
    </figure>

    <p>
      Decomposition of soil CO<sub>2</sub> concentration at the HEAL site reflects less of a regular annual seasonality
      than that
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
      Overall, the STL decomposition of soil CO<sub>2</sub> concentration at the HEAL site reflects the relative lack of
      distinct
      seasonality compared with the BONA or DEJU sites.
    </p>

    <h2>Regression Analysis</h2>
    <ACF class="graphicContainer"></ACF>
    <small>Figure 12: </small>

    <h3>Ordinary Least Squares Linear Regression</h3>
    <p>Fill in</p>

    <h3>Regression with ARIMA Errors</h3>
    <p>Fill in</p>

    <h3>Regression with Seasonal ARIMA Errors</h3>
    <p>Fill in</p>

    <h3>Modeling Seasonally Adjusted Data</h3>
    <p>Fill in</p>

    <h2>Conclusions</h2>
    <ul>
      <li>Developed data product preprocessing framework.</li>
      <li>Demonstrated why time-series modeled are needed.</li>
      <li>Verified association between soil temperature and CO<sub>2</sub> contentration.</li>
    </ul>
    <p><b>NEON data is big and messy, but can provide insights to important environmental problems.</b></p>

    <h2>Works Cited</h2>

    <ul>
      <li>Battelle. (2021). Science design. Retrieved April 20, 2021, from
        https://www.battelleecology.org/about/about/science-design
      </li>
      <li>Battelle. (2020). Learning hub. Retrieved April 20, 2021, from
        https://www.neonscience.org/resources/learning-hub
      </li>
      <li>Environmental Protection Agency. (2021, April 14). Sources of greenhouse gas emissions. Retrieved
        April 20, 2021, from https://www.epa.gov/ghgemissions/sources-greenhouse-gas-emissions
      </li>
      <li>Hyndman, R.J., & Athanasopoulos, G. (2021) <em>Forecasting: principles and practice</em>, 3rd
        edition, OTexts: Melbourne, Australia. OTexts.com/fpp3.
      </li>
      <li>Lunch, C. K., & Jones, M. A. (2021, April 8). Use the neonutilities package to access neon data.
        Retrieved April 20, 2021, from https://www.neonscience.org/resources/learning-hub/tutorials/neondatastackr
      </li>
      <li>NEON (National Ecological Observatory Network). Utqiaġvik NEON / BARR. Retrieved April 19, 2021,
        from https://www.neonscience.org/field-sites/barr
      </li>
      <li>NEON (National Ecological Observatory Network). Explore Data Products. Retrieved April 19, 2021,
        from https://data.neonscience.org/data-products/explore
      </li>
      <li>NEON (National Ecological Observatory Network). Soil CO2 concentration (DP1.00095.001). Retrieved
        April 19, 2021, from https://data.neonscience.org
      </li>
      <li>NEON (National Ecological Observatory Network). Soil temperature (DP1.00041.001). Retrieved April
        19, 2021, from https://data.neonscience.org
      </li>
      <li>NEON (National Ecological Observatory Network). Soil water content and water salinity
        (DP1.00094.001). Retrieved April 19, 2021, from https://data.neonscience.org
      </li>
      <li>Schaefer, K. (n.d.). National snow and Ice data center. Retrieved April 20, 2021, from
        https://nsidc.org/cryosphere/frozenground/methane.html
      </li>

    </ul>


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

span {
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
