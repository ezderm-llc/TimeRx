//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import Foundation

public protocol Router {
    func navigateToReminder(_ reminder: Reminder)
    func navigateToUser(_ user: User)
    func navigateToNewReminder(_ completion: @escaping (Reminder?, Bool) -> Void)
}

//#if DEBUG
//    public class EmptyRouter: Router {
//        public init() {}
//
//        public func navigateToReminder(_: Reminder) {
//            fatalError()
//        }
//
//        public func navigateToUser(_: User) {
//            fatalError()
//        }
//
//        public func navigateToNewReminder(_: @escaping (Reminder?, Bool) -> Void) {
//            fatalError()
//        }
//    }
//#endif
