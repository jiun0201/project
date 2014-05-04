---
layout: post
title: Iteration Plan - Melissa Berry
description: Plan for progress in the first 3 weeks
---

I am studying the risk of traffic crashes at intersctions in NYC relative to adjacent intersections.  I already have a data set (thanks in large part to talos on Github) that aggregates crash data on all crashes recorded by the NYPD by intersection and month since August 2010.  The data is already geocoded, however there are missing and nonsensical values.

1. Review the missing and nonsense lat/lon values and see if I can re-geocode them using either the Google or Geonames APIs
2. Find a way of binning and plotting the ~250k records on a map as a first glance at the data
3. Implement a kernel density estimate to make a smooth contour plot over the geographic surface
4. If this is successful I will try to replicate the contour plot using QGIS (or similar) to account for the geographic (water) boundaries that will are present in the area of interest.

Next sprint will include:

1. Finding other data sources that can be incorporated into the analysis such as number of lanes of incoming traffic, type of intersection, presence or absence of pedestrian countdown signals, land use of the area surrounding the intersection and traffic volume information.
2. Performing cluster analysis (possibly hierarchical) on identified hotspots to categorize problem areas
3. Create a visualization which shows the locations and types of the clusters.
