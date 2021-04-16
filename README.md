# Interactive Report

This repository contains the code to generate the interactive report and to view the build files in the browser.

## View the report

Open the `index.html` file inside of the `interactive_report` folder. This will open the html file in the browser as
well as the corresponding CSS and JS files. An internet connection is not required to view it.

## Details

The interactive report is created using [Vue.js](https://vuejs.org/) and [D3.js](https://d3js.org/). In order to run the
files in development, a version of [Node.js](https://nodejs.org/en/) needs to be installed on the machine. Then running 
`npm install` in the main directory will install all of the `package.json` dependencies in a `node_modules` folder. Lastly,
`npm run serve` will start the development server at `localhost:8080`.

### Chart Components

Two main chart components were built for this interactive report. The line chart and choropleth components can be found in
`src/components`. D3 is used to generate the `d` attribute for svg path elements (i.e. includes the lines
on the chart and the Alaskan border). The x and y coordinates values are also calculated using
`D3-geo`'s projection function. After calculating these values, `Vue.js` is used to actually render the content on the
screen and add event listeners for interactivity.

### R

The `harout_eda.R` file was used to generate the `weeky_mean_of_means_zero.json` file inside of `src/data`.