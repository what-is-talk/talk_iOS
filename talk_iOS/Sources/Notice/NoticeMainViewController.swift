//
//  MyPageViewController.swift
//  talk_iOS
//
//  Created by User on 2023/01/13.
//

import UIKit
import CoreData

class NoticeMainViewController: UIViewController {
    
    static let identifier = "NoticeMainViewController"
    var container:NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
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
