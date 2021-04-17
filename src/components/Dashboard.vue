<template>
  <main>
    <h1>Carbon Dioxide Soil Analysis in Alaskan Permafrost Sites</h1>

    <h2>What is Permafrost?</h2>
    <p>Include short intro and picture of what permafrost is and isn't</p>
    <figure>
      <img src="../assets/permafrost2.png" alt="Image showing difference in permafrost and active layer">
      <figcaption>
        Figure 1: The active layer freezes and melts based on the season while the permafrost below it stays frozen
        all year long.
      </figcaption>
    </figure>

    <h2>Data</h2>

    <p>Include description and maybe snippet of data in table</p>
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
  font-size: 1.8rem;
  text-align: center;
  margin: 1rem 0 0.6rem;
}

h2 {
  font-size: 1.5rem;
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
  font-size: 0.8rem;
  font-style: italic;
}

figure {
  width: var(--main-width);
  margin: 0 auto;
  display: flex;
  flex-direction: column;
}

figure img {
  width: clamp(450px, 80%, 680px);
  align-self: center;
}

figcaption {
  font-size: 0.8rem;
  font-style: italic;
  margin-top: 0.5rem;
}
</style>