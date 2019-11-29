//
//  MockTelloStateTests.swift
//  TelloSwiftTests
//
//  Created by Xuan Liu on 2019/11/27.
//  Copyright © 2019 Xuan Liu. All rights reserved.
//

import XCTest
@testable import TelloSwift

/// Tests started with Mock is using local UDP server,
/// while tests with Tello is against real Tello drone.
class MockTelloStateTests: XCTestCase {
    var telloServer: TelloSimulator!
    var tello: Tello!

    override func setUp() {
        tello = Tello()

        // mock address
        tello.telloAddress = "127.0.0.1"

        // mock as Tello
        telloServer = TelloSimulator(addr: "127.0.0.1", port: 8889)
        XCTAssertNoThrow(try telloServer!.start())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // cleanup the socket and event loop resources, if not called, UT would fail
        tello.cleanup()
        telloServer.stop()
        
        weak var tmpGroup = tello.group
        tello = nil
        telloServer = nil
        XCTAssertNil(tmpGroup) // check if tello has called deinit
    }

    func testGetSpeed() {
        XCTAssertEqual(tello.speed, 100)
    }

    func testHeight() {
        XCTAssertEqual(tello.height, 150)
    }

    func testTime() {
        XCTAssertEqual(tello.time, 6)
    }

    func testTemperature() {
        XCTAssertEqual(tello.temperature, "16~86C")
    }

    func testMinTemperature() {
        XCTAssertEqual(tello.minTemp, 16)
        XCTAssertNotEqual(tello.minTemp, 15.99)
        XCTAssertNotEqual(tello.minTemp, 16.01)
    }

    func testMaxTemperature() {
        XCTAssertEqual(tello.maxTemp, 86)
        XCTAssertNotEqual(tello.maxTemp, 86.01)
        XCTAssertNotEqual(tello.maxTemp, 85.99)
    }

    func testBattery() {
        XCTAssertEqual(tello.battery, 66)
    }

    func testAttitude() {
        XCTAssertEqual(tello.attitude, "pitch:0;roll:-1;yaw:0;")
    }

    func testAcceleration() {
        XCTAssertEqual(tello.acceleration, "agx:-5.00;agy:7.00;agz:-999.00;")
    }

    func testBaro() {
        XCTAssertEqual(tello.baro, -106.865509)
        XCTAssertNotEqual(tello.baro, -106.865508)
    }

    func testTof() {
        XCTAssertEqual(tello.tof, 655)
        XCTAssertNotEqual(tello.tof, 655.001)
    }

    func testWifi() {
        XCTAssertEqual(tello.wifiSNR, 90)
    }

    func testAngAcc() {
        XCTAssertEqual(tello.agx, -5.00)
        XCTAssertEqual(tello.agy, 7.00)
        XCTAssertEqual(tello.agz, -999.00)
    }

    func testAtt() {
        XCTAssertEqual(tello.pitch, 0)
        XCTAssertEqual(tello.roll, -1)
        XCTAssertEqual(tello.yaw, 0)
    }
}