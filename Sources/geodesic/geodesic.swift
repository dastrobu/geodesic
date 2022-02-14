import geographiclib

/// [WGS 84 ellipsoid](https://en.wikipedia.org/wiki/World_Geodetic_System) definition
public let wgs84 = (a: 6378137.0, f: 1 / 298.257223563)

/// - Returns: rad converted to degree
private func degree<T: BinaryFloatingPoint>(fromRad d: T) -> T {
    return d / T.pi * 180
}

///
/// Compute the distance between two points on an ellipsoid.
/// The ellipsoid parameters default to the WGS-84 parameters.
///
/// - Parameters:
///   - x: first point with latitude and longitude in radiant.
///   - y: second point with latitude and longitude in radiant.
///   - a: first ellipsoid parameter in meters (defaults to WGS-84 parameter)
///   - f: second ellipsoid parameter in meters (defaults to WGS-84 parameter)
/// 
/// - Returns: distance between `x` and `y` in meters.
///
public func distance(_ x: (lat: Double, lon: Double),
                     _ y: (lat: Double, lon: Double),
                     ellipsoid: (a: Double, f: Double) = wgs84
) -> Double {

    // validate lat and lon values
    assert(x.lat >= -Double.pi / 2 && x.lat <= Double.pi / 2, "x.lat '\(x.lat)' outside [-π/2, π/2]")
    assert(y.lat >= -Double.pi / 2 && y.lat <= Double.pi / 2, "y.lat '\(y.lat)' outside [-π/2, π/2]")
    assert(x.lon >= -Double.pi && x.lon <= Double.pi, "x.lon '\(y.lon)' outside [-π, π]")
    assert(y.lon >= -Double.pi && y.lon <= Double.pi, "y.lon '\(y.lon)' outside [-π, π]")

    // shortcut for zero distance
    if x == y {
        return 0.0
    }

    let xLat = degree(fromRad: x.lat)
    let xLon = degree(fromRad: x.lon)
    let yLat = degree(fromRad: y.lat)
    let yLon = degree(fromRad: y.lon)

    var s12 = Double.nan
    var g: geod_geodesic = geod_geodesic()
    geod_init(&g, ellipsoid.a, ellipsoid.f)
    geod_inverse(&g, xLat, xLon, yLat, yLon, &s12, nil, nil)
    return s12
}
