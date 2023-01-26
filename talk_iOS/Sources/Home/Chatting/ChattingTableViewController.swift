//
//  ChattingTableViewController.swift
//  talk_iOS
//
//  Created by 김희윤 on 2023/01/12.
//

import UIKit

class ChattingTableViewController: UIViewController {
    
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
        let roomName : String
//        var roomImage : UIImage? {
//            return UIImage(named: roomName)
//        }
        let memberNumber : Int
        let latestMessage : String
        let latestMessageTime : String
        let unreadMessageNumber : Int

    }
    
    let testArr = ["a","b","c","d","e","f","g"]
    
    func attribute(){
        table.register(ChattingTableViewControllerCell.classForCoder()
                       , forCellReuseIdentifier: "cell")
    }
    let sampleData: [DataModel] = [
        DataModel(roomName: "모임톡", memberNumber: 8, latestMessage: "ddd", latestMessageTime: "12:58", unreadMessageNumber: 3),
        DataModel(roomName: "모임톡프론트", memberNumber: 3, latestMessage: "어케함?", latestMessageTime: "1:32", unreadMessageNumber: 32),
        DataModel(roomName: "모임톡백엔드", memberNumber: 5, latestMessage: "응응", latestMessageTime: "2:58", unreadMessageNumber: 33)
        ]
    
    let items: [String] = ["iOS", "iOS 앱", "iOS 앱 개발", "iOS 앱 개발 알아가기", "iOS 앱 개발 알아가기 jake"]
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
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
        attribute()
        layout()


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
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btnSearch"), for: .normal)
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
                searchTextField.leftView = nil
                searchTextField.placeholder = "채팅방 이름, 참여자 검색"
                searchTextField.rightView = button
                searchTextField.rightViewMode = UITextField.ViewMode.always
                searchTextField.backgroundColor = .white
//        searchTextField.translatesAutoresizingMaskIntoConstraints  = false
//        NSLayoutConstraint.activate([
//                    searchTextField.heightAnchor.constraint(equalToConstant: 56),
//                    searchTextField.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: 9),
//                    searchTextField.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 9),
//        ])
//        searchTextField.backgroundColor = .white
            searchTextField.borderStyle = .none
            searchTextField.layer.cornerRadius = 8.0
            searchTextField.layer.shadowOpacity = 1
            searchTextField.layer.shadowRadius = 8.0
            searchTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
            searchTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
    
    let profileImageView:UIImageView = {
             let img = UIImageView()
             img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
             img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
             img.layer.cornerRadius = 35
             img.clipsToBounds = true
            return img
         }()
    let nameLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor =  .green
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    let jobTitleDetailedLabel:UILabel = {
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .purple
        label.backgroundColor = .blue
      label.layer.cornerRadius = 5
      label.clipsToBounds = true
      label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()


    
    func setupSearchController() {
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.backgroundColor = .white
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func refresh(){
        print("몽글몽글")
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
            let alert = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
            let privateButton = UIAlertAction(title: "비공개 채팅방", style: .default)
            let publicButton = UIAlertAction(title: "공개 채팅방", style: .default)
            let cancleButton = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(privateButton)
            alert.addAction(publicButton)
            alert.addAction(cancleButton)
            self.present(alert, animated: true)

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

extension ChattingTableViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewControllerCell.identifier, for:indexPath) as? ChattingTableViewControllerCell else {return UITableViewCell()}
        tableView.rowHeight = 89
        let member = self.sampleData[indexPath.row]
        cell.roomName.text = member.roomName
        cell.memberNumber.text = "\(member.memberNumber)"
        cell.latestMessage.text = member.latestMessage
        cell.latestMessageTime.text = member.latestMessageTime
       return cell
    }
    
    
}

class ChattingTableViewControllerCell:UITableViewCell{
    static let identifier = "cell"
    let a = "ss"
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
    
    var unreadMessage:UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.height/2
        return view
    }()
    
    var profileImage2:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.height/2
        return view
    }()



    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)
        
        
        // MyView
        self.contentView.addSubview(myView)
        myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        // profileImage
        myView.addSubview(profileImage)
        profileImage.snp.makeConstraints{
            $0.width.height.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        // name
        myView.addSubview(roomName)
        roomName.snp.makeConstraints{
//            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).inset(-16)
            $0.top.equalTo(profileImage.snp.top)
            
        }
        
        myView.addSubview(memberNumber)
        memberNumber.snp.makeConstraints{
            $0.leading.equalTo(roomName.snp.trailing).inset(-2)
            $0.top.equalTo(roomName.snp.top)

            
        }
        
        myView.addSubview(latestMessage)
        latestMessage.snp.makeConstraints{
            $0.top.equalTo(roomName.snp.bottom).inset(-3)
            $0.leading.equalTo(roomName.snp.leading)
            
        }
        
        myView.addSubview(latestMessageTime)
        latestMessageTime.snp.makeConstraints{
            $0.top.equalTo(roomName.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            
        }
        
//        myView.addSubview(unreadMessage)
//        unreadMessage.snp.makeConstraints{
//            $0.bottom.equalTo(profileImage.snp.bottom)
////            $0.trailing.equalTo(latestMessageTime.snp.leading)
//        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
