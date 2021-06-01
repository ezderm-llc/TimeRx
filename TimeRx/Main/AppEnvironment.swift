//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import Foundation
import CombineSchedulers

struct AppEnvironment {
    var dateFormatter: () -> DateFormatter
    var numberFormatter: () -> NumberFormatter
    var idGenerator: () -> UUID
    var sheduler: () -> AnySchedulerOf<DispatchQueue>
}

extension AppEnvironment {
    static var live = AppEnvironment { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    } numberFormatter: { () -> NumberFormatter in
        NumberFormatter()
    } idGenerator: { () -> UUID in
        UUID()
    } sheduler: {
        DispatchQueue.main.eraseToAnyScheduler()
    }
}
