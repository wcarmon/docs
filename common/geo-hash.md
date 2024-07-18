# Overview
1. Big ideas for [Geo Hashing](TODO)


# Purpose
1. Fast proximity search/query
1. Supports arbitrary precision
1. Simpler alternative to latitude & longitude values 
    1. They would be stored as `float64` in a database
    1. Distance calculations would require two indexes, square roots, etc
1. Longer common prefix means points are closer together 


# Concept
1. a GeoHash is a 1 to 12 alphanumeric string
    1. 4-chars: within 12 - 25 miles, like a town
    1. 5-chars: within 3 miles, like a neighborhood or some landmark
    1. 6-chars: within ~ 0.5 mile (non-square)
    1. 7-chars: 100m - 500m (Android Coarse-grained GPS data)
    1. 8-chars: within 30m (Android Fine-grained GPS data)
    1. 9-chars: within 5m
1. Only odd hash lengths are squares
1. Each level broken into 32 equally sized rectangles
1. A is a type of [Spacial index](http://postgis.net/workshops/postgis-intro/indexing.html)


# Implementation
1. Break the planet into 32 equally sized rectangles


# Gotchas & Edge cases
1. proximity calculation issues at the boundary of a region
    1. Some nearby points don't share common prefix
1. Actual distance might factor in things like ...
    1. Transportation mode (Train, Bus, Boat, Bike, Walking, ...)
    1. One way roads, closed roads, etc
    1. Walking paths or train tracks where there are no roads


# Other resources
1. https://www.pubnub.com/guides/what-is-geohashing/
1. https://en.wikipedia.org/wiki/Geohash
1. https://docs.quadrant.io/quadrant-geohash-algorithm
