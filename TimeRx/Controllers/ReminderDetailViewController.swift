//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import UIKit

class ReminderDetailViewController: UITableViewController {
    private var viewModel: ReminderDetailViewModel
    
    init?(coder: NSCoder, viewModel: ReminderDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func doneButtonTapped() {
        let done = viewModel.done
        dismiss(animated: true) {
            done()
        }
    }
    
    @IBAction func cancelButtonTapped() {
        let cancel = viewModel.cancel
        dismiss(animated: true) {
            cancel()
        }
        
    }
    
    @IBAction func datePickedValueChagned(_ sender: UIDatePicker) {
        viewModel.date = sender.date
    }
    
    @IBAction func switchControlValueChanged(_ sender: UISwitch) {
        viewModel.isScheduled = sender.isOn
    }
}
