<template>
  <main>
    <h2>Introduction</h2>
    <ul>
      <li>Permafrost is defined as the sublayer of soil that remains below 0&#730;C for two or more years.</li>
      <li>This layer above permafrost is the normal soil which melts and freezes based on the season.</li>
      <li>Permafrost is slowly melting around the world, releasing trapped CO<sub>2</sub>.</li>
      <li>Environmental scientists concerned this will accelerate unwanted climate change.</li>
    </ul>

    <figure>
      <img src="../assets/permafrost2.png" alt="Image showing difference in permafrost and active layer"
           class="permafrostImg">
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
        [that] enables forecasting of future ecological conditions” (Battelle, 2021).
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
      <figcaption>
        Table 1: The three data products used in the analysis: soil CO<sub>2</sub> concentration, soil
        temperature, and soil water content and salinity.
      </figcaption>
    </figure>

    <h2>Data Preprocessing</h2>

    <h3>How we selected the BONA, DEJU, and HEAL sites?</h3>
    <ul>
      <li>Soil CO<sub>2</sub> contentration fluctuates at the 5 different National Ecological Observatory Network sites
        in Alaska.
      </li>
      <li>
        BARR is the NEON Program's northernmost field site near Utqiaġvik, Alaska (used to be known as Barrow).
        Described as having "long, cold winters; short, cool summers; persistent wind driven by the nearby Arctic
        Ocean; and extreme seasonal variation" (NEON, Utqiaġvik, 2021).
      </li>
      <li>Both the BARR and TOOLIK (TOOL) sites are in the NEON Tundra Domain (D18), but the TOOL site sits at the
        border of the
        taiga and tundra lines.
      </li>
      <li>
        Climate at the TOOL site is also described similarly as BARR, but the Soil CO<sub>2</sub> does not have
        outliers quite as large.
      </li>
      <li>
        On the other hand, the 3 sites clustered in the middle of Alaska, Caribou-Poker Creeks Research Watershed
        (BONA), Delta Junciton (DEJU), and HEALY (HEAL), experience the same typified cold winters and short summers,
        but without the extreme seasonal variation of the tundra sites.
      </li>
    </ul>
    <AllSitesMapTimeSeries class="graphicContainer"></AllSitesMapTimeSeries>
    <small>
      Figure 2: Mean CO<sub>2</sub> values for each of the fives in Alaska. Click
      <font-awesome-icon icon="hand-pointer" class="faIcon"></font-awesome-icon>
      the points on the map to select/deselect specific sites from the line chart, and use the start and end date
      inputs to render different time durations.
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
      positions. Deeper sensors exhibit larger and more volatile values where as sensors as shallower depths are
      smaller and less volatile. Click
      <font-awesome-icon icon="hand-pointer"></font-awesome-icon>
      on the text next
      to the sensor to add or remove specific depths from the plots.
    </small>

    <h3>How do we re-index to the best time scale?</h3>
    <ul>
      <li>Investigating for trends over years. 30-minute measurements are too small.</li>
      <li>Start with 30-minute average measurements (comes with number of points).</li>
      <li>Compute weighted mean and pooled variance for a single day.</li>
    </ul>

    <h2>Seasonality and Trend Analysis</h2>

    <h3>Raw Data</h3>

    <figure>
      <img src="../assets/bona-raw.png" alt="Soil CO2 concentration at BONA site, all sensors, by day"
           loading="lazy">
      <figcaption>Figure 8: Mean soil CO<sub>2</sub> concentration from all sensors at BONA site, by day. The gaps in
        summer of 2018 and fall of 2020 represent missing observations.
      </figcaption>
    </figure>

    <ul>
      <li>Increasing variance with increasing level</li>
      <li>Missing values</li>
    </ul>

    <h3>Seasonal and trend decomposition using LOESS (STL)</h3>
    <ul>
      <li>LOESS = Locally estimated scatterplot smoothing</li>
      <li>Flexible seasonal period</li>
      <li>Robust to outliers</li>
      <li>Cannot handle missing values</li>
    </ul>

    <h3>Autoregressive Integrated Moving Average (ARIMA)</h3>

    <ul>
      <li>Linear combination of preceding values ("autoregressive")</li>
      <li>Linear combination of preceding forecast errors ("moving average")</li>
      <li>Differences between subsequent values ("integrated")</li>
      <li>Assumes stationarity</li>
      <li>Can be fit via software</li>
      <li>Non-seasonal ARIMA</li>
    </ul>

    <h3>Intepretation of Results</h3>

    <figure>
      <img src="../assets/STL_BONA.png" alt="STL Decomposition for BONA" loading="lazy">
      <figcaption>Figure 9: A plot of soil CO2 concentration at the BONA site as decomposed by STL. The scale of the
        y-axis of each row differs. "Raw Observations" contains the soil CO2 concentration at the BONA site with missing
        values filled in via interpolation. The trend and seasonality inferred by STL are illustrated in the "Trend
        Component" and "Seasonal Component" rows, respectively. The "Remainder" row contains the soil CO2 concentration
        values after the estimated trend and seasonal components have been removed. The vertical bar in each row is
        included for reference of scale. The height of the vertical bar represents the same difference in soil CO2
        concentration, plotted at the various scales of each row.
      </figcaption>
    </figure>

    <ul>
      <li>Vertical bar for scale</li>
      <li>Pronounced seasonality</li>
      <li>Miniscule trend</li>
    </ul>

    <figure>
      <img src="../assets/STL_DEJU.png" alt="STL Decomposition for DEJU" loading="lazy">
      <figcaption>Figure 10: A plot of soil CO2 concentration at the DEJU site as decomposed by STL. The scale of the
        y-axis of each row differs. "Raw Observations" contains the soil CO2 concentration at the BONA site with missing
        values filled in via interpolation. The trend and seasonality inferred by STL are illustrated in the "Trend
        Component" and "Seasonal Component" rows, respectively. The "Remainder" row contains the soil CO2 concentration
        values after the estimated trend and seasonal components have been removed. The vertical bar in each row is
        included for reference of scale. The height of the vertical bar represents the same difference in soil CO2
        concentration, plotted at the various scales of each row.
      </figcaption>
    </figure>

    <ul>
      <li>Similar as to BONA</li>
      <li>Pronounced seasonality</li>
      <li>Miniscule trend</li>
    </ul>

    <figure>
      <img src="../assets/STL_HEAL.png" alt="STL Decomposition for HEAL" loading="lazy">
      <figcaption>Figure 11: A plot of soil CO2 concentration at the HEAL site as decomposed by STL. The scale of the
        y-axis of each row differs. "Raw Observations" contains the soil CO2 concentration at the BONA site with missing
        values filled in via interpolation. The trend and seasonality inferred by STL are illustrated in the "Trend
        Component" and "Seasonal Component" rows, respectively. The "Remainder" row contains the soil CO2 concentration
        values after the estimated trend and seasonal components have been removed. The vertical bar in each row is
        included for reference of scale. The height of the vertical bar represents the same difference in soil CO2
        concentration, plotted at the various scales of each row.
      </figcaption>
    </figure>

    <ul>
      <li>Less consistent seasonality from year to year</li>
    </ul>


    <h2>Regression Analysis</h2>

    <ul>
      <li>Soil CO<sub>2</sub> concentration vs. soil temperature</li>
      <li>Assumption of independence</li>
      <li>Autocorrelation</li>
    </ul>

    <ACF class="graphicContainer"></ACF>
    <small>Figure 12: Plot of autocorrelation by lag in residuals from fits to various linear models, up to lag of 375
      days. "Linear" refers to an ordinary linear regression model. "Fourier" refers to a linear regression model with
      errors modeled by an ARIMA process with Fourier terms for seasonality. "Seasonal" refers to a linear regression
      model with errors modeled by a seasonal ARIMA process. "Adjusted" refers to a linear regression model with errors
      modeled by a seasonal ARIMA process fitted to seasonally adjusted data.</small>

    <h3>Inaccuracies due to Autocorrelation</h3>

    <ul>
      <li>Parameter estimates</li>
      <li>Standard errors of estimates</li>
      <li>Hypothesis tests on estimates</li>
    </ul>

    <h3>Regression with ARIMA Errors</h3>

    <ul>
      <li>Regression error term replaced by ARIMA model</li>
      <li>Long-period seasonality</li>
      <li>Harmonic Fourier terms</li>
    </ul>

    <h3>Using Seasonally Adjusted Data</h3>

    <ul>
      <li>Similar fit with example</li>
      <li>Might introduce bias</li>
      <li>Requires more steps</li>
    </ul>

    <h2>Conclusions</h2>
    <ul>
      <li>Developed data product preprocessing framework.</li>
      <li>Demonstrated why time-series modeled are needed.</li>
      <li>Verified association between soil temperature and CO<sub>2</sub> concentration.</li>
      <li><em>NEON data is big and messy, but can provide insights to important environmental problems.</em></li>
    </ul>

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
  margin: 2rem auto 0;
  display: flex;
  flex-direction: column;
}

figure img {
  align-self: center;
}

figcaption {
  font-size: 0.82rem;
  font-style: italic;
  margin-top: 0.5rem;
}

.permafrostImg {
  width: clamp(450px, 80%, 700px);
}

</style>
