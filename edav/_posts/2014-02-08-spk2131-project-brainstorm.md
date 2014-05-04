---
layout: post
title: Project Brainstorm - Software Forums/Communities
description: My initial thoughts on exploring the effectiveness of forums for my EDAV project
tags: project
--- 

## Objective

Working in the support organization of a software firm, I see the significance of "deflecting" issues through the use of self-help  tools, one of which is forums/communities. Having customers use forums is preferable to having customers open support tickets, because:


- Customers are more satisfied if they can solve a problem without having to open up a support ticket with the vendor.
- Solutions become documented in a place accessible to all customers, unlike support tickets, which are only accessible to the software vendor and a single customer.
- By exposing the question to more minds, the likelihood that someone having seen the same problem before and being able to produce a quick answer is greatly increased.
- The software vendor saves time and money by allowing engineers to focus on the tougher issues (software bugs, complex configurations, etc.) and new development, rather than time being spent on answering the easier questions that can be solved with a search of forums or a post on the same.

Through my project, I hope to gain better insight into (a) general patterns of behavior in how users interact with forums, (b) what makes a forum (in general) or a particular post on a forum successful or unsuccessful, and (c) where may there be room for improvement in general forum design or in the management of particular forums.

## The Data Points

I would like to collect forum data from at least two different vendors. As a start, I'd like to look at [Microsoft's MSDN forums](http://social.msdn.microsoft.com/Forums/en-US/home) and [CA's communities]( https://communities.ca.com/web/guest/community-directory). It should be possible to collect the necessary data by screen-scraping these sites.

Here is an initial list of data and metrics that can be collected from the sites and which might be able to provide useful insight:

 -     First post timing: month, day of week, and time of day
 -     Quantity of participants: total, employees, and moderators
 -     Participant reputations: creator, average of all respondents, answerer(s)
 -     Forum: name, product, # of members, creation date
 -     Keywords in: thread title, question, responses
 -     Time to: first response, creator response to other response
 -     Number of comments after marked as solved
 -     Length (in chars or words) of: thread title, initial question, responses
 -     Reputation of: creator, other participants
 -     Success status: success = marked completed; failure = no post for 1 month and not marked solved; active = not marked completed, but last post less than one month old
 -     Number of up votes
 -     Number of thread views
 -     Number of links to other threads or documentation from this post and number of links to this thread from other threads
 -     Number of comments/responses

## Project Tasks

The main tasks in completing this project will be:

1. Collect the data by screen scraping the web pages (most likely with Python) and write it to some data store (possibly a SQL database, noSQL database, or a flat CSV or JSON file).
2.  Process the data to aggregate it and find desired metrics. I am most comfortable with SQL and C#, so I may use these tools too complete this task.
3.  Export the aggregated data and metrics to a CSV.
4.  Import the CSV into R and do some exploratory analysis to find correlation and interesting relationships.
5.  Create a visualization showcasing and allowing further exploration of the most interesting data points and relationships using D3.js and possibly Crossfilter.