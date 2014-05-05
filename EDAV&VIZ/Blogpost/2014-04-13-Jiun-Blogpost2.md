---
layout: post
title: Jiun - Learning d3.js by doing!
description:
tags: blog, d3, R
---
<section>
	<section>

* Tools used: d3, R
* Theme: Visualizing Time-series data

## World's Top Five Countries by CO2 emissions ##

### 1. Graph Critiques: ###

[Here](http://blogs.shell.com/climatechange/category/copenhagen/page/2/) is the website that I found the below chart of 'Global Emission CO2 to 2050' that tempted me to work on for my second blogpost. 

<a href="http://blogs.shell.com/climatechange/wp-content/uploads/2010/01/Global-Emissions-Case-2.jpg"><img src="http://blogs.shell.com/climatechange/wp-content/uploads/2010/01/Global-Emissions-Case-2.jpg" alt="Global-Emissions-Case" width="500" height="400"></a>

For one, this was visually hideous that gained my attention. (It did its job attrating people that way!) For two, it failed to be informative as too many values of different categories were stacked on each other. It's hard to see what's going on at first glance. While learning d3.js through this semester, I have seen beautiful and informative d3.js stacked charts. I wanted to give it a try and thoguht the area chart was a good place to start D3.

### 2. Data source: ###

Instead of original data, I wanted to see something more intriguing. So I came up with an idea of looking into top major 5 countries emitting CO2 the most. Data was derived from [here](http://tonto.eia.doe.gov/cfapps/ipdbproject/IEDIndex3.cfm?tid=90&pid=44&aid=8). 

### 3. First attempt: Stacked area charts

I ploted the data in R to explore data. I noticed that China and USA have values in a wider range. Instead of stacking, I thought of plotting multiple time-series with the same axes like [this](http://bl.ocks.org/mbostock/1157787). However, placing multiple series in the same scope may reduce legibility of series with relatively smaller values. An alternative approach is to use different scales for each series: showing each series in its own chart. This could mislead people's perception and interpretation of each chart though. For remedy, I found 'click and drag to zoom' feature in d3!! D3 is GREAT! 

<div align="left"><iframe src="http://jsfiddle.net/stephenkappel/bk854/embedded/result" allowfullscreen="allowfullscreen" frameborder="0" width="1000" height="550"></iframe></div>

I liked the 'click and drage to zoom' option for zooming in to look for certain period. However, adding mouse-over could provide information about Y-axis values for each year. 

### 4. Initial challenges & thoughts:
* Javascript was like a foreign language to me; interesting but hard to grasp! 
* Setting up d3 on local server was a long and confusing process. Loading external data in d3 wasn't simple after all. 
* Getting around with 'dates' in d3 were painful. Parsing dates were not done very well with d3.
* Color coding was FUN! 

### 5. Second attempt: Stream graph



### D3 learning materials:
As you may be aware, there are prolific materals available online. This is good and bad. Bad because I didn't know where to look. <br>

1) [Scott Murray website](http://alignedleft.com/tutorials/d3/) and his tutorial definitely helped. <br>
2) [D3 tips and Tricks](http://thedata.co/sites/thedata.co/files/u1/D3-Tips-and-Tricks_Book_v4.pdf) is my favorite as it walks you through more thoroughly. <br>
3) Youtube video of [D3 Vienno](https://www.youtube.com/user/d3vienno) <br> covers diverse examples. 
4)[Dashing D3.js](https://www.dashingd3js.com/) is well organized. <br>
5) Stackoverflow is a great learning platform!




```javascript

```





</section>
</section>
