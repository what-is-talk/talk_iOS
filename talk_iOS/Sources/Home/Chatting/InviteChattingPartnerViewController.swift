//
//  InviteChattingPartnerViewController.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/14.
//

import UIKit
import SnapKit



class InviteChattingPartnerViewController: UIViewController {
    
    static let identifier = "InviteChattingPartnerViewController"
    
    
    struct Member{
        let name:String
        let profileImage:UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
            return view
        }()
        let rolls:[Roll]
        var selected:Bool = false
    }

    struct Roll{
        let title:String
        let color:UIColor
        var selected:Bool
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
    
    var rolls:[Roll] = [
        .init(title: "전체", color: .TalkRed, selected: false),
        .init(title: "역할1", color: .TalkBlue, selected: false),
        .init(title: "역할2", color: .TalkYellow, selected: false),
        .init(title: "역할3", color: .TalkOrange, selected: false),
        .init(title: "역할4", color: .TalkPink, selected: false),
    ]
    
    var rollBtns:[TalkRollBox] = []
    
    var members:[Member] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.members.append(contentsOf: [
            .init(name: "김희윤", rolls: [rolls[1],rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[3],rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[2],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[3],rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[2],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[2]]),
            .init(name: "김희윤", rolls: [rolls[3],rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[4]]),
            .init(name: "김희윤", rolls: [rolls[2],rolls[3]]),
            .init(name: "김희윤", rolls: [rolls[1],rolls[3]]),
        ])
       
        setUpNaviBar()
        self.tabBarController?.tabBar.isHidden = true
        configureView()
        self.tableView.register(InviteChattingPartnerTableViewCell.self, forCellReuseIdentifier: InviteChattingPartnerTableViewCell.identifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self

    }
    
    // 멤버를 체크/해제 했을 때 각 cell이 호출하는 함수
    // 전체 멤버의 선택 여부 관리는 여기서 한다.
//    func memberSelected(index:Int, selected:Bool){
//        self.members[index].selected = selected
//        self.members.forEach{
//            print(index, $0.selected)
//        }
//    }
    
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
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).inset(15)
//            $0.width.equalTo(200)
            $0.height.equalTo(20)
        }
        
        // Filter Boxex
//        let allSelectBtn:TalkRollBox = .init(text: "전체", color: .red, selected: true)
        self.rollBtns = rolls.map{
            return TalkRollBox.init(title: $0.title, color: $0.color, selected: $0.selected)
        }
        
        (rollBtns).forEach{
            filterStackView.addArrangedSubview($0)
            $0.snp.makeConstraints{(make) in
                make.width.equalTo(53)
                make.height.equalTo(20)
            }
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapFilterBox(sender:))))
        }
        
        // Table View
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(filterStackView).inset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
   
    
    @objc private func tapFilterBox(sender:UITapGestureRecognizer){
        guard let talkRollBox = sender.view as? TalkRollBox else {return}
        guard let title = talkRollBox.label.text else {return}
        talkRollBox.toggleSelect()
        let select = talkRollBox.selected
        if title == "전체"{
            if select == true{ // 전체 버튼 선택
                for i in 0...(members.count - 1){
                    members[i].selected = true
                }
                self.rollBtns.filter{$0.title != "전체"}.forEach{
                    $0.unSelect()
                }
            }
            else{ // 전체 버튼 선택 해제
                for i in 0...(members.count - 1){
                    members[i].selected = false
                }
            }
        } else{
            if select == true{ // 역할N 버튼 선택
                if self.rollBtns[0].selected{
                    self.rollBtns[0].unSelect()
                    for i in 0...(members.count - 1){
                        members[i].selected = false
                    }
                }
                for i in 0...(members.count - 1) {
                    let titles = members[i].rolls.map{$0.title}
                    if titles.contains(title){
                        members[i].selected = true
                    }
                }
               
            } else { // 역할N 버튼 해제
                
                for i in 0...(members.count - 1){
                    let selectedFilters = self.rollBtns.filter{$0.selected == true}.map{$0.title}
                    let titles = members[i].rolls.map{$0.title}
                    
                    // 중복이 없으면 -> 역할이 겹치는게 없으면 -> 체크 해제
                    if (selectedFilters + titles).count == Set(selectedFilters + titles).count{
                        members[i].selected = false
                    }
                }
            }
        }
        
        self.tableView.reloadData()
    }
}

extension InviteChattingPartnerViewController:UITableViewDataSource{
    // 각 섹션에 표시할 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.members.count
    }
    
    // 테이블뷰에 넣을 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InviteChattingPartnerTableViewCell.identifier, for:indexPath) as? InviteChattingPartnerTableViewCell else {return UITableViewCell()}
        tableView.rowHeight = 60
        let member = self.members[indexPath.row]
        cell.name.text = member.name
        let rollBoxes:[TalkRollBox] = self.members[indexPath.row].rolls.map{
            return TalkRollBox.init(title: $0.title, color: $0.color, selected: true)
        }
        cell.rolls = rollBoxes
        cell.index = indexPath.row
//        cell.checkBox = self.checkBoxes[indexPath.row]
        cell.checkBtnSelected = self.members[indexPath.row].selected
//        cell.selectCheckBtnFromSuperView = self.memberSelected(index:selected:)
        return cell
    }
}

extension InviteChattingPartnerViewController:UITableViewDelegate{
    // cell이 선택되었을 때의 동작을 정의하는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.members[indexPath.row].selected = !self.members[indexPath.row].selected
        self.tableView.reloadData()
    }
}
