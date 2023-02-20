//
//  voteCreateViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/20.
//

import UIKit

class voteCreateViewController: UIViewController {

    static let identifier = "voteCreateViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "투표 만들기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneAndBackToVotePage))

    }
    
    @objc func doneAndBackToVotePage() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
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
