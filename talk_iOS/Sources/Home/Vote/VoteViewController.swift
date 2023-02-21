//
//  VoteViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/19.
//

import UIKit
import Alamofire

class VoteViewController: UIViewController {
    
    static let identifier = "VoteViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "모임명"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnAdd"),
            style: UIBarButtonItem.Style.plain, target: self, action: #selector(addButton))
        self.navigationController?.isNavigationBarHidden = false
        getTest()
        tableSetter()
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 170))
        table.tableHeaderView = header
        header.addSubview(headerView)
        upperViewLayout()
        table.delegate = self
        table.dataSource = self
        table.register(VoteViewControllerTableViewCell.classForCoder()
                           , forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func addButton(){
        print("클릭했다.")
        pushViewController(target: self, storyBoardName: "Vote", identifier: voteCreateViewController
            .identifier)
    }
    
    struct Root: Decodable {
        let votes : [VoteStruct]
    }
    
    struct VoteStruct: Decodable {
        let voteId : Int
        let title : String
        let desc : String?
        let categories : [categoryStruct]
        let multiSelection : Bool
        let anonymousVote : Bool
        let includingDeadline : Bool
        let deadline : String
        
        enum CodingKeys: String, CodingKey {
            case voteId
            case title
            case desc
            case categories
            case multiSelection
            case anonymousVote
            case includingDeadline
            case deadline
        }
    }
    
    struct categoryStruct : Decodable{
        let name : String
        let memberCount : Int
    }
    
    var voteData : [VoteStruct] = []
    
    public static var empty : [Int] = []
    
    func getTest() {
        let url = "https://what-is-talk-test.vercel.app/api/vote"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseData{ response in
                switch response.result {
                case let .success(data):
                    do{
                        let result = try JSONDecoder().decode(Root.self, from: data).votes
                        self.voteData = result
                        self.completeVoteValue.text = "0/\(self.voteData.count)"
                        self.table.reloadData()
                    } catch{
                        print(error)
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    var headerView : UIView = {
        let upperView = UIView()
        upperView.backgroundColor = .white
        upperView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
        return upperView
    }()
    
    var upperView : UIView = {
        let upperView = UIView()
        upperView.backgroundColor = .white
        upperView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
        upperView.layer.cornerRadius = 8.0
        upperView.layer.shadowOpacity = 1
        upperView.layer.shadowRadius = 8.0
        upperView.layer.shadowOffset = CGSize(width: 0, height: 0)
        upperView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        upperView.translatesAutoresizingMaskIntoConstraints = false
        return upperView
    }()

    var upperViewLabel : UILabel = {
        let upperViewLabel = UILabel()
        upperViewLabel.font = UIFont.boldSystemFont(ofSize: 16)
        upperViewLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        upperViewLabel.text = "투표"
        return upperViewLabel
    }()
    var upperViewIcon : UIImageView = {
        let image = UIImage(named: "btnDown")
        let upperViewIcon = UIImageView(image: image)
        upperViewIcon.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return upperViewIcon
    }()

    var upperVoteView : UIView = {
        let upperView = UIView()
        upperView.backgroundColor = .white
        upperView.frame = CGRect(x: 0, y: 0, width: 375, height: 56)
        upperView.layer.cornerRadius = 8.0
        upperView.layer.shadowOpacity = 1
        upperView.layer.shadowRadius = 8.0
        upperView.layer.shadowOffset = CGSize(width: 0, height: 0)
        upperView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        upperView.translatesAutoresizingMaskIntoConstraints = false
        return upperView
    }()

    var completeVoteLabel : UILabel = {
        let completeVoteLabel = UILabel()
        completeVoteLabel.font = UIFont.boldSystemFont(ofSize: 16)
        completeVoteLabel.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        completeVoteLabel.text = "완료한 투표"
        return completeVoteLabel
    }()

    var completeVoteValue : UILabel = {
        let completeVoteValue = UILabel()
        completeVoteValue.font = UIFont.boldSystemFont(ofSize: 16)
        completeVoteValue.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        return completeVoteValue
    }()
    
    let table =  UITableView()
    
    func tableSetter (){
        view.addSubview(table)
        table.estimatedRowHeight = 355;
        table.rowHeight = UITableView.automaticDimension
        table.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            table.showsVerticalScrollIndicator = false
        }
    }
    
    
    func upperViewLayout(){
        headerView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.height.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        [upperView,upperVoteView].forEach{
            headerView.addSubview($0)
        }
        
        upperView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview()
        }
        
        [upperViewLabel,upperViewIcon].forEach{
            upperView.addSubview($0)
        }
        upperViewLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
        }

        upperViewIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(upperViewLabel.snp.trailing).inset(-5)
        }
        
        upperVoteView.snp.makeConstraints{
            $0.top.equalTo(upperView.snp.bottom).inset(-14)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview()
        }
        [completeVoteLabel, completeVoteValue].forEach{
            upperVoteView.addSubview($0)
        }

        completeVoteLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
        }
        completeVoteValue.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(completeVoteLabel.snp.trailing).inset(-5)

        }
    }
    
}


extension VoteViewController : UITableViewDelegate, UITableViewDataSource{
    

    @objc func tapSpecifyButton(){
        print("클릭했다.")
        pushViewController(target: self, storyBoardName: "Vote", identifier: VoteSpecifyViewController
            .identifier)
    }
    
