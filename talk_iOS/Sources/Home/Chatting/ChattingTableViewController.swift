//
//  ChattingTableViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/01/12.
//

import UIKit
import CoreData

class ChattingTableViewController: UIViewController {
    
    static let identifier = "ChattingTableViewController"

    var container: NSPersistentContainer!
    let table =  UITableView()

    
    func layout() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    struct DataModel{
        var roomName : String
        var memberNumber : Int
        var latestMessage : String
        var latestMessageTime : String
        var unreadMessageNumber : Int
        var alarm : Bool
        var fix : Bool
    }
        
    func attribute(){
        table.register(ChattingTableViewControllerCell.classForCoder()
                       , forCellReuseIdentifier: "cell")
    }
    var sampleData: [DataModel] = [
        DataModel(roomName: "모임톡", memberNumber: 8, latestMessage: "ddd", latestMessageTime: "12:58", unreadMessageNumber: 3 ,  alarm : true, fix: true),
        DataModel(roomName: "모임톡프론트", memberNumber: 3, latestMessage: "어케함?", latestMessageTime: "1:32", unreadMessageNumber: 32,  alarm : false, fix: true),
        DataModel(roomName: "모임톡백엔드", memberNumber: 5, latestMessage: "응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응응", latestMessageTime: "2:58", unreadMessageNumber: 189,  alarm : true, fix: true),
        DataModel(roomName: "앙아아아아앙앙", memberNumber: 32, latestMessage: "ㅇㅇ?", latestMessageTime: "어제", unreadMessageNumber: 0,  alarm : false, fix: false),
        DataModel(roomName: "앙아아아아앙앙", memberNumber: 32, latestMessage: "ㅇㅇ?", latestMessageTime: "어제", unreadMessageNumber: 12,  alarm : true, fix: false),
        DataModel(roomName: "앙아아아아앙앙", memberNumber: 32, latestMessage: "ㅇㅇ?", latestMessageTime: "어제", unreadMessageNumber: 0,  alarm : true, fix: false),
        DataModel(roomName: "앙아아아아앙앙", memberNumber: 32, latestMessage: "ㅇㅇ?", latestMessageTime: "어제", unreadMessageNumber: 12,  alarm : false, fix: false),
        DataModel(roomName: "앙아아아아앙앙", memberNumber: 32, latestMessage: "ㅇㅇ?", latestMessageTime: "어제", unreadMessageNumber: 12,  alarm : true, fix: false),
        DataModel(roomName: "앙아아아아앙앙", memberNumber: 32, latestMessage: "ㅇㅇ?", latestMessageTime: "어제", unreadMessageNumber: 12,  alarm : true, fix: false)
        ]
    var searchingData = [DataModel]()
    var searching = false

    
    
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        titleStackView.addArrangedSubview(label1)
        titleStackView.addArrangedSubview(label2)
        self.navigationItem.titleView = titleStackView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnAdd"),
            style: UIBarButtonItem.Style.plain, target: self, action: #selector(addButton))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnBack"),
    style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButton))
        self.navigationController?.navigationBar.tintColor = .black
        setupSearchController()
        table.delegate = self
        table.dataSource = self
        layout()
        attribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    
    private var isFirst = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard isFirst else {
        return
        }
        isFirst = false
        setupSearchTextField()
    }


    private func setupSearchTextField(){
        let searchTextField:UITextField = searchController.searchBar.value(forKey: "searchField") as? UITextField ?? UITextField()

        searchTextField.textAlignment = NSTextAlignment.left
        let searchIcon = UIImageView(frame : CGRect(x: 0, y: 0, width: 20, height:20))
        searchIcon.image = UIImage(named: "btnSearch")
        searchTextField.leftView = searchIcon
                searchTextField.placeholder = "채팅방 이름, 참여자 검색"
                searchTextField.rightView = nil
        searchTextField.leftViewMode = UITextField.ViewMode.always
        searchTextField.backgroundColor = .white
            searchTextField.borderStyle = .none
            searchTextField.layer.cornerRadius = 8.0
            searchTextField.layer.shadowOpacity = 1
            searchTextField.layer.shadowRadius = 8.0
            searchTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
            searchTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            searchTextField.becomeFirstResponder()
    }

    
    func setupSearchController() {
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.backgroundColor = .white
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
    }

    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "채팅"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let label2: UILabel = {
        let label = UILabel()
        label.text = "모임명"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        return stackView
    }()
    
    @objc fileprivate func backButton(){
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func refresh(){

    }
  
    
    @objc fileprivate func addButton(){
        let num = Int.random(in: 0...1)
        var permission : Bool
        if(num == 0){
            permission = true
        }else{
            permission = false
        }
        if(permission){
            pushViewController(target: self, storyBoardName: "InviteChattingPartner", identifier: InviteChattingPartnerViewController.identifier)

        }else{
            let alert = UIAlertController(title:nil, message: nil, preferredStyle: .alert)
            let title = UIAlertAction(title: "채팅방 생성 권한이 없습니다.", style: .destructive)
            let cancle = UIAlertAction(title: "확인", style: .default)
            alert.addAction(title)
            alert.addAction(cancle)
            self.present(alert, animated: true)
        }
    }
}



