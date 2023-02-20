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
        self.navigationController?.isNavigationBarHidden = false
        getTest()
        tableSetter()
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 170))
        table.tableHeaderView = header
        header.addSubview(upperView)
        upperViewLayout()
        table.delegate = self
        table.dataSource = self
        table.register(VoteViewControllerTableViewCell.classForCoder()
                           , forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
    
    func getTest() {
        let url = "https://what-is-talk-test.vercel.app/api/vote"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseData{ response in
                switch response.result {
                case let .success(data):
                    do{
                        let result = try JSONDecoder().decode(Root.self, from: data).votes
                        self.voteData = result
                        self.table.reloadData()
                    } catch{
                        print(error)
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
    }
    
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
        completeVoteValue.text = "0/0"
        return completeVoteValue
    }()
    
    let table =  UITableView()
    
    func tableSetter (){
        view.addSubview(table)
        table.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
            table.showsVerticalScrollIndicator = false
        }
    }
    
    
    func upperViewLayout(){
        upperView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
        }

        [upperViewLabel, upperViewIcon].forEach{
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
        view.addSubview(upperVoteView)
        upperVoteView.snp.makeConstraints{
            $0.top.equalTo(upperView.snp.bottom).inset(-14)
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voteData.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//           return table.rowHeight
//       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VoteViewControllerTableViewCell.identifier, for:indexPath) as? VoteViewControllerTableViewCell else {return UITableViewCell()}
        
        table.rowHeight = 356
        
        //tableView 구분선 없애기
        table.separatorStyle = .none
        
        //cell의 선택(터치이벤트)를 허용하지 않음
        cell.selectionStyle = .none

        let vote = self.voteData[indexPath.row]
        
        let categorData:[voteStackViewCellClass] = vote.categories.map{
            return voteStackViewCellClass.init(voteCategoryLabel: $0.name, selectCount: String($0.memberCount))
        }
        cell.categories = categorData
        cell.voteName.text = vote.title
        cell.voteDescription.text = vote.desc
//        cell.voteCategoryLabel.text = self.voteData[0].categories[indexPath.row].name
//        cell.selectCount.text = String(self.voteData[0].categories[indexPath.row].memberCount)
        
            cell.contentView.addSubview(cell.myView)
            cell.myView.snp.makeConstraints{
                $0.top.bottom.leading.trailing.equalToSuperview()
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
        cell.voteInnerView.snp.makeConstraints{
            $0.top.equalTo(cell.profileImage.snp.bottom).inset(-19)
                $0.bottom.equalToSuperview().inset(32)
                $0.leading.equalToSuperview().inset(25)
                $0.trailing.equalToSuperview().inset(25)

            }
        [cell.voteName,cell.voteDescription,cell.voteStackView].forEach{
            cell.voteInnerView.addSubview($0)
            }
            
        cell.voteName.snp.makeConstraints{
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
            }
        cell.voteDescription.snp.makeConstraints{
            $0.top.equalTo(cell.voteName.snp.bottom)
                $0.height.equalTo(60)
                $0.leading.trailing.equalToSuperview()
            }
        cell.voteStackView.snp.makeConstraints{
            $0.top.equalTo(cell.voteDescription.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview()
        }

//        cell.voteStackView.addArrangedSubview(cell.voteStackViewCell1)
//        cell.voteStackView.addArrangedSubview(cell.voteStackViewCell2)

    
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
        profileImage.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    var memberNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        label.text = "작성자"
       return label
    }()
    
    var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        label.text = "2022.03.12"
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
        label.text = "3월 15일 정모 참석 여부"
       return label
    }()
    
    var voteDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.sizeToFit()
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
       label.text = "이번 오프라인 정기 모임 참석 여부 투표 부탁드립니다. 하지만 TMI를 드리자면 이번 모임에는 집에 가고 싶어용~"
       return label
    }()
    
    var voteStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    
    var categories:[voteStackViewCellClass] = []{
        didSet{
            self.categories.forEach{
                voteStackView.addArrangedSubview($0)
                $0.snp.makeConstraints{ make in
                    make.width.equalTo(53)
                    make.height.equalTo(20)
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
    
    var voteStackViewCellObject : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.backgroundColor = .TalkPink
        return view
    }()
    
    var checkBox : TalkCheckBox = {
        let bpx = TalkCheckBox()
       return bpx
        
    }()
    
    var voteCategoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var selectCount : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    init(voteCategoryLabel:String, selectCount:String){
        self.voteCategoryLabel.text = voteCategoryLabel
        self.selectCount.text = selectCount
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
        
        self.addSubview(self.selectCount)
        self.selectCount.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
