//
//  ChattingroomViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/09.
//
// 텍스트필드 - msgTextField , 전송버튼 - sendButton

import UIKit
import SnapKit

class ChattingroomViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTitle()
        self.leftButton()
        self.rightButton()
        setUpView()
        setConstraints()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    
    // 네비게이션
    // 네비게이션 타이틀
    func initTitle() {
        view.backgroundColor = .white

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
    // 뒤로가기 버튼
    func leftButton() {
        let backButton =  UIBarButtonItem(image: UIImage(named: "Vector.png"), style: .done, target: self, action: nil)
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    // 검색 버튼
    func rightButton() {
        let searchButton =  UIBarButtonItem(image: UIImage(named: "Vector-2.png"), style: .done, target: self, action: nil)
        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton
    }
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    
    
    
    
    
    lazy var plusButton: UIButton = {
        let plusButton = UIButton()
        let plusimage = UIImage(named: "Vector-3.png")
        plusButton.setBackgroundImage(plusimage, for: .normal)
        plusButton.addTarget(self, action: #selector(openview), for: .touchUpInside)
        return plusButton
    }()
    
    lazy var menuView: UIView = {
        let menuView = UIView()
        
        return menuView
    }()
    
    @objc func openview(sender: UIButton!) {
        print("버튼 클릭")
        self.plusButton.transform = CGAffineTransform(rotationAngle: .pi * 0.25)
    }
    

    lazy var textField: UITextField = {
        
        let textField = UITextField()
        
        // placeholder
        textField.placeholder = "메시지를 입력하세요."
        
        // Set Delegate to itself
        textField.delegate = self
        
        // Display frame.
        textField.layer.cornerRadius = 17.5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.2).cgColor
            
        // 왼쪽 여백
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftViewMode = .always
        
        // 오른쪽 버튼
        let sendButton = UIButton()
        let sendimage = UIImage(named: "send.png")
        sendButton.setBackgroundImage(sendimage, for: .normal)
        sendButton.frame = CGRectMake(0,0, 20, 20)
        //sendButton.addTarget(self, action: "sendMessage", for: .touchUpInside)
        textField.rightView = sendButton
        textField.rightViewMode = .whileEditing
        
        return textField
    }()
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.layer.borderWidth = 1.0
        bottomView.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        bottomView.addSubview(plusButton)
        bottomView.addSubview(textField)
        return bottomView
    }()
    
    func setUpView() {
        self.view.addSubview(tableView)
        self.view.addSubview(bottomView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(44)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.right.left.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        textField.snp.makeConstraints { make in
            make.width.equalTo(333)
            make.height.equalTo(35)
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-11)
            make.bottom.equalToSuperview().offset(-5)
        }
        plusButton.snp.makeConstraints { make in
            //make.width.height.equalTo(18)
            make.top.equalToSuperview().offset(13.19)
            make.right.equalTo(self.textField.snp.left).offset(-13.58)
            make.left.equalToSuperview().offset(15.58)
            make.bottom.equalToSuperview().offset(-13.98)
        }
    }
    

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
    
    // Return키 눌렀을 때 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // TextField 비활성화
            return true
    }
}
/*
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ChattingroomViewController
    
    func makeUIViewController(context: Context) -> ChattingroomViewController {
            return ChattingroomViewController()
        }

        func updateUIViewController(_ uiViewController: ChattingroomViewController, context: Context) {
        }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}
*/
