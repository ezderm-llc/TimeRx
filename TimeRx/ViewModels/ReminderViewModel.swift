//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import WatcherCore
import Foundation

class ReminderViewModel {
    var title: String
    var isScheduled: Bool
    var onSchedule: (Bool)-> Void
    
    init(title: String, isScheduled: Bool, onScheduleChange: @escaping (Bool) -> Void) {
        self.title = title
        self.isScheduled = isScheduled
        self.onSchedule = onScheduleChange
    }
}
