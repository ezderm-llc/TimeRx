//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import UIKit

class UserViewController: UIViewController {
    
    private var viewModel: UserViewModel
    
    @IBOutlet var tableView: UITableView?
    
    init?(coder: NSCoder, viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
        self.viewModel.onUserChanged = { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addButtonTap() {
        viewModel.newReminder()
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as! ReminderCell
        let viewModel = viewModel.reminders[indexPath.row]
        cell.titleLabel?.text = viewModel.title
        cell.switchControl?.isOn = viewModel.isScheduled
        cell.onSwitchValueChanged = viewModel.onSchedule
        
        return cell
    }
}

extension UserViewController: UITableViewDelegate {
    
}

