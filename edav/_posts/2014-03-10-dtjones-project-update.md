---
layout: post
title: Project Update
description: Project Update - Devin Jones
tags: project update, dtjones
---
##Project Update - Social Listening


#Twitter APIs
Twitter has a few different APIs to acces their data. They have a
legacy REST API, a Search API that they acquired and haven't
integrated with the REST API, and a Streaming API. I read that to
access full, real-time data, one must use the Streaming API. For this
project, I will use the Search API that responds similarly to
Twitter's regular search bar.

The syntax for Twitter API calls is straight-forward. You can simply
paste the below URL into the
[Twitter Console](https://dev.twitter.com/console) .

https://api.twitter.com/1.1/search/tweets.json?q=%40twitterapi

The above call will give me all tweets that involve the handle
@twitterapi. This is an interesting subset of tweets from the twitter
universe - current reporting methods only focus on the tweets that
come directly from the brand handle. It will be interesting to see the
topics of conversation around a brand's twitter handle. I'm not sure
if I can specify a reporting window yet.

#OAuth
With the console you can confirm that your API call is valid - this is
reassuring. Now, the challenge is battling OAuth and making the call
to the API to get the full json file (the console only provides a
sample output). Twitter recommends accessing its API with this
software called twURL which is similar to cURL; it basically makes
developing with AOuth
easier. [This guy writes about it here](http://warrensallen.com/blog/the-one-weird-trick-to-command-line-twitter-without-any-programming/). He
says that you need Ruby running on a Mac to use the software and he
couldn't get it to work on Windows. Since I am on a Windows machine
and I've never used Ruby, I'm not going to use twURL. I am finding
that developing is much easier with Macs in general.

After some googling, I came across
[rauth](https://github.com/litl/rauth) which seems like a good way to
make OAuth calls to the Twitter API using Python on a Windows
machine. I've successfully made a connection and a get request. Not
sure where the data is at the moment, but I will get help from someone
who has worked with python/apis/json because i'm sure its something
small i'm overlooking.

I posted my python code to
[my git hub repository](https://github.com/devintjones/twits/blob/addscript/scripts/getdatatwitter.py),
but I had to swap out my API creds with placeholders.

#Next steps
I'm going copy/paste the json file from the dev console while I find
help with the API. Going to install and understand the details of the
gensim library for topic modeling.


<!-- use tags blogpost1 blogpost2 blogpost3 for easy grouping -->
<!-- please reserve for @malecki's use only tags 'slides', 'emails' -->
