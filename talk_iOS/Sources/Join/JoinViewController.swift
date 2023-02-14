//
//  JoinViewController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/02/06.
//. 회원가입 시 정보 입력 페이지 (프로필 사진, 이름)

import UIKit
import PhotosUI
import Alamofire

class JoinViewController: UIViewController {
    
    var nameInputText = ""
    var profileImageData:Data?
    let picker:PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.filter = .any(of: [.images, .screenshots, .panoramas])
        config.selectionLimit = 1
        return PHPickerViewController(configuration: config)
    }()
    
    
    // 기본 회색 이미지
//    let basicProfileImage:UIView = {
//        let view = UIView()
//        view.backgroundColor = .TalkLightGray
//        view.layer.cornerRadius = 75
//        return view
//    }()
    
    class ProfileImage:UIView{
        
        let imageWidth = 150.0
        private let imageView:UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.isHidden = true
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .TalkLightGray
            self.layer.cornerRadius = imageWidth / 2
            imageView.layer.cornerRadius = imageWidth / 2
            self.addSubview(imageView)
            imageView.snp.makeConstraints{ make in
                make.width.height.equalTo(imageWidth)
                make.top.bottom.leading.trailing.equalToSuperview()
            }
        }
        
        func showImage(_ image:UIImage){
            imageView.image = image
            imageView.isHidden = false
        }
        
        func hideImage(){
            imageView.isHidden = true
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    let profileImage = ProfileImage()
    let cameraButton:UIView = {
        let view = UIView()
        let camera = UIImageView(image: UIImage(named: "cameraImage"))
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.addSubview(camera)
        camera.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
        return view
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .TalkFontBlack
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    let nameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름을 입력해주세요"
        tf.font = .systemFont(ofSize: 12, weight: .regular)
        return tf
    }()
    class ConfirmButton:UIView{
        let label = UILabel()
        var isActive = false {
            didSet{
                if isActive{
                    self.backgroundColor = .TalkRed
                    label.textColor = .white
                } else{
                    self.backgroundColor = .TalkLightGray
                    label.textColor = .TalkFontBlack
                }
            }
        }
        
        override init(frame:CGRect){
            super.init(frame: frame)
            self.backgroundColor = .TalkLightGray
            label.text = "확인"
            label.textColor = .TalkFontBlack
            self.addSubview(label)
            label.snp.makeConstraints{ make in
                make.centerX.centerY.equalToSuperview()
            }
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    let confirmButton = ConfirmButton()
    let indicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        configureView()
        self.nameTextField.delegate = self
        self.picker.delegate = self
    }

    private func setUpNaviBar(){
        self.navigationItem.title = "프로필 생성하기"
        self.navigationItem.hidesBackButton = true
    }
    
    private func configureView(){
        self.view.backgroundColor = .white
        
        // profileImage
        self.view.addSubview(profileImage)
        profileImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            make.width.height.equalTo(profileImage.imageWidth)
        }
        
        // cameraButton
        self.view.addSubview(cameraButton)
        cameraButton.snp.makeConstraints{ make in
            make.width.height.equalTo(32)
            make.bottom.equalTo(profileImage)
            make.trailing.equalTo(profileImage)
        }
        cameraButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadProfileAlert)))
        
        // nameLabel
        self.view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).inset(-80)
            make.leading.equalToSuperview().inset(20)
        }
        
        // nameTextField
        self.view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        //textFieldBottomLine
        let textFieldBottomLine = UIView()
        textFieldBottomLine.backgroundColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.4)
        self.view.addSubview(textFieldBottomLine)
        textFieldBottomLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.top.equalTo(nameTextField.snp.bottom).inset(-6)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
        // confirmButton
        self.view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        confirmButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapConfirmButton)))
        
        // indicatorView
        indicatorView.stopAnimating()
        self.view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func textFieldDidChange(){
        guard let text = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
        if text.count > 0{
            confirmButton.isActive = true
        } else{
            confirmButton.isActive = false
        }
        nameInputText = text
    }
    
    @objc func tapConfirmButton(){
        guard confirmButton.isActive else {return}
        if nameInputText.count > 15{ // 글자 수가 15자가 넘어가는지 검사
            checkNameAlert()
            return
        }
        self.indicatorView.startAnimating()
        // 서버에 업로드
        self.fetchServer(completionHandler: {[weak self] result in
            guard let self = self else {return}
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            switch result{
            case let .success(result):
                // 회원가입 성공, 홈에 보내기
                debugPrint(result)
            case let .failure(error):
                debugPrint("에러", error)
                let alert = UIAlertController(title: "Failed", message: "서버와의 연결이 불안정합니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        
        })
    }
    
    private func fetchServer(completionHandler:@escaping (Result<JoinResponseDataModel, Error>) -> Void){
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data"
        ]
        let parameters = [
            "email":"string",
            "name":"string"
        ]
        AF.upload(multipartFormData: {(MultipartFormData) in
            if let data = self.profileImageData{
                MultipartFormData.append(data, withName: "profileImage", fileName: "\("입력").png", mimeType: "입력")
            }
            for (key,value) in parameters{
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName:key)
            }
        }, to: "/user/join",method: .post, headers: header).responseData{ response in
            switch response.result{
            case let .success(data):
                do{
                    // decode
                    let result = try JSONDecoder().decode(JoinResponseDataModel.self, from: data)
                    completionHandler(.success(result))
                } catch{
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    @objc func uploadProfileAlert(){

        let alert = UIAlertController(title: "프로필 사진 변경", message: nil, preferredStyle: .actionSheet)
        let actions:[UIAlertAction] = [
            UIAlertAction(
                title: "앨범에서 선택",
                style: .default,
                handler: { _ in self.present(self.picker, animated: true, completion: nil) }
            ),
            UIAlertAction(
                title: "사진 삭제",
                style: .destructive,
                handler: { _ in self.resetProfileImage() }
            ),
            UIAlertAction(
                title: "취소",
                style: .cancel
            )
        ]
        actions.forEach{ action in
            alert.addAction(action)
        }
        present(alert,animated: true)
    }
    
  
    
    private func checkNameAlert(){
        let alert = UIAlertController(title: nil, message: "이름을 15자 이내로 작성해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert,animated: true)
    }
    
    private func resetProfileImage(){
        profileImage.hideImage()
        profileImageData = nil
    }
}