extension ChattingTableViewController : UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if !searchText.isEmpty{
            searching = true
            searchingData.removeAll()
            for i in sampleData{
                if i.roomName.lowercased().contains(searchText.lowercased()){
                    searchingData.append(i)
                }
            }
        }else{
            searching = false
            searchingData.removeAll()
            searchingData = sampleData
        }
        table.reloadData()
    }
//    func offAlarm(){
//    }
//
//    func fixRoom(){
//
//    }
//
    
    func exitRoom(){
        let alert = UIAlertController(title:"채팅방 나가기", message: "채팅방을 나가면 모든 기록이 삭제됩니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "나가기", style: .destructive))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchingData.count
        }else{
            return sampleData.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewControllerCell.identifier, for:indexPath) as? ChattingTableViewControllerCell else {return UITableViewCell()}
        // MyView
        cell.contentView.addSubview(cell.myView)
        cell.myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        // profileImage
        cell.myView.addSubview(cell.profileImage)
        cell.profileImage.snp.makeConstraints{
            $0.width.height.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        // name
        cell.myView.addSubview(cell.roomName)
        cell.roomName.snp.makeConstraints{
//            $0.centerY.equalToSuperview()
            $0.leading.equalTo(cell.profileImage.snp.trailing).inset(-16)
            $0.top.equalTo(cell.profileImage.snp.top)
            
        }
        
        cell.myView.addSubview(cell.memberNumber)
        cell.memberNumber.snp.makeConstraints{
            $0.leading.equalTo(cell.roomName.snp.trailing).inset(-2)
            $0.top.equalTo(cell.roomName.snp.top)

            
        }
        
        cell.myView.addSubview(cell.latestMessage)
        cell.latestMessage.snp.makeConstraints{
            $0.top.equalTo(cell.roomName.snp.bottom).inset(-3)
            $0.leading.equalTo(cell.roomName.snp.leading)
            $0.trailing.equalToSuperview().inset(70)

        }
        
        cell.myView.addSubview(cell.latestMessageTime)
        cell.latestMessageTime.snp.makeConstraints{
            $0.top.equalTo(cell.roomName.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            
        }
        
        tableView.rowHeight = 89
        let rowIndex = indexPath.row
        let member : DataModel
        if searching{
            member = self.searchingData[rowIndex]
        }else{
            member = self.sampleData[rowIndex]
        }
        cell.roomName.text = member.roomName
        cell.memberNumber.text = "\(member.memberNumber)"
        cell.latestMessage.text = member.latestMessage
        cell.latestMessageTime.text = member.latestMessageTime
        if(member.unreadMessageNumber > 0){
            cell.myView.addSubview(cell.unreadMessage)
            cell.unreadMessage.snp.makeConstraints{
                $0.width.height.equalTo(15)
                $0.bottom.equalTo(cell.profileImage.snp.bottom).inset(5)
                $0.trailing.equalTo(cell.latestMessageTime.snp.trailing)
            }
            if(member.unreadMessageNumber > 99){
                cell.unreadMessage.unreadMeassageNumber.text = "99+"
            }else{
                cell.unreadMessage.unreadMeassageNumber.text = "\(member.unreadMessageNumber)"
            }
        }
        if(member.fix){
            cell.myView.addSubview(cell.roomFix)
            cell.roomFix.snp.makeConstraints{
                $0.top.equalTo(cell.memberNumber.snp.top).inset(3)
                $0.leading.equalTo(cell.memberNumber.snp.trailing).inset(-9)
            }
        }
        
        if(member.alarm){
            cell.myView.addSubview(cell.alarmOff)
            if(member.fix){
                cell.alarmOff.snp.makeConstraints{
                    $0.top.equalTo(cell.memberNumber.snp.top).inset(4)
                    $0.leading.equalTo(cell.roomFix.snp.trailing).inset(-9)
                }
            }else{
                cell.alarmOff.snp.makeConstraints{
                    $0.top.equalTo(cell.memberNumber.snp.top).inset(3)
                    $0.leading.equalTo(cell.memberNumber.snp.trailing).inset(-5)
                }
            }
        }
       return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let rowIndex = indexPath.row
        let member = self.sampleData[rowIndex]
        
        var alarmTitle : String
        
        if(member.alarm){
            alarmTitle = "알람 끄기"
        }else{
            alarmTitle = "알람 켜기"
        }
        
        let hide = UIContextualAction(style: .normal, title: alarmTitle) { (action, view, completionHandler) in
//            member.alarm = false
            print(rowIndex)
            print(member.alarm)
            completionHandler(true)
        }
        
        
        let fix = UIContextualAction(style: .normal, title: "상단에 고정") { (action, view, completionHandler) in
            completionHandler(true)
        }
        
        let exit = UIContextualAction(style: .normal, title: "나가기") { (action, view, completionHandler) in
            self.exitRoom()
            completionHandler(true)
        }

        hide.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        fix.backgroundColor = UIColor(red: 0.659, green: 0.659, blue: 0.659, alpha: 1)
        exit.backgroundColor = UIColor(red: 0.918, green: 0.255, blue: 0.263, alpha: 1)
        let config = UISwipeActionsConfiguration(actions: [exit, fix, hide])
        // 끝까지 안늘어나게 함
        config.performsFirstActionWithFullSwipe = false

        return config


    }
        
}


class ChattingTableUnreadMessageIcon : UIView{
    static let identifier = "unread"
    var unreadView : UIView = {
        let unreadView = UIView()
        unreadView.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        unreadView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        unreadView.layer.cornerRadius = unreadView.frame.height/2
        return unreadView
    }()
    var unreadMeassageNumber : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(unreadView)
        unreadView.addSubview(unreadMeassageNumber)
        unreadMeassageNumber.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}


class ChattingTableViewControllerCell:UITableViewCell{
    static let identifier = "cell"
    let myView = UIView()
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.height/2
        return view
        
    }()
    var roomName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var memberNumber:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.5)


        return label
    }()
    
    var latestMessage:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.5)
        label.numberOfLines = 2

        return label
    }()
    
    var latestMessageTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.5)
        return label
    }()
    
    var unreadMessage : ChattingTableUnreadMessageIcon = {
        let view = ChattingTableUnreadMessageIcon()
        return view
    }()
    
    var alarmOff:UIImageView = {
        let image = UIImage(named: "iconAlarmOff")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        imageView.alpha = 0.3
        
        return imageView
    }()
    
    var roomFix:UIImageView = {
        let image = UIImage(named: "iconFix")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        imageView.alpha = 0.3
        
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
