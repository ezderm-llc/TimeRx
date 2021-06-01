//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//

import XCTest
import CombineSchedulers
@testable import WatcherCore

final class WatcherTests: XCTestCase {
    func test_scheduleReminder_activeRemindersAreIncrementedByOne() {
        let (sut, _, _) = makeSUT()

        let reminder = Reminder(date: Date())
        sut.scheduleReminder(reminder)

        XCTAssertEqual(sut.count, 1)

        let reminder2 = Reminder(date: Date())
        sut.scheduleReminder(reminder2)

        XCTAssertEqual(sut.count, 2)
    }
    
    func test_scheduleReminderTwice_activeRemindersAreNotIncremented() {
        let (sut, _, _) = makeSUT()
        let reminder = Reminder(date: Date())

        sut.scheduleReminder(reminder)

        XCTAssertEqual(sut.count, 1)

        sut.scheduleReminder(reminder)

        XCTAssertEqual(sut.count, 1)
    }
    
    func test_unscheduleReminder_activeRemindersAreDecrementedByOneAndEventIsNotFired() {
        let (sut, scheduler, router) = makeSUT()

        let expectedDate = Date().advanced(by: 1000)
        let reminder = Reminder(date: expectedDate)
        sut.scheduleReminder(reminder)

        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(router.routes.count, 0)

        scheduler.advance(by: .seconds(500))

        sut.unscheduleReminder(reminder)

        XCTAssertEqual(sut.count, 0)

        scheduler.advance(by: .seconds(500))

        XCTAssertEqual(router.routes.count, 0)
    }
    
    func test_onDue_routedToReminderNotification() {
        let (sut, scheduler, router) = makeSUT()

        let expectedDate = Date().advanced(by: 1000)
        let reminder = Reminder(date: expectedDate)
        let expectedDate2 = Date().advanced(by: 2000)
        let reminder2 = Reminder(date: expectedDate2)

        sut.scheduleReminder(reminder)
        sut.scheduleReminder(reminder2)

        scheduler.advance(by: .seconds(1000))

        XCTAssertEqual(router.routes.count, 1)
        XCTAssertEqual(router.routes[0], String(describing: reminder))

        scheduler.advance(by: .seconds(1000))

        XCTAssertEqual(router.routes.count, 2)
        XCTAssertEqual(router.routes[1], String(describing: reminder2))
    }
    
    func test_onDeinit_scheduledRemindersAreNotFired() {
        let scheduler = DispatchQueue.test
        let router = RouterSpy()
        var sut: Watcher? = Watcher(scheduler: AnyScheduler(scheduler), router: router)

        let expectedDate = Date().advanced(by: 1000)
        let reminder = Reminder(date: expectedDate)
        let expectedDate2 = Date().advanced(by: 2000)
        let reminder2 = Reminder(date: expectedDate2)

        sut?.scheduleReminder(reminder)
        sut?.scheduleReminder(reminder2)

        scheduler.advance(by: .seconds(1000))

        XCTAssertEqual(router.routes.count, 1)

        sut = nil

        scheduler.advance(by: .seconds(1000))

        XCTAssertEqual(router.routes.count, 1)
    }
    
    // ----------------------- HELPERS -----------------------

    private func makeSUT() -> (
        Watcher,
        TestScheduler<DispatchQueue.SchedulerTimeType, DispatchQueue.SchedulerOptions>,
        RouterSpy
    ) {
        let router = RouterSpy()
        let scheduler = DispatchQueue.test
        let watcher = Watcher(scheduler: AnyScheduler(scheduler), router: router)

        return (watcher, scheduler, router)
    }
}
