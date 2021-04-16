<template>
  <main>
    <h1>Carbon Dioxide Soil Analysis in Alaskan Permafrost Sites</h1>
    <h2>Introduction</h2>
    <h2>Data</h2>
    <p>Include description and maybe snippet of data in table</p>
    <h2>Data Preprocessing</h2>
    <h3>How we selected the BONA, DEJU, and HEAL sites?</h3>
    <p>
      Soil CO<sub>2</sub> contentration fluctuates at the 5 different National Ecological Observatory Network sites in
      Alaska. The map shows the locations of each of the sites, and the line chart shows mean CO<sub>2</sub>
      concentration level per week for
      each site. Observing the line chart, there are some apparent trends when comparing soil CO<sub>2</sub>
      concentration levels at each site. The BARR site, which is at the top tip of Alaska, appears to have the highest
      spikes in soil CO<sub>2</sub> contratration. On the other hand, the 3 sites clustered in the middle of Alaska,
      Bona,
      Deju, and Heal, have similar soil CO<sub>2</sub> concentration trends without the large peaks. Both the map and
      the line chart are interactive.
      Click the points on the map to remove or add specific sites from the line chart. The start and end date inputs
      also allow the line chart to render different time period based on user interest.
    </p>
    <AllSitesMapTimeSeries class="graphicContainer"></AllSitesMapTimeSeries>

    <h3>Should we always eliminate bad observations?</h3>
    <p>
      The <span>finalQF</span> field in the dataset indicates whether a data product has passed or failed an overall
      assessment of its quality. This is helpful in determining when sensor malfunctions still result in reported data,
      but perhaps the quality of the observation cannot be trusted. More detailed information on understanding the
      overall quality of each NEON instrumented systems data product using <span>finalQF</span> can be found in
      <a href="https://data.neonscience.org/api/v0/documents/NEON.DOC.001113vB"
         rel="noreferrer noopener" target="_blank">NEON.DOC.001113 document</a>
      attached in any data download. In some cases, observations that do not
      pass the quality check appear very different from data that does pass the quality field.
    </p>
    <p>
      In the interactive plots below, we have added a threshold slider to show the effect the finalQF has on the data
      reported from the BONA and HEAL sites. The slider is programmed to go through five values:
      <span>500</span>, <span>400</span>, <span>200</span>, <span>16</span>, and <span>3</span>.
    </p>
    <SiteThreshold class="graphicContainer"></SiteThreshold>

    <h3>How do we use various sensor positions?</h3>
    <p>Use svg below for sensor depth animation</p>
    <div>
      <GrassSoil></GrassSoil>
    </div>

    <h3>How do we re-index to the best time scale?</h3>
    <p>Fill in</p>
    <h3>How do we account for seasonality and trend?</h3>
    <p>Fill in</p>

    <h2>Statistical Methodologies</h2>

    <h3>Why does multiple linear regression fall short?</h3>
    <p>Fill in</p>
    <h3>How do we account for autocorrelation?</h3>
    <p>Fill in</p>

    <h2>Conclusions</h2>
    <p>Fill in</p>

  </main>
</template>

<script>
import GrassSoil from "@/components/GrassSoil";
import SiteThreshold from "@/components/SiteThreshold";
import AllSitesMapTimeSeries from "@/components/AllSitesMapTimeSeries";

export default {
  name: "Dashboard",
  components: {
    GrassSoil,
    SiteThreshold,
    AllSitesMapTimeSeries
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
  --main-width: 60%;
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
  font-size: 1.75rem;
  text-align: center;
  margin: 1rem 0 0.6rem;
}

h2 {
  font-size: 1.45rem;
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
  font-size: 0.95rem;
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

.graphicContainer {
  background-color: var(--chart-background);
  border-top: solid 1px var(--main-color);
  border-bottom: solid 1px var(--main-color);
  width: 80%;
}
</style>