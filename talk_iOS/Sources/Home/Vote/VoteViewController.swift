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
        table.register(VoteTableViewCell.classForCoder()
                           , forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func addButton(){
        print("클릭했다.")
        pushViewController(target: self, storyBoardName: "Vote", identifier: VoteCreateViewController
            .identifier)
    }
    
    struct Root: Decodable {
        let votes : [VoteStruct]
    }
    
    struct VoteStruct: Decodable {
        let voteId : Int
        let title : String
        let desc : String?
        let categories: [categoryStruct]
        let multiSelection : Bool
        let anonymousVote : Bool
        let includingDeadline : Bool
        let deadline : String
        let creator : String
        let createDate : String
    }
    
    struct categoryStruct : Decodable{
        let name: String
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

