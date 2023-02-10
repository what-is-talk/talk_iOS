//
//  MemberInviteViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/10.
//

import UIKit

class MemberInviteViewController: UIViewController {
    static let identifier = "MemberInviteViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "초대코드"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
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
