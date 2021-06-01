//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import WatcherCore
import Foundation

class ReminderDetailViewModel {
    var date =  Date()
    var isScheduled: Bool = false
    
    var completion: (Reminder?, Bool) -> Void
    
    init(completion: @escaping (Reminder?, Bool) -> Void) {
        self.completion = completion
    }
    
    func done() {
        completion(Reminder(date: date), isScheduled)
    }
    
    func cancel() {
        completion(nil, false)
    }
    
}
