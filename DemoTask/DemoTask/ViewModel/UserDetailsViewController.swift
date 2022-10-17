//
//  UserDetailsViewController.swift
//  DemoTask
//
//  Created by Sri on 17/10/22.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var userdetail: UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = userdetail?.name
        companyLabel.text = userdetail?.attack_type
        locationLabel.text = userdetail?.primary_attr
        
    }
}
