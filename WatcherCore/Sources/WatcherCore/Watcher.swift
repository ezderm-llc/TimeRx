//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//

import Combine
import CombineSchedulers

class Watcher {
    var count: Int {
        reminders.count
    }

    var reminders: [Reminder: Cancellable] = [:]

    private var router: Router

    init(scheduler: AnySchedulerOf<DispatchQueue>, router: Router) {
        self.scheduler = scheduler
        self.router = router
    }

    func scheduleReminder(_ reminder: Reminder) {
        let difference = reminder.date.timeIntervalSinceNow
        let subscription = scheduler.schedule(
            after: scheduler.now.advanced(by: .seconds(difference)),
            interval: .zero
        ) { [weak self] in
            self?.reminders.removeValue(forKey: reminder)
            self?.router.navigateToReminder(reminder)
        }

        reminders[reminder] = subscription
    }

    func unscheduleReminder(_ reminder: Reminder) {
        reminders.removeValue(forKey: reminder)
    }

    private var scheduler: AnySchedulerOf<DispatchQueue>
}
