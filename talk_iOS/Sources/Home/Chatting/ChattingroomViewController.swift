//
//  ChattingroomViewController.swift
//  talk_iOS
//
//  Created by 경유진 on 2023/01/09.
//
// 텍스트필드 - msgTextField , 전송버튼 - sendButton

import UIKit
import SnapKit
import Photos

class ChattingroomViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTitle()
        self.leftButton()
        self.rightButton()
        setUpView()
        setConstraints()
        
        chattingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        imgPickerController.delegate = self
        
        //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    
    // 네비게이션
    // 네비게이션 타이틀
    func initTitle() {
        view.backgroundColor = .white

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
        let backButton =  UIBarButtonItem(image: UIImage(named: "btnBack"), style: .done, target: self, action: #selector(backChattingList))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backChattingList() {
        self.navigationController?.popViewController(animated: true)
        print("전 페이지로")
    }
    // 햄버거 버튼
    func rightButton() {
        let hamburgerButton =  UIBarButtonItem(image: UIImage(named: "btnSearch"), style: .done, target: self, action: #selector(modalMemberList))
        hamburgerButton.tintColor = .black
        navigationItem.rightBarButtonItem = hamburgerButton
    }
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    @objc func modalMemberList() {
        let memberVC = MemberListViewController()
        memberVC.modalPresentationStyle = .custom
        memberVC.transitioningDelegate = slideInTransitioningDelegate
        self.present(memberVC, animated: true, completion: nil)
    }
    
    // chatting Table View
    private let chattingTableView: UITableView = {
        let chattingTableView = UITableView()
        return chattingTableView
    }()
    
    let bubble: [BubbleData] = [
                                BubbleData(userName: "사용자A", messageContent: "안녕하세요")/*,
                                BubbleData(userName: "사용자B", messageContent: "아아아ㅏ아아아아아아아아아아아아아아아아아아아아아아아 아아아아앙아아아아아아아앙아아앙아아아아앙아아아아"),
                                BubbleData(userName: "사용자B", messageContent: "아아아ㅏ아아아아아아아아아아아아아아아아아아아아아아아 아아아아앙아아아아아아아앙아아앙아아아아앙아아아아"),
                                BubbleData(userName: "사용자B", messageContent: "아아아ㅏ아아아아아아아아아아아아아아아아아아아아아아아 아아아아앙아아아아아아아앙아아앙아아아아앙아아아아"),
                                BubbleData(userName: "사용자B", messageContent: "아아아ㅏ아아아아아아아아아아아아아아아아아아아아아아아 아아아아앙아아아아아아아앙아아앙아아아아앙아아아아"),
                                BubbleData(userName: "사용자B", messageContent: "아아아ㅏ아아아아아아아아아아아아아아아아아아아아아아아 아아아아앙아아아아아아아앙아아앙아아아아앙아아아아"),
                                BubbleData(userName: "사용자B", messageContent: "아아아ㅏ아아아아아아아아아아아아아아아아아아아아아아아 아아아아앙아아아아아아아앙아아앙아아아아앙아아아아")*/
                                ]
    
    func attribute() {
        chattingTableView.register(ChattingBubbleCell.classForCoder(), forCellReuseIdentifier: ChattingBubbleCell.chattingBubbleCell)
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bubble.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChattingBubbleCell.chattingBubbleCell, for: indexPath) as! ChattingBubbleCell
        cell.userNameLabel.text = bubble[indexPath.row].userName
        cell.messageLabel.text = bubble[indexPath.row].messageContent
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // bottom View
    lazy var imageButton: UIButton = {
        let imageButton = UIButton()
        let imageButtonImg = UIImage(named: "btnImage.png")
        imageButton.setBackgroundImage(imageButtonImg, for: .normal)
        imageButton.addTarget(self, action: #selector(selectImg), for: .touchUpInside)
        return imageButton
    }()
    
    let imgPickerController = UIImagePickerController()
    @objc func selectImg(sender: UIButton!) {
        print("버튼 클릭")
        
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
        /*sendButton.snp.makeConstraints { make in
            make.width.height.equalTo(31.16)
        }*/
        //sendButton.addTarget(self, action: "sendMessage", for: .touchUpInside)
        textField.rightView = sendButton
        textField.rightViewMode = .whileEditing
        
        return textField
    }()
    
    let chatCustomView: CustomView = CustomView()
    lazy var bottomViewLine = chatCustomView.setLine
    
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        
        bottomViewLine.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        bottomView.addSubview(bottomViewLine)
        bottomView.addSubview(imageButton)
        bottomView.addSubview(textField)
        return bottomView
    }()
    
    func setUpView() {
        self.view.addSubview(chattingTableView)
        self.view.addSubview(bottomView)
        self.attribute()
    }
    
    func setConstraints() {
        chattingTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(44)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(chattingTableView.snp.bottom)
            make.right.left.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-11)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        imageButton.snp.makeConstraints { make in
            //make.width.height.equalTo(18)
            make.top.equalToSuperview().offset(13.19)
            make.right.equalTo(self.textField.snp.left).offset(-13.58)
            make.left.equalToSuperview().offset(15.58)
            make.bottom.equalToSuperview().offset(-13.98)
        }
        bottomViewLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.right.left.equalToSuperview()
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


class MemberListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}



import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ChattingroomViewController
    
    func makeUIViewController(context: Context) -> ChattingroomViewController {
            return ChattingroomViewController()
        }

        func updateUIViewController(_ uiViewController: ChattingroomViewController, context: Context) {
        }
}

@available(iOS 16.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
            ViewControllerRepresentable()
    }
}

