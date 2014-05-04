---
layout: post
title: Project Iteration 1 // D Jones
description: social listening software
tags: Project, dtjones
---

#Goal

I am hoping to process social data to glean insights around public perception of a brand or business. 

For example, say a brand is live tweeting during an event like the superbowl and is also a sponsor, like any of the [brands here](http://marketingland.com/best-brand-updates-super-bowl-72663) . Brands are interested in knowing whether or not their social media strategy is making an impact on marketing goals such as brand recall, brand equity, purchase intent, or brand favorability. I would like to leverage Twitter's public API data to capture themes around consumers' conversations and opinion of the brand resulting from significant investment of resources into social media. 

There are various social listening products available on the market right now, such as [Radian6](http://www.salesforcemarketingcloud.com/) who was recently acquired by salesforce and [Neilson BuzzMetrics](http://www.nielsen-online.com/products_buzz.jsp?section=pro_buzz#1) among others. Software like this could be sold to clients at my agency, and I want to gain exposure to NLP. win win!

[Here is my trello board](https://trello.com/b/US9rnRmB/dtjones-edav-project)

#Plan - first 3 weeks

1) Accessing API / setting up OAuth with python
	-there is documentation around this. shouldn't be too difficult
	
2) Understand what parameters I can use to acquire data
	-ideally i would like to grab all tweets that have a specific word like the brand name in a given reporting window. Might be interested in a specific hashtag. Either way I'm not totally sure how to do it
	
3) Understand the size of the data
	-I'm not sure what storage I will need if the data is too big. If it is too big and I don't have a place to put the data, I will have to find a way to sample the data that won't limit the insights / will be statistically sound
	
4) Explore data setup for LDA
	-will probably use R

5) Explore public word libraries for sentiment analysis
	-I think these exist. Need to confirm
	
6) Explore d3 word clouds for visualization
	-this will be cool

<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->