---
layout: post
title: Jiun's Blogpost 3: Scatter-plot matrix using rCharts
description:
tags: blog, d3, R, rCharts
---

* Tools used: rCharts
* Theme: Scatterplot matrix

## Wholesale Customers' Spending Behavior by Channel and Region##

### 1. Graph Critiques: ###

I couldn't resist to work on this plot below. It's quite amazing to see how they put continuous variables ('Height' and 'Weight') and a categorical variable ('Sex') in the same Scatterplot Matrix. 

<a href="http://www.jmp.com/support/help/images/students.gif"><img src="http://www.jmp.com/support/help/images/students.gif" alt="Scatterplot Matrix" width="450" height="450"></a>

The web link for the plot is [here](http://www.jmp.com/support/help/Example_of_a_Scatterplot_Matrix.shtml). Scatterplot Matrix is mainly used to represent the relationships among multiple variables. Though I admit visualizing high dimensonal data is not an easy task, putting 'Sex' variable together with continuous variables in one scatterplot matrix wasn't a smart choice, in my opinion. 

### 2. Data source: ###

Since there was no way that I could identify on data source, I used a different set of data which has a similar properties with an aim to represent a scatter matrix in a more effective way. I extracted data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Wholesale+customers). The website holds many types of dataset, just like dastaset built in R or R packages. I chose this dataset because it contains both categorical and continuous variables.  

### 3. Thought process and Actions: ###

I thought about making a plot like [this](http://hci.stanford.edu/jheer/files/zoo/ex/stats/splom.html). There were two things that I wanted to improve upon this plot though. First, I wanted to see different scenarios of "US", "EU", "Japan" by adding an interactive selection option. Second, I wanted to use the space of diagonal cells/squares of matrices. Then, I discovered a new world 'rCharts'. Volia! rCharts is an R package to create, customize and publish interactive javascript visualizations from R using a familiar lattice style plotting interface. Here is my embedded visualization below. The R code and the plot can be seen [here](http://bl.ocks.org/jiun0201/9f98014751a856da1e6b). 


<div align="left"><iframe src="http://bl.ocks.org/jiun0201/9f98014751a856da1e6b/" allowfullscreen="allowfullscreen" frameborder="0" width="1000" height="700"></iframe></div>

I did 
I ploted the data in R to explore data. I noticed that China and USA have values in a wider range. Instead of stacking, I thought of plotting multiple time-series with the same axes like [this](http://bl.ocks.org/mbostock/1157787). However, placing multiple series in the same scope may reduce legibility of series with relatively smaller values. An alternative approach is to use different scales for each series: showing each series in its own chart. This could mislead people's perception and interpretation of each chart though. For remedy, I found 'click and drag to zoom' feature in d3!! D3 is GREAT! 

Here is my first visualization embedded below. 

I liked the 'click and drage to zoom' option for zooming in to look for certain period. Adding mouse-over could provide information about Y-axis values for each year. 

### 4. Initial challenges & thoughts:
* Javascript was like a foreign language to me; interesting but hard to grasp! 
* Setting up d3 on local server was a long and confusing process. Loading external data in d3 wasn't simple after all. 
* Getting around with 'dates', especially parsing dates in d3 were painful. 
* Selecting color scheme is FUN! 

### 5. Second attempt: Stream graph with mouseover option

[Stream graph](http://bl.ocks.org/mbostock/4060954) is alternative for mulitple level time-series data. Also I wanted to try mouseover option. Followed is my visualization with same data. The d3.js code and data can be seen [here](http://bl.ocks.org/jiun0201/e914be44df65640f8533). 

<div align="left"><iframe src="http://bl.ocks.org/jiun0201/e914be44df65640f8533/" allowfullscreen="allowfullscreen" frameborder="0" width="1000" height="550"></iframe></div>

I am happy how it turned out and glad I gave a second shot. While working on these, I found [nvd3](http://nvd3.org/) which provides reusable charts and components. The codes are simpler than d3.js and generate great visualizations. I might try it for my third blogpost.

### D3 learning materials:
Prolific materals about d3 are available online but that made me confused about where to start. Just like learning Github and Git! So I thought I would refer some materials that helped me landed in d3 world!!

1) [Scott Murray website](http://alignedleft.com/tutorials/d3/) and his tutorial definitely helped. <br>
2) [D3 tips and Tricks](http://thedata.co/sites/thedata.co/files/u1/D3-Tips-and-Tricks_Book_v4.pdf) is my favorite as it walks you through more thoroughly. <br>
3) Youtube video of [D3 Vienno](https://www.youtube.com/user/d3vienno) covers diverse examples. <br>
4) [Dashing D3.js](https://www.dashingd3js.com/) is a well-organized website. <br>
5) Stackoverflow is a great learning platform. It is my best friend!



