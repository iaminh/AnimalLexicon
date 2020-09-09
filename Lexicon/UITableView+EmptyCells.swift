//  Created by Minh Chu on 05.03.15.
//  Copyright © 2016 Minh Chu. All rights reserved.
//
import UIKit

extension UITableView {
    
    func hideEmptyCells()
    {
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
}
