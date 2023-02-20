//
//  VoteSpecifyViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/20.
//

import UIKit

class VoteSpecifyViewController: UIViewController {

    
    static let identifier = "VoteSpecifyViewController"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "투표 현황"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제하기", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tap))
    }
    
    @objc func tap(){
        print("클릭")
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
