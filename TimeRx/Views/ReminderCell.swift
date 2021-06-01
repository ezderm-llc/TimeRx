//
//  Created by Daniel Moro on 1.6.21.
//  Copyright © 2021 EZDERM, LLC. All rights reserved.
//  

import UIKit

class ReminderCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var switchControl: UISwitch?
    
    var onSwitchValueChanged: ((Bool)-> Void)?
    
    @IBAction private func switchValueChanged() {
        onSwitchValueChanged?(self.switchControl?.isOn ?? false)
    }
}
