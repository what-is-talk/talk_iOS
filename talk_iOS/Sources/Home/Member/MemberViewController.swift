//
//  MemberViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/02/01.
//
import UIKit
import Alamofire

class MemberViewController: UIViewController {
    
    static let identifier = "MemberViewController"
    let table =  UITableView()
                  
    struct Root: Decodable {
        let member_list : [SimpleResponse]
    }

    struct SimpleResponse: Decodable {
        let id : Int
        let url : String
        let name : String
        let joined_date : String
        let role : [roleStruct]

      enum CodingKeys: String, CodingKey {
          case id
          case url = "profile_url"
          case name
          case joined_date
          case role
      }
    }
    
    struct roleStruct : Decodable{
        let name : String
        let color : String
    }
    
    func getTest() {
        let url = "https://what-is-talk-test.vercel.app/api/member?groupId=1"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .responseData{ response in
                switch response.result {
                case let .success(data):
                    do{
                        let result = try JSONDecoder().decode(Root.self, from: data).member_list
                        self.testMembers = result
                        self.table.reloadData()
                    } catch{
                        print(error)
                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "모임명"
        self.navigationController?.isNavigationBarHidden = false
        getTest()
        self.members.append(contentsOf: [
            .init(name: "김희윤", rolls: [rolls[1],rolls[2],rolls[4]]),
            .init(name: "박상민", rolls: [rolls[2]]),
            .init(name: "장우석", rolls: [rolls[3],rolls[4]]),
            .init(name: "박지수", rolls: [rolls[4]]),
            .init(name: "김혜연", rolls: [rolls[2],rolls[3],rolls[4]]),
            .init(name: "박시영", rolls: [rolls[1],rolls[3]]),
            .init(name: "경유진", rolls: [rolls[1],rolls[2],rolls[4]]),
            .init(name: "안채은", rolls: [rolls[2]]),
            .init(name: "안녕", rolls: [rolls[3],rolls[4]]),
            .init(name: "하세", rolls: [rolls[3]]),
            .init(name: "요구", rolls: [rolls[2],rolls[3]]),
            .init(name: "르트", rolls: [rolls[1],rolls[3]]),
            .init(name: "트럼프", rolls: [rolls[1],rolls[2],rolls[4]]),
            .init(name: "프랑스", rolls: [rolls[2]]),
            .init(name: "스위스", rolls: [rolls[3],rolls[4]]),
            .init(name: "스키", rolls: [rolls[4]]),
            .init(name: "키러기", rolls: [rolls[2],rolls[3]]),
            .init(name: "기술자", rolls: [rolls[1],rolls[3]]),
        ])
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 295))
        table.tableHeaderView = header


        header.addSubview(upperView)
        upperView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
        upperView.addSubview(upperViewLabel)
        upperView.addSubview(upperViewIcon)
        upperView.addSubview(upperViewArt)
        upperViewLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
        }
        
        upperViewIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(upperViewLabel.snp.trailing).inset(-5)
        }
        upperViewArt.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        header.addSubview(teamLeaderLabel)
        header.addSubview(teamLeaderBar)
        teamLeaderLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(upperView.snp.bottom).inset(-23)
        }
        teamLeaderBar.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(teamLeaderLabel.snp.bottom).inset(-12)
            $0.height.equalTo(1)
        }
        header.addSubview(profileImage)
        header.addSubview(memberName)
        profileImage.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(teamLeaderBar.snp.bottom).inset(-22)
        }
        memberName.snp.makeConstraints{
            $0.leading.equalTo(profileImage.snp.trailing).inset(-15)
            $0.centerY.equalTo(profileImage.snp.centerY)
        }
        header.addSubview(teamMemberLabel)
        header.addSubview(teamMemberBar)
        teamMemberLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(profileImage.snp.bottom).inset(-53)
        }
        teamMemberBar.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(teamMemberLabel.snp.bottom).inset(-12)
            $0.height.equalTo(1)
        }
        header.addSubview(addTeamButton)
        addTeamButton.snp.makeConstraints{
            $0.centerY.equalTo(teamMemberLabel)
            $0.trailing.equalTo(teamMemberBar.snp.trailing)
            $0.width.height.equalTo(19.7)
        }

        table.delegate = self
        table.dataSource = self
        tableSetter()
        attribute()
    }
    
    
    func tableSetter() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        table.showsVerticalScrollIndicator = false

    }

    struct memberDataModel{
        var memberName : String
        var memberColor : String
    }
    
    struct Member{
        let name:String
        let profileImage:UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
            return view
        }()
        let rolls:[Role]
    }
    
    struct Role{
        let name:String
        let color:UIColor
    }
    var members:[Member] = []
    
    var testMembers : [SimpleResponse] = []

    
    var rolls:[Role] = [
        .init(name: "공통리더", color: .TalkRed),
        .init(name: "기획", color: .TalkBlue),
        .init(name: "프론트", color: .TalkYellow),
        .init(name: "백엔드", color: .TalkOrange),
        .init(name: "디자인", color: .TalkPink),
    ]

    
    func attribute(){
        table.register(MemberViewControllerTableViewCell.classForCoder()
                       , forCellReuseIdentifier: "cell")
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
        upperViewLabel.text = "멤버"
        return upperViewLabel
    }()
    
    var upperViewIcon: UIImageView = {
        let image = UIImage(named: "btnDown")
        let upperViewIcon = UIImageView(image: image)
        upperViewIcon.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return upperViewIcon
    }()
    
    var upperViewArt : UIImageView = {
        let image = UIImage(named: "upperViewArt")
        let upperViewArt = UIImageView(image: image)
        upperViewArt.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return upperViewArt
    }()
    
    var teamLeaderLabel : UILabel = {
        let teamLeaderLabel = UILabel()
        teamLeaderLabel.font = UIFont.boldSystemFont(ofSize: 20)
        teamLeaderLabel.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        teamLeaderLabel.text = "모임장"
        return teamLeaderLabel
    }()
    
    
    var teamLeaderBar : UIView = {
        let teamLeaderBar = UIView()
        teamLeaderBar.frame = CGRect(x: 0, y: 0, width: 358, height: 1)
        teamLeaderBar.layer.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1).cgColor
        return teamLeaderBar
    }()
    
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        view.layer.cornerRadius = view.frame.height/2
        return view
    }()
    
    var memberName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.text = "사용자 이름"
        return label
    }()
    
    var teamMemberLabel : UILabel = {
        let teamMemberLabel = UILabel()
        teamMemberLabel.font = UIFont.boldSystemFont(ofSize: 20)
        teamMemberLabel.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        teamMemberLabel.text = "모임원"
        return teamMemberLabel
    }()
    
    lazy var addTeamButton : UIButton = {
        let teamMemberLabel = UIButton()
        teamMemberLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0 )
        teamMemberLabel.setTitleColor(.systemBlue,for: .normal)
        teamMemberLabel.setImage(UIImage(named: "addTeamMember"), for: .normal)
        teamMemberLabel.addTarget(self,action: #selector(addTeamAction),
for: .touchUpInside)

        return teamMemberLabel
    }()
    
    
    var teamMemberBar : UIView = {
        let teamMemberBar = UIView()
        teamMemberBar.frame = CGRect(x: 0, y: 0, width: 358, height: 1)
        teamMemberBar.layer.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1).cgColor
        return teamMemberBar
    }()
    
    @objc func addTeamAction(){
        guard let vc = self.storyboard?.instantiateViewController(identifier: "MemberInviteViewController") as? MemberInviteViewController else {
                return
            }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension MemberViewController : UITableViewDelegate, UITableViewDataSource{
    
    func convertColor(color: String) -> UIColor {
        var dic: [String: UIColor] = ["red" : .TalkRed, "yellow" : .TalkYellow, "blue" : .TalkBlue, "orange" : .TalkOrange, "pink" : .TalkPink]
        
        return dic[color]!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return testMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberViewControllerTableViewCell.identifier, for:indexPath) as? MemberViewControllerTableViewCell else {return UITableViewCell()}
        let member = self.testMembers[indexPath.row]
        cell.memberName.text = member.name
        
    
        let url: URL! = URL(string: member.url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.profileImage.image = UIImage(data: data!)
            }
        }
        
        let rollBoxes:[TalkRollBox] = member.role.map{
            return TalkRollBox.init(title: $0.name, color: convertColor(color: $0.color), selected: true)
        }
        cell.rolls = rollBoxes
        // MyView
        cell.contentView.addSubview(cell.myView)
        cell.myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        cell.myView.addSubview(cell.profileImage)
        cell.profileImage.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.centerY.equalToSuperview().inset(19)
            $0.leading.equalToSuperview().inset(16)
        }
        
        cell.myView.addSubview(cell.memberNameBox)
        cell.memberNameBox.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage.snp.centerY)
            $0.leading.equalTo(cell.profileImage.snp.trailing).inset(-15)
            $0.width.equalTo(40)
            $0.height.equalToSuperview()
        }
        cell.memberNameBox.addSubview(cell.memberName)
        cell.memberName.snp.makeConstraints{
            $0.centerY.equalTo(cell.profileImage.snp.centerY)
            $0.centerX.equalToSuperview()
        }
        tableView.rowHeight = 56
        cell.myView.addSubview(cell.rollStackView)
        cell.rollStackView.snp.makeConstraints{
            $0.leading.equalTo(cell.memberNameBox.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
        
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //클릭한 셀의 이벤트 처리
        let member = self.testMembers[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = self.storyboard?.instantiateViewController(identifier: "MemberPageViewController") as? MemberPageViewController else {
                return
            }
        vc.userName = member.name
        vc.joined_date = String(member.joined_date.prefix(9))
        for i in 0...member.role.count-1 {
            vc.roleData[i] = member.role[i].name
            vc.roleColor[i] = convertColor(color: member.role[i].color)
        }
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    

}




class MemberViewControllerTableViewCell:UITableViewCell{
    static let identifier = "cell"
    let myView = UIView()
    
    
    let rollStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 7
        return view
    }()
    
    var profileImage:UIImageView = {
        let profileImage = UIImageView()
        profileImage.backgroundColor = .gray
        profileImage.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        return profileImage
    }()
    var memberNameBox : UIView = {
        let view = UIView()
       return view
    }()
    
    var memberName : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
       return label
    }()

    

    var rolls:[TalkRollBox] = []{
        didSet{
            self.rolls.forEach{
                rollStackView.addArrangedSubview($0)
                $0.snp.makeConstraints{ make in
                    make.width.equalTo(53)
                    make.height.equalTo(20)
                }
            }
        }
    }
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.rolls.forEach{
            $0.removeFromSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
