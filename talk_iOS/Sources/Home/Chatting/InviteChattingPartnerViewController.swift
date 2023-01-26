//
//  InviteChattingPartnerViewController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/14.
//

import UIKit
import SnapKit

class InviteChattingPartnerTableViewCell:UITableViewCell{
    static let identifier = "cell"
    let a = "ss"
    let rollStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 7
        return view
    }()
    let myView = UIView()
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 18
        return view
    }()
    var name:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .init(rawValue: 590))
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
            print("didset, rolls:\(self.rolls)")
        }
    }
    var checkBox:TalkCheckBox = {
        let view = TalkCheckBox()
        return view
    }()
    @objc func selectCheckBtn(){
        checkBox.toggleSelect()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)
        self.selectionStyle = .none
        
        // MyView
        self.contentView.addSubview(myView)
        myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        
        // profileImage
        myView.addSubview(profileImage)
        profileImage.snp.makeConstraints{
            $0.width.height.equalTo(36)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        
        // name
        myView.addSubview(name)
        name.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).inset(-15)
        }
        
        // rollStackView
        myView.addSubview(rollStackView)
        rollStackView.snp.makeConstraints{
            $0.leading.equalTo(name.snp.trailing).inset(-8)
            $0.top.bottom.equalToSuperview()
        }
        
        // checkBox
        
        checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(selectCheckBtn)))
        myView.addSubview(checkBox)
        checkBox.snp.makeConstraints{
            $0.width.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        
    }
    
    // cell 재사용 시 값을 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        self.rolls.forEach{
            $0.removeFromSuperview()
        }
        self.checkBox.unSelect()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class InviteChattingPartnerViewController: UIViewController {
    
    static let identifier = "InviteChattingPartnerViewController"
    
    
    struct Member{
        let name:String
        let profileImage:UIView = {
            let view = UIView()
            view.backgroundColor = .gray
            return view
        }()
        let rolls:[Roll]
        var selected:Bool = false
    }

    struct Roll{
        let title:String
        let color:UIColor
    }

   
    
    let filterTitle:UILabel = {
        let title = UILabel()
        title.text = "모임원"
        title.textColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        title.font = .systemFont(ofSize: 20, weight: .bold)
        return title
    }()
    let filterStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        return stackView
    }()
    let tableView = UITableView()
    
    let rolls:[Roll] = [
        .init(title: "역할1", color: .TalkBlue),
        .init(title: "역할2", color: .TalkYellow),
        .init(title: "역할3", color: .TalkOrange),
        .init(title: "역할4", color: .TalkPink),
    ]
    
    var members:[Member] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.members.append(contentsOf: [
            .init(name: "김희윤", rolls: [rolls[0],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1]]),
            .init(name: "김희윤", rolls: [rolls[2],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[0],rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[0],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1]]),
            .init(name: "김희윤", rolls: [rolls[2],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[0],rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[0],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1]]),
            .init(name: "김희윤", rolls: [rolls[2],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[0],rolls[2]]),
        ])
        setUpNaviBar()
        self.tabBarController?.tabBar.isHidden = true
        configureView()
        self.tableView.register(InviteChattingPartnerTableViewCell.self, forCellReuseIdentifier: InviteChattingPartnerTableViewCell.identifier)
        self.tableView.dataSource = self
//        self.tableView.delegate = self

    }
    
    private func setUpNaviBar(){
        self.navigationItem.title = "대화 상대 초대"
        self.navigationItem.leftBarButtonItem = .init(image: UIImage(named: "btnClose"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(named: "btnNext"), style: .plain, target: self, action: nil)
    }
    
    private func configureView(){
        // FilterTitle
        self.view.addSubview(filterTitle)
        filterTitle.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).inset(15)
        }
        // Filter StackView
        self.view.addSubview(filterStackView)
//        filterStackView.backgroundColor = .blue
        filterStackView.snp.makeConstraints{
            $0.top.equalTo(filterTitle.snp.bottom).inset(-10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(15)
//            $0.width.equalTo(200)
            $0.height.equalTo(20)
        }
        
        // Filter Boxex
        let allSelectBtn:TalkRollBox = .init(text: "전체", color: .red, selected: true)
        let rollbtns:[TalkRollBox] = rolls.map{
            return TalkRollBox.init(text: $0.title, color: $0.color, selected: false)
        }
        
        ([allSelectBtn] + rollbtns).forEach{
            filterStackView.addArrangedSubview($0)
            $0.snp.makeConstraints{(make) in
                make.width.equalTo(53)
                make.height.equalTo(20)
            }
        }
        
        // Table View
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(filterStackView).inset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

extension InviteChattingPartnerViewController:UITableViewDataSource{
    // 각 섹션에 표시할 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count:\(self.members.count)")
        return self.members.count
    }
    
    // 테이블뷰에 넣을 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InviteChattingPartnerTableViewCell.identifier, for:indexPath) as? InviteChattingPartnerTableViewCell else {return UITableViewCell()}
        tableView.rowHeight = 56
        let member = self.members[indexPath.row]
        cell.name.text = member.name
        let rollBoxes:[TalkRollBox] = self.members[indexPath.row].rolls.map{
            return TalkRollBox.init(text: $0.title, color: $0.color, selected: true)
        }
        cell.rolls = rollBoxes
        return cell
    }
}