    @objc func tapVoteButton(){
        print("투표했다.")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voteData.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//           return table.rowHeight
//       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VoteViewControllerTableViewCell.identifier, for:indexPath) as? VoteViewControllerTableViewCell else {return UITableViewCell()}
        
        table.rowHeight = 450
        
        //tableView 구분선 없애기
        table.separatorStyle = .none
        
        //cell의 선택(터치이벤트)를 허용하지 않음
        cell.selectionStyle = .none

        let vote = self.voteData[indexPath.row]
        
        var participants : Int = 0

        for countNum in vote.categories {
            participants = participants + countNum.memberCount
        }
                
        let categorData:[voteStackViewCellClass] = vote.categories.map{
            return voteStackViewCellClass.init(voteCategoryLabel: $0.name, selectCount: $0.memberCount, participants : participants, multiSelection: vote.multiSelection, categoriesCount : vote.categories.count  )
        }
        cell.categories = categorData
        cell.voteName.text = vote.title
        cell.voteDescription.text = vote.desc
//        cell.voteCategoryLabel.text = self.voteData[0].categories[indexPath.row].name
//        cell.selectCount.text = String(self.voteData[0].categories[indexPath.row].memberCount)
        
        cell.contentView.addSubview(cell.myView)
        cell.myView.snp.makeConstraints{
                $0.top.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(8)
            }

        [cell.profileImage,cell.memberNameLabel,cell.dateLabel,cell.seeMoreLabel, cell.voteInnerView].forEach{
            cell.myView.addSubview($0)
            }
        cell.profileImage.snp.makeConstraints{
                $0.width.height.equalTo(32)
                $0.leading.equalToSuperview().inset(25)
                $0.top.equalToSuperview().inset(32)
            }

        cell.memberNameLabel.snp.makeConstraints{
            $0.top.equalTo(cell.profileImage)
            $0.leading.equalTo(cell.profileImage.snp.trailing).inset(-16)
            }
        cell.dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(cell.profileImage.snp.bottom)
            $0.leading.equalTo(cell.memberNameLabel)
            }
        cell.seeMoreLabel.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage)
                $0.trailing.equalToSuperview().inset(25)
            }
        
        //seeMoreLabel 이 사용자와 상호작용(터치이벤트 인시식)하는 것을 허용한다.
        cell.seeMoreLabel.isUserInteractionEnabled = true
        cell.seeMoreLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSpecifyButton)))
        
        cell.voteInnerView.snp.makeConstraints{
            $0.top.equalTo(cell.profileImage.snp.bottom).inset(-19)
                $0.bottom.equalToSuperview().inset(32)
                $0.leading.equalToSuperview().inset(25)
                $0.trailing.equalToSuperview().inset(25)
            }
        
        [cell.voteName,cell.voteDescription,cell.voteStackView, cell.voteView].forEach{
            cell.voteInnerView.addSubview($0)
            }
            
        cell.voteName.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
            }
        cell.voteDescription.snp.makeConstraints{
            $0.top.equalTo(cell.voteName.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            }
        cell.voteStackView.snp.makeConstraints{
            $0.top.equalTo(cell.voteDescription.snp.bottom).inset(-19)
            $0.leading.trailing.equalToSuperview()
        }
        cell.voteView.snp.makeConstraints{
            $0.top.equalTo(cell.voteStackView.snp.bottom).inset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        cell.voteView.addTarget(self, action: #selector(tapVoteButton), for: .touchUpInside)
                
       return cell
    }

}




class VoteViewControllerTableViewCell:UITableViewCell{
    static let identifier = "cell"
    
    // Cell간 간격 조정 메소드
    override func layoutSubviews() {
       super.layoutSubviews()
       contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
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
       return label
    }()
    
    var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
       return label
    }()
    
    var seeMoreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        label.text = "자세히 보기 >"
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
        label.numberOfLines = 2
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
    
    @objc func buttonTapped(){
        print("버튼 눌렀다")
    }
    
    
    var categories:[voteStackViewCellClass] = [] {
        didSet{
            self.categories.forEach{
                voteStackView.addArrangedSubview($0)
                $0.snp.makeConstraints{ make in
                    make.width.equalToSuperview()
                    make.height.equalTo(35)
                }
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categories.forEach{
            $0.removeFromSuperview()
        }
        
    }
    
}


class voteStackViewCellClass : UIView {
    
    var checkBox : TalkCheckBox = {
        let box = TalkCheckBox()
       return box
        
    }()
    
    
    
    var multiSelection = false
    var categoriesCount = 0
    
    @objc func checkBoxTapped(){
        print("클릭!")
//        if(!multiSelection){
//            for n in categoriesCount
//        }
//        VoteViewController.empty = 1
        checkBox.toggleSelect()
    }
    

    
    var voteCategoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var progressView : UIProgressView = {
        let view = UIProgressView()
        view.progress = 0.5 // Set initial progress value (0.0 ~ 1.0)
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.progressTintColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        view.trackTintColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)

        return view
    }()
    

    
    var selectCount : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    init(voteCategoryLabel:String, selectCount:Int, participants : Int, multiSelection : Bool, categoriesCount : Int){
        self.voteCategoryLabel.text = voteCategoryLabel
        self.selectCount.text = "\(selectCount)명"
        self.multiSelection = multiSelection
        super.init(frame: .init(x: 0, y: 0, width: 0, height: 0))
        self.addSubview(checkBox)
        checkBox.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(22)
        }
        
        self.addSubview(self.voteCategoryLabel)
        self.voteCategoryLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkBox.snp.trailing).inset(-20)
        }
        self.progressView.progress = Float(selectCount)/Float(participants)
        self.addSubview(self.progressView)
        self.progressView.snp.makeConstraints{
            $0.top.equalTo(checkBox.snp.bottom).inset(-11)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(self.selectCount)
        self.selectCount.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(tapGesture)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
