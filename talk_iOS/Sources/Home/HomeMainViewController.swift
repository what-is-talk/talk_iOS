//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by User on 2023/01/06.
//

import UIKit
import SwiftUI
import SnapKit
import CoreData

class HomeMainViewController : UIViewController {
    static let identifier = "HomeMainViewController"
    
    let COLLECTIONVIEW_HEIGHT:CGFloat = 190
    let COLLECTIONVIEW_CELL_SIZE = CGSize(width: 134, height: 183)
    
    var groupList:[HomeMainGroup] = []
    var groupDetail:HomeMainGroupDetail?
    var groupSelecting = false
    
    let groupChangeTitle:UILabel = {
        let label = UILabel()
        label.text = "모임명"
        label.textColor =  .TalkRed
        label.font = .systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    let groupChangeIcon = UIImageView(image: .init(named: "btnGroupChange"))
    let groupChangeStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let settingBtn = UIImageView(image: .init(named: "btnSetting"))
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    
//    var testViewTopConstraint:Constraint?
    
    private let scrollView: UIView = {
        let scrollView = UIView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    //contentview 생성
    private let contentView = UIView()
    
    
    //contentview내에 추가할 label 생성
    let announcementView:UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        
        let title = UILabel()
        title.text = "공지사항"
        title.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeAnnouncementIcon"))
        view.addSubview(icon)
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        return view
    }()
    let chattingView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        
        let title = UILabel()
        title.text = "채팅"
        title.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeChattingIcon"))
        view.addSubview(icon)
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        return view
    }()
    let voteView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        
        let title = UILabel()
        title.text = "투표"
        title.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeVoteIcon"))
        view.addSubview(icon)
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()
    let memberView:UIView = {
        let view = UILabel()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        
        let title = UILabel()
        title.text = "멤버"
        title.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeMemberIcon"))
        view.addSubview(icon)
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()
    let calenderView:UIView = {
        let view = UILabel()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        
        let title = UILabel()
        title.text = "일정"
        title.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeMemberIcon"))
        view.addSubview(icon)
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()
    let todoView:UIView = {
        let view = UILabel()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.cornerRadius = 8
        
        let title = UILabel()
        title.text = "할 일"
        title.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        title.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeVoteIcon"))
        view.addSubview(icon)
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNaviBar()
        self.configureCollectionView()
        self.configureScrollView()
        self.getGroupData()
        self.getGroupDetail()
        collectionView.register(HomeMainCollectionViewCell.self, forCellWithReuseIdentifier: HomeMainCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setUpNaviBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.red]
        self.navigationController?.navigationBar.tintColor = .black
        let backBarButton = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // 가입되어 있는 Group의 정보를 받아오는 함수
    private func getGroupData(){
        // 서버에서 Group Data 받아와야 됨
        groupList.append(contentsOf: [
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: true),
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: false),
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: false),
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: false),
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: false),
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: false),
            .init(groupName: "모임톡", imageName: "appleLoginLogo", selecting: false),
        ])
    }

    
    private func getGroupDetail(){
        // O 읽지않음 데이터 받아와야 됨
        self.groupDetail = .init(newAnno: 1, newChat: 2, newVote: 3, memberCount: 4, newSchedule: 5, newTodo: 6)
    }
    
    private func configureCollectionView(){
        
        //groupChangeStackView
        self.view.addSubview(groupChangeStackView)
        groupChangeStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(17)
        }
        
        groupChangeStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGroupChangeStackView)))
        
        // groupChangeTitle, groupChangeIcon
        [groupChangeTitle, groupChangeIcon].forEach{
            groupChangeStackView.addArrangedSubview($0)
        }
        
        // settingBtn
        self.view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(17)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(15)
        }
        
        // collectionView
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(groupChangeStackView.snp.bottom).inset(-17)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(COLLECTIONVIEW_HEIGHT)
        }
        
       
        
    }
    private func configureScrollView(){
        // scrollView
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(groupChangeStackView.snp.bottom).inset(-17)
            make.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // contentView
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview() // 세로 스크롤
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        [announcementView, chattingView, memberView, calenderView, voteView, todoView].forEach{
            contentView.addSubview($0)
        }
        
        
        announcementView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(140)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        chattingView.snp.makeConstraints{
            $0.top.equalTo(announcementView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        
        
        voteView.snp.makeConstraints{
            $0.top.equalTo(chattingView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.leading.equalToSuperview().inset(8)
            $0.width.equalTo(178.5)
        }

        memberView.snp.makeConstraints{
            $0.top.equalTo(chattingView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(178.5)
        }
        
        
        
        calenderView.snp.makeConstraints{
            $0.top.equalTo(voteView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.leading.equalToSuperview().inset(8)
            $0.width.equalTo(178.5)
        }
        todoView.snp.makeConstraints{
            $0.top.equalTo(memberView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(178.5)
        }
        
        chattingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapChattingView)))
        announcementView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMemberView)))


    }
    
    
    @objc func tapGroupChangeStackView(){
//        self.view.layoutIfNeeded()
        if self.groupSelecting{
            groupChangeTitle.text = "모임명"
            groupChangeTitle.font = .systemFont(ofSize: 24, weight: .bold)
        } else{
            groupChangeTitle.text = "OO님 어느 모임에 참가하시겠습니까?"
            groupChangeTitle.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            animations: {
//                self.testViewTopConstraint?.update(inset: 100)
                if self.groupSelecting{
                    self.scrollView.snp.remakeConstraints{ make in
                        make.top.equalTo(self.groupChangeStackView.snp.bottom).inset(-17)
                        make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
                    }
                    
                } else{
                    self.scrollView.snp.remakeConstraints{ make in
                        make.top.equalTo(self.collectionView.snp.bottom).inset(-20)
                        make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
                    }
                }
                
                self.view.layoutIfNeeded()
                self.groupSelecting = !self.groupSelecting
        })
    }
    
    @objc func tapChattingView(){
        print("채팅뷰 클릭")
        pushViewController(target: self, storyBoardName: "ChattingTable", identifier: ChattingTableViewController.identifier)
    }
    
    @objc func tapMemberView(){
        print("멤버뷰 클릭")
        pushViewController(target: self, storyBoardName: "Member", identifier: MemberViewController.identifier)
    }

}

extension HomeMainViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeMainCollectionViewCell else {return UICollectionViewCell()}
        cell.groupImage = groupList[indexPath.row].image
        cell.groupName = groupList[indexPath.row].groupName
        cell.selecting = groupList[indexPath.row].selecting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let vInset = (COLLECTIONVIEW_HEIGHT - COLLECTIONVIEW_CELL_SIZE.width) / 2
        return UIEdgeInsets(top: vInset, left: 0, bottom: vInset, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return COLLECTIONVIEW_CELL_SIZE
    }
    
    // cell 선택되었을 때 동작할 함수
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭:\(indexPath.row)")
        for i in 0..<groupList.count{
            groupList[i].selecting = false
        }
        groupList[indexPath.row].selecting = true
        collectionView.reloadData()
    }
    
 
}


//struct HomeViewController_Previews:PreviewProvider{
//    static var previews: some View{
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container:UIViewControllerRepresentable{
//
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            let homeMainViewController = HomeMainViewController()
//            return UINavigationController(rootViewController: homeMainViewController)
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//
//        typealias UIViewControllerType = UIViewController
//    }
//}

