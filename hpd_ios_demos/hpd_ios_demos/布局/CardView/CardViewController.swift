//
//  CardViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/6.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    static func newInstance() -> CardViewController {
        return CardViewController(nibName: "CardViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
