//
//  HCPRefreshViewController.swift
//  hpd_ios_demos
//
//  Created by huangpeidong on 2019/9/12.
//  Copyright © 2019 hpd. All rights reserved.
//

import UIKit
import SnapKit

class HCPRefreshViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var touchView: HCPTouchView!
    @IBOutlet weak var lbFresh: UILabel!
    
    static func newInstance() -> HCPRefreshViewController {
        return HCPRefreshViewController(nibName: "HCPRefreshViewController", bundle: nil)
    }
    
    @IBAction func endRefleshClick(_ sender: Any) {
        touchView.back()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        tableView.bounces = false
        tableView.dataSource = self
        tableView.delegate = self
        
        let header = UIView()
        header.backgroundColor = .red
        header.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        tableView.tableHeaderView = header
        
//        tableView.isScrollEnabled = false
        
//        let gs = HCTapGestureRecognizer()
////        gs.cancelsTouchesInView = false
//        gs.delaysTouchesEnded = false
//        tableView.addGestureRecognizer(gs)
  
        touchView.callBack = { value in
            self.lbFresh.text = value
        }
    }
}


extension HCPRefreshViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HCPTouchTableViewCell(style: .subtitle, reuseIdentifier: "ss")
        return cell
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan 11")
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved 11")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded 11")
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("scrollViewDidScrollToTop")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
        print("scrollViewDidScroll scrollView.contentOffset.y=\(scrollView.contentOffset.y)")
        
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
    }
}
