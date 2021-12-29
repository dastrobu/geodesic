# geodesic

[![Swift Version](https://img.shields.io/badge/swift-5.5-blue.svg)](https://swift.org)
![Platform](https://img.shields.io/badge/platform-macOS|linux--64-lightgray.svg)
![Build](https://github.com/dastrobu/geodesic/actions/workflows/ci.yaml/badge.svg)
[![GeographicLib Version](https://img.shields.io/badge/GeographicLib-1.52.0-blue.svg)](https://geographiclib.sourceforge.io/)

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

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Dependencies](#dependencies)
- [Getting started](#getting-started)
    - [Help Text generation](#help-text-generation)
- [Parsers](#parsers)
    - [Flag](#flag)
        - [Flag Prefixes](#flag-prefixes)
        - [Passing a Flag Multiple Times](#passing-a-flag-multiple-times)
        - [Handling Unexpected Flags](#handling-unexpected-flags)
        - [Multi Flags](#multi-flags)
        - [Automatic Help Flag](#automatic-help-flag)
            - [Parse Order](#parse-order)
            - [Default Action](#default-action)
            - [Exit After Help Printed](#exit-after-help-printed)
            - [Output Stream](#output-stream)
    - [Option](#option)
        - [Option Prefixes](#option-prefixes)
        - [Passing an Option Multiple Times](#passing-an-option-multiple-times)
        - [Int Option and Double Option](#int-option-and-double-option)
        - [Handling Unexpected Options](#handling-unexpected-options)
    - [Command](#command)
        - [Global Flags (or Options)](#global-flags-or-options)
        - [Semi-Global Flags (or Options)](#semi-global-flags-or-options)
        - [Var Args on Commands](#var-args-on-commands)
        - [Command Default Action](#command-default-action)
        - [`parsed` and `afterChildrenParsed`](#parsed-and-afterchildrenparsed)
        - [Nested Commands](#nested-commands)
    - [Var Args](#var-args)
    - [Handling Unexpected Arguments](#handling-unexpected-arguments)
        - [Stop Token](#stop-token)
- [Default Action](#default-action-1)
- [Error Handling](#error-handling)
- [Logging](#logging)
- [Architecture](#architecture)
    - [Parse Path](#parse-path)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

At least `clang-3.6` is required. On linux one might need to install it explicitly. There are no dependencies on macOS.

### Swift Package Manager

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/dastrobu/geodesic.git", from: "1.2.0"),
    ]
)
```

## Implementation Details

This Swift package is a wrapper for the
[C library for Geodesics](https://geographiclib.sourceforge.io/html/C/). The author of this library is Charles Karney (
charles@karney.com). The goal of this Swift package is to make some algorithms from
[GeographicLib](https://geographiclib.sourceforge.io/) available to the Swift world. Alternatively one can employ the
package
[vincenty](https://github.com/dastrobu/vincenty)
which is a much simpler solver for the inverse geodesic problem, completely written in Swift. Vincenty's formulae does,
however, have some convergence problems in rare cases and may not give the same accuracy as Karney's algorithm.

## Convergence and Tolerance

The computation does always converge and is said to compute up to machine precision. See documentation
of [GeographicLib](https://geographiclib.sourceforge.io/) for details.

## WGS 84 and other Ellipsoids

By default the
[WGS 84 ellipsoid](https://en.wikipedia.org/wiki/World_Geodetic_System)
is employed, but different parameters can be specified, e.g. for the
[GRS 80 ellipsoid](https://en.wikipedia.org/wiki/GRS_80).

    distance((lat: Double.pi / 2, lon: 0), (lat: -Double.pi / 2, lon: 0), 
             ellipsoid (a: 6378137.0, f: 1/298.257222100882711))

## Known Issues

* Compilation with gcc on Linux does not work. `swift build` fails. No problems with clang on Linux. 
 

