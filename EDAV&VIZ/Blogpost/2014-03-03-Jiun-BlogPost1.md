---
layout: post
title: Jiun's Blogpost1 
description:
tags: blog, R, ggplot, d3, nvd3

---

* Tools used: nvd3, R, d3
* Theme: Visualizing MultiBarChart using nvd3

## Top Languages Other than English Spoken in 1980 and Changes in Relative Rank, 1990-2010 ##

### 1. Graph Critiques ###

US Census Bureau has a '[Data Visualization Gallery]'(http://www.census.gov/dataviz/visualizations). Its initiative is great though I found this particular graph below very confusing. 

<div align="left"><iframe src="http://www.census.gov/dataviz/visualizations/045/" allowfullscreen="allowfullscreen" frameborder="0" width="950" height="800"></iframe></div>

Just too much information such as different sizes of square, lines connected between them, different colors were all squeezed in one graph. I actually expected a simple graph of this topic since the topic is fairly starightforward. 

### 2. Data munging ###

The website provides data [table](http://www.census.gov/dataviz/visualizations/045/508.php). Data munging was done in R and R code can be seen from [here]().

### 3. First attempt with ggplot ###

<a href="https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/blogpost1_multibar.png"><img src="https://raw.githubusercontent.com/jiun0201/project/master/EDAV&VIZ/Blogpost/blogpost1_multibar.png" alt="Top Language Spoken Other Than English" width="500" height="300"></a>



## Visualizing a table of 'Global Database of Events, Language, and Tone Event Database (GDELT)' Trend Report ##

### 1. Rationale behind choosing this table ###

For my first blogpost, I picked the 'Comple Country Ranking table' of [GDELT Global Materal Conflict 48-Hour Trend Reprot 3/25/2014](https://docs.google.com/viewer?a=v&pid=forums&srcid=MDc3NjUxNjA1Nzg5MTQ1MTA5NTEBMDExNzA1NjE5NzEzODkwODQ5NDYBQ2dxMHNiWVVnejRKATIBAXYy). This report is to provide information on countries undergoing the greatest change in media coverage of Materical Conflict events in the last 48 hours and thereby offers an approximate indication of daily global concensus view of the most "important" emerging Material Conflict developments across the entire world. As seen in the report, it consists of two parts: 1) Visualizations of top 10 emerging countries in material conflict within 48 hours with detailed information and 2) Complete Country Ranking table. As its function is reporting daily information to public, I expected a informative visualization of the comple country ranking table. Also, I reckoned visualizing a table could be a good starting point for developing my thought process in data visualization. So I chose to work on this data using ggplot.  

### 2. Data manipulation ###

To work on data, I scrpped the table from the report and stored them into csv. Since I am most comfortable with R programming language, I read and handled the data in R. 

### 3. Plotting ###

I ploted based on Coverage Volume. According to the report, Coverage Rank column ranks country based on the total raw volume of articles, with 1 being the country with the most articles. While cleaning, I found several '0' as a rank which I think that it was because its respective Volume is '0'. 

<a href="http://blogs.shell.com/climatechange/wp-content/uploads/2010/01/Global-Emissions-Case-2.jpg"><img src="http://blogs.shell.com/climatechange/wp-content/uploads/2010/01/Global-Emissions-Case-2.jpg" alt="Global-Emissions-Case" width="500" height="400"></a>

![Plot1](https://github.com/jiun0201/project/blob/master/EDAV/Vol21.22.jpeg)
![Plot2](https://github.com/jiun0201/project/blob/master/EDAV/Vol23.24.jpeg)
![Plot3](https://github.com/jiun0201/project/blob/c929ee6a485ec046b6ec39f88b9683edf63bd681/EDAV/Volboth.jpeg)
![Plot4](https://github.com/jiun0201/project/blob/master/EDAV/VolC.jpeg)
![Plot5](https://github.com/jiun0201/project/blob/master/EDAV/MapVolC.jpeg)

I think Data could be visually more effective if use D3. I am learning D3 now and plan to do next blog post using D3.



