# geodesic

[![Swift Version](https://img.shields.io/badge/swift-4.1-blue.svg)](https://swift.org) 
![Platform](https://img.shields.io/badge/platform-osx--64|linux--64-lightgrey.svg)
[![Build Travis-CI Status](https://travis-ci.org/dastrobu/geodesic.png?branch=master)](https://travis-ci.org/dastrobu/geodesic) 

Solver for the inverse geodesic problem in Swift.

The inverse geodesic problem must be solved to compute the distance between two points on an oblate spheroid, or 
ellipsoid in general. The generalization to ellipsoids, which are not oblate spheroids is not further considered here, 
hence the term ellipsoid will be used synonymous with oblate spheroid.

The distance between two points is also known as the 
[Vincenty distance](https://en.wikipedia.org/wiki/Vincenty's_formulae).

Here is an example to compute the distance between two points (the poles in this case) on the 
[WGS 84 ellipsoid](https://en.wikipedia.org/wiki/World_Geodetic_System).

    import geodesic
    let d = distance((lat: Double.pi / 2,lon: 0), (lat: -Double.pi / 2, lon: 0))
    
and that's it. 

## Implementation Details

This Swift package is a wrapper for the 
[C library for Geodesics 1.49](https://geographiclib.sourceforge.io/html/C/).
The author of this library is Charles F. F. Karney (charles@karney.com). 
The goal of this Swift package is to make some algorithms from 
[GeographicLib](https://geographiclib.sourceforge.io/) available to the Swift world.
Alternatively one can employ the package 
[vincenty](https://github.com/dastrobu/vincenty) 
which is a much simpler solver for the inverse geodesic problem, completely written in 
Swift. Vincenty's formulae does, however, have some convergence problems in rare 
cases, an may not give the same accuracy as Karney's algorithm. 

## Convergence and Tolerance

The computation does always converge and is said to compute up to machine precision.
See documentation of [GeographicLib](https://geographiclib.sourceforge.io/) for details.

## WGS 84 and other Ellipsoids

By default the 
[WGS 84 ellipsoid](https://en.wikipedia.org/wiki/World_Geodetic_System)
is employed, but different parameters can be specified, e.g. for the 
[GRS 80 ellipsoid](https://en.wikipedia.org/wiki/GRS_80).

    distance((lat: Double.pi / 2, lon: 0), (lat: -Double.pi / 2, lon: 0), 
             ellipsoid (a: 6378137.0, f: 1/298.257222100882711))



