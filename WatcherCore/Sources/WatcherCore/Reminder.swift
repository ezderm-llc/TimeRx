//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import Foundation

public struct Reminder: Hashable {
    public init(date: Date) {
        self.date = date
    }

    public var date: Date
}
