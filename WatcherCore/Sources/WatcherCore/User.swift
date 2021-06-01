//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import CombineSchedulers
import Foundation

public class User {
    public init(router: Router, scheduler: AnySchedulerOf<DispatchQueue>, reminders: [Reminder]? = nil) {
        self.router = router
        watcher = Watcher(scheduler: scheduler, router: router)
        self.reminders = reminders ?? []
    }

    public var onChange: (()->Void)?
    public private(set) var reminders: [Reminder] = [] {
        didSet {
            self.onChange?()
        }
    }
    public func reminderIsScheduled(_ reminder: Reminder) -> Bool {
        watcher.reminders.keys.contains(reminder)
    }

    private let router: Router
    private let watcher: Watcher

    public func createReminder() {
        router.navigateToNewReminder { [weak self] newReminder, isActive in
            if let newReminder = newReminder {
                guard let self = self else { return }
                self.reminders.append(newReminder)
                if isActive {
                    self.scheduleRemider(newReminder)
                }
                
            }
        }
    }

    public func start() {
        router.navigateToUser(self)
    }

    public func scheduleRemider(_ reminder: Reminder) {
        watcher.scheduleReminder(reminder)
        onChange?()
    }

    public func unscheduleRemider(_ reminder: Reminder) {
        watcher.unscheduleReminder(reminder)
        onChange?()
    }

    public func deleteReminder(_ reminder: Reminder) {
        watcher.unscheduleReminder(reminder)
        reminders.removeAll(where: { $0 == reminder })
    }
}
