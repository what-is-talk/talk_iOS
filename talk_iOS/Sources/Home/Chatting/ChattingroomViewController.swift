//
//  ChattingroomViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/09.
//

import UIKit
import SnapKit
import Alamofire
// 안녕,,,
class ChattingroomViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTitle()
        self.leftButton()
        self.rightButton()
        //self.msgfield()
        
        self.msgTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))

    }
    
    // 네비게이션 타이틀
    func initTitle() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 16)
        topTitle.textColor = UIColor(red: 235/255, green: 47/255, blue: 48/255, alpha: 1)
        topTitle.text = "채팅방 이름"
        
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 13)
        subTitle.textColor = UIColor(red: 24/255, green: 20/255, blue: 65/255, alpha: 1)
        subTitle.text = "모임명"
        
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        self.navigationItem.titleView = containerView
    }
    
    func leftButton() {
        let backButton =  UIBarButtonItem(image: UIImage(named: "Vector.png"), style: .done, target: self, action: nil)
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    func rightButton() {
        let searchButton =  UIBarButtonItem(image: UIImage(named: "Vector-2.png"), style: .done, target: self, action: nil)
        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // ? 뭔가 이상함
    /*
    func msgfield() {
        msgTextField.layer.backgroundColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1).cgColor
        msgTextField.layer.cornerRadius = 30
        msgTextField.layer.borderWidth = 1
        msgTextField.layer.borderColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.2).cgColor
    }
    */
    
    // 키보드 변경 확인하는 옵져버를 등록
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 옵저버 없애기
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드 올라갔을 때
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
       
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    // 키보드 내려갔을 때 : 원래대로
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
    // 화면 터치시 키보드 내려가기
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
    // 전송 버튼 숨기기&나타내기
    
}
