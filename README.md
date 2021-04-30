# Interactive Report

This repository contains the source code to generate the interactive report as well as the build files that are hosted
on github pages.

## View the report

Hosted on [github pages](https://haroutboujakjian.github.io/permafrost-interactive-report/)

## Details

The interactive report is created using [Vue.js](https://vuejs.org/) and [D3.js](https://d3js.org/). In order to run the
files in development, a version of [Node.js](https://nodejs.org/en/) (>14) needs to be installed on the machine. Then
running
`npm install` in the main directory that contains the `pacakage.json` and all of the dependencies will be installed in
the `node_modules` folder. Lastly, `npm run serve` will start the development server at 
`http://localhost:8080/permafrost-interactive-report/`.

### Chart Components

Two main chart components were built for this interactive report. The line chart (and area chart) and choropleth components can be found
in
`src/components`. D3 is used to generate the `d` attribute for svg path elements (i.e. includes the lines on the chart
and the Alaskan border). The x and y coordinates values are also calculated using
`D3-geo`'s projection function. After calculating these values, `Vue.js` is used to actually render the content on the
screen and add event listeners for interactivity.
