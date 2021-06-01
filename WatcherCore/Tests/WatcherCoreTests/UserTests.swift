//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//  

import XCTest
import CombineSchedulers
import WatcherCore

class UserTests: XCTestCase {
    func test_start_navigatesToUserHome() throws {
        let (sut, router) = makeSUT()

        sut.start()

        XCTAssertEqual(router.routes[0], "user home")
    }

    func test_createReminder_navigatesToNewReminderAndSchedulesReminderInWatcher() throws {
        let (sut, router) = makeSUT()
        let expectedReminder = Reminder(date: Date())
        router.newReminderCompletion = {
            return (expectedReminder, true)
        }

        sut.start()
        sut.createReminder()


        XCTAssertTrue(sut.reminderIsScheduled(expectedReminder))
        XCTAssertEqual(router.routes, ["user home", "new reminder"])
    }

    func test_deleteReminder_collectionCountDecremets() {
        let (sut, _) = makeSUT(reminders: [Reminder(date: Date())])

        XCTAssertEqual(sut.reminders.count, 1)

        sut.deleteReminder(sut.reminders[0])

        XCTAssertEqual(sut.reminders.count, 0)
    }

    func test_deleteScheduledReminder_reminderIsUnscheduledInWatcher() {
        let reminder = Reminder(date: Date())
        let (sut, _) = makeSUT(reminders: [reminder])
        sut.scheduleRemider(reminder)

        XCTAssertEqual(sut.reminders.count, 1)

        sut.deleteReminder(sut.reminders[0])

        XCTAssertEqual(sut.reminders.count, 0)
        XCTAssertFalse(sut.reminderIsScheduled(reminder))
    }

    // ----------------------- HELPERS -----------------------

    private func makeSUT(reminders: [Reminder]? = nil) -> (
        User,
        RouterSpy
    ) {
        let router = RouterSpy()
        let scheduler = DispatchQueue.test
        let user = User(router: router, scheduler: AnyScheduler(scheduler), reminders: reminders)

        return (user, router)
    }
}
