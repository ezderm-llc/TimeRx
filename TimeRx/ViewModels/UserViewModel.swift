//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import WatcherCore
import Foundation

class UserViewModel {
    private(set) var reminders: [ReminderViewModel] = []
    private var user: User
    private var dateFormatter: DateFormatter
    
    var onUserChanged: (() -> Void)?
    
    init(_ user: User, dateFormatter: DateFormatter) {
        self.user = user
        self.dateFormatter = dateFormatter
        self.user.onChange = userChanged
        updateReminders(user, dateFormatter)
    }
    
    private func userChanged() {
        updateReminders(user, dateFormatter)
        onUserChanged?()
    }
    
    private func updateReminders(_ user: User, _ dateFormatter: DateFormatter) {
        reminders = user.reminders.map { reminder in
            ReminderViewModel(title: dateFormatter.string(from: reminder.date), isScheduled: user.reminderIsScheduled(reminder)) { value in
                switch value {
                case true:
                    user.scheduleRemider(reminder)
                case false:
                    user.unscheduleRemider(reminder)
                }
            }
        }
    }
    
    func newReminder() {
        user.createReminder()
    }
}
