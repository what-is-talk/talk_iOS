//
//  VoteViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/19.
//

import UIKit
import Alamofire

class VoteSpecifyViewController: UIViewController {
    
    @objc func tap(){
        print("클릭")
    }
    
    var memberNameLabelValue : String = ""
    var dateLabelValue : String = ""
    var voteNameValue : String = ""
    var voteDescriptionValue : String = ""
    var selectCountValue : Int = 0
    var voteID : Int = 0
    var participants : Int = 0
    var multiSelectionValue : Bool = false

    struct Root: Decodable {
        let data : VoteStruct
    }
    
    struct VoteStruct: Decodable {
        let voteId : Int
        let categories: [categoryStruct]
    }
    
    struct categoryStruct : Decodable{
        let name: String
        let member: [memberStruct]
    }
    
    struct memberStruct : Decodable{
        let id : Int
        let name : String
        let profileImage : String
    }
    
    var voteSpecify = VoteStruct(voteId: 0, categories: [])
    
    static let identifier = "VoteSpecifyViewController"
    
    private let semaphore = DispatchSemaphore(value: 0)

    
    func getTest() {
        let url = "https://what-is-talk-test.vercel.app/api/vote/select?voteId=\(voteID)"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseData{ response in
                switch response.result {
                case let .success(data):
                    do{
                        let result = try JSONDecoder().decode(Root.self, from: data).data
                        self.voteSpecify = result
                        self.updateCategories()
                        self.layout()

                    } catch{
                        print(error)

                    }

                case .failure(let err):
                    print(err)

                }
            }
    }
    
    var categories: [VoteStackViewCellClass] = [] {
        didSet {
            updateCategoriesLayout()
        }
    }
    
    func updateCategories() {
        let categorData:[VoteStackViewCellClass] = voteSpecify.categories.map{
            return VoteStackViewCellClass.init(voteCategoryLabel: $0.name, selectCount: $0.member.count, participants : participants, multiSelection: multiSelectionValue)
        }
        categories = categorData
    }
    
    func updateCategoriesLayout() {
        categories.forEach { category in
            voteStackView.addArrangedSubview(category)
            category.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(35)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getTest()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제하기", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tap))
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "투표 현황"
        self.memberNameLabel.text = memberNameLabelValue
        self.dateLabel.text = dateLabelValue
        self.voteName.text = voteNameValue
        self.voteDescription.text = voteDescriptionValue
        getParticipants()
        let categorData:[VoteStackViewCellClass] = voteSpecify.categories.map{
            return VoteStackViewCellClass.init(voteCategoryLabel: $0.name, selectCount: $0.member.count, participants : participants, multiSelection: multiSelectionValue)
        }
        categories = categorData
        updateCategoriesLayout()
    }

    func getParticipants(){
        let n = voteSpecify.categories.count
        for i in 0..<n{
            participants = participants + voteSpecify.categories[i].member.count
            print(voteSpecify.categories[i].member.count)
        }
        print(participants)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @objc func addButton(){
        print("클릭했다.")
        pushViewController(target: self, storyBoardName: "Vote", identifier: VoteCreateViewController
            .identifier)
    }
    
    
    var myView : UIView = {
        let myView = UIView()
        myView.backgroundColor = .white
        myView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
        myView.layer.cornerRadius = 8.0
        myView.layer.shadowOpacity = 1
        myView.layer.shadowRadius = 8.0
        myView.layer.shadowOffset = CGSize(width: 0, height: 0)
        myView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    var profileImage:UIImageView = {
        let profileImage = UIImageView()
        profileImage.backgroundColor = .gray
        profileImage.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    var memberNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        label.text = "테스트"
       return label
    }()
    
    var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
       return label
    }()
    
    
    
    var voteInnerView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        return view
    }()
    
    var voteName : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
       return label
    }()
    
    var voteDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        // 텍스트에 맞게 조절된 사이즈를 가져와 height만 fit하게 값을 조절.
        let newSize = label.sizeThatFits( CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame.size = newSize
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
       return label
    }()
    
    var voteStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    var voteView : UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.setTitle("투표하기", for: .normal)
        return view
    }()
    

    
    func layout(){
        view.addSubview(myView)
        myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        [profileImage,memberNameLabel,dateLabel, voteInnerView].forEach{
            myView.addSubview($0)
            }
        profileImage.snp.makeConstraints{
                $0.width.height.equalTo(32)
                $0.leading.equalToSuperview().inset(25)
                $0.top.equalToSuperview().inset(140)
            }

        memberNameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).inset(-16)
            }
        dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(profileImage.snp.bottom)
            $0.leading.equalTo(memberNameLabel)
            }
        voteInnerView.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).inset(-19)
                $0.bottom.equalToSuperview().inset(32)
                $0.leading.equalToSuperview().inset(25)
                $0.trailing.equalToSuperview().inset(25)
            }
        
        [voteName,voteDescription,voteStackView, voteView].forEach{
            voteInnerView.addSubview($0)
            }
            
        voteName.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
            }
        voteDescription.snp.makeConstraints{
            $0.top.equalTo(voteName.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            }
        voteStackView.snp.makeConstraints{
            $0.top.equalTo(voteDescription.snp.bottom).inset(-19)
            $0.leading.trailing.equalToSuperview()
        }
        voteView.snp.makeConstraints{
            $0.top.equalTo(voteStackView.snp.bottom).inset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        voteView.addTarget(self, action: #selector(tapVoteButton), for: .touchUpInside)
        
        
    }
    
    @objc func tapVoteButton(){
        print("투표했다.")
    }
    
    @objc func buttonTapped(){
        print("버튼 눌렀다")
    }
    
        
}


