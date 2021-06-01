//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//

import Foundation
@testable import WatcherCore

class RouterSpy: Router {
    var routes: [String] = []
    var newReminderCompletion: () -> (Reminder?, Bool) = { (nil, false) }

    func navigateToUser(_: User) {
        routes.append("user home")
    }

    func navigateToReminder(_ reminder: Reminder) {
        let desc = String(describing: reminder)
        routes.append(desc)
    }

    func navigateToNewReminder(_ completion: @escaping (Reminder?, Bool) -> Void) {
        routes.append("new reminder")
        let result = newReminderCompletion()
        completion(result.0, result.1)
    }
}
