import XCTest
@testable import geodesic

// some constants

private let zero = (lat: 0.0, lon: 0.0)
private let northPole = (lat: Double.pi / 2, lon: 0.0)
private let southPole = (lat: -Double.pi / 2, lon: 0.0)
private let grs80 = (a: 6378137.0, f: 1 / 298.257222100882711)
private let pi: Double = Double.pi

/// - Returns: degree converted to radians
private func rad<T: BinaryFloatingPoint>(fromDegree d: T) -> T {
    return d * T.pi / 180
}

/// extension for convenience
private extension BinaryFloatingPoint {
    /// degree converted to radians
    var asRad: Self {
        return rad(fromDegree: self)
    }
}

final class GeodesicTests: XCTestCase {

    func testShortcutForEqualPoints() {
        // make sure, points are equal and not identical, to check if the shortcut works correctly
        XCTAssertEqual(distance(zero, (lat: 0.0, lon: 0.0)), 0.0)
    }

    /// some simple tests to make sure the results are in the right ballpark.
    func testDistance() {
        let delta = 1e-3
        var x: (lat: Double, lon: Double), y: (lat: Double, lon: Double)

        x = (lat: 0.asRad, lon: 0.asRad)
        y = (lat: 0.asRad, lon: 0.asRad)
        XCTAssertEqual(distance(x, y), 0.0, accuracy: delta)

        x = (lat: 0.asRad, lon: 0.asRad)
        y = (lat: 1.asRad, lon: 0.asRad)
        XCTAssert(abs(distance(x, y) - 110574.389) < delta)

        x = (lat: 0.asRad, lon: 0.asRad)
        y = (lat: 2.asRad, lon: 0.asRad)
        XCTAssertEqual(distance(x, y), 221149.453, accuracy: delta)

        x = (lat: 0.5.asRad, lon: 0.asRad)
        y = (lat: -0.5.asRad, lon: 0.asRad)
        XCTAssertEqual(distance(x, y), 110574.304, accuracy: delta)

        x = (lat: -0.5.asRad, lon: 0.asRad)
        y = (lat: 0.5.asRad, lon: 0.asRad)
        XCTAssertEqual(distance(x, y), 110574.304, accuracy: delta)

        x = (lat: 0.asRad, lon: 0.asRad)
        y = (lat: 0.asRad, lon: 1.asRad)
        XCTAssertEqual(distance(x, y), 111319.491, accuracy: delta)

        x = (lat: 0.asRad, lon: 0.asRad)
        y = (lat: 0.asRad, lon: 2.asRad)
        XCTAssertEqual(distance(x, y), 222638.982, accuracy: delta)

        x = (lat: 0.asRad, lon: 0.5.asRad)
        y = (lat: 0.asRad, lon: -0.5.asRad)
        XCTAssertEqual(distance(x, y), 111319.491, accuracy: delta)

        x = (lat: 0.asRad, lon: -0.5.asRad)
        y = (lat: 0.asRad, lon: 0.5.asRad)
        XCTAssertEqual(distance(x, y), 111319.491, accuracy: delta)
    }

#if os(Linux)
    static var allTests = [
        ("testDistance", testDistance),
        ("testShortcutForEqualPoints", testShortcutForEqualPoints),
    ]
#endif
}
