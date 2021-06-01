//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import UIKit
import WatcherCore

final class NavigationRouter {
    private let navigationController: UINavigationController
    private let environment: AppEnvironment
    
    init(navigationController: UINavigationController, environment: AppEnvironment) {
        self.navigationController = navigationController
        self.environment = environment
    }
}

extension NavigationRouter: Router {
    func navigateToReminder(_ reminder: Reminder) {
        
    }
    
    func navigateToUser(_ user: User) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewModel = UserViewModel(user, dateFormatter: environment.dateFormatter())
        let vc = sb.instantiateViewController(identifier: "UserViewController") { coder in
            UserViewController(coder: coder, viewModel: viewModel)
        }
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func navigateToNewReminder(_ completion: @escaping (Reminder?, Bool) -> Void) {
        let viewModel = ReminderDetailViewModel(completion: completion)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ReminderDetailViewController") { coder in
            ReminderDetailViewController(coder: coder, viewModel: viewModel)
        }
        
        let nc = UINavigationController(rootViewController: vc)
        navigationController.present(nc, animated: true, completion: nil)
    }
}
