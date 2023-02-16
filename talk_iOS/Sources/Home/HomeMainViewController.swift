//
//  MainTabBarController.swift
//  talk_iOS
//
//  Created by User on 2023/01/06.


import UIKit
import SwiftUI
import SnapKit
import CoreData



class HomeMainViewController : UIViewController {
    static let identifier = "HomeMainViewController"
    
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width//Screen Width는 불변변수이므로 let 선언
    var SCROLL_VIEW_HEIGHT = 640 // 화면 높이 직접 계산함
    var VOTE_WIDTH:CGFloat = 0.0
    let COLLECTIONVIEW_HEIGHT:CGFloat = 190
    let COLLECTIONVIEW_CELL_SIZE = CGSize(width: 134, height: 183)
    
    let client = CoreDataClient()
    var user:UserData?
    
    // 이거 그냥 ID 말고 meeting으로 바꾸는게 나을 듯
    var currentMeetingId:Int32?{
        didSet{
            print(self.currentMeetingId ?? "없다")
            let meeting = meetingList.filter{$0.id == currentMeetingId}
            self.memberCount.text = "\(meeting[0].memberCount)"
        }
    }
    var meetingList:[MeetingData] = []{
        didSet{
            let currentMeeting = self.meetingList.filter{$0.id == self.currentMeetingId}
            // currentMeeting을 새로 지정
            if currentMeeting.count == 0{
                self.currentMeetingId = self.meetingList[0].id
            } else{
                self.currentMeetingId = currentMeeting[0].id
            }
            
            self.collectionView.reloadData()
        }
    }
    var meetingScrolled = false
    var selectedGroup:Int?
    
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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    //contentview 생성
    private let contentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 공지사항 View
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
        
        let subtitle = UILabel()
        subtitle.text = "최근 공지사항 제목"
        subtitle.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        subtitle.font = .systemFont(ofSize: 11, weight: .light)
        view.addSubview(subtitle)
        subtitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(52)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeAnnouncementIcon"))
        view.addSubview(icon)
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
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
        
        let subtitle = UILabel()
        subtitle.text = "최근 채팅메시지"
        subtitle.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        subtitle.font = .systemFont(ofSize: 11, weight: .light)
        view.addSubview(subtitle)
        subtitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(52)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeChattingIcon"))
        view.addSubview(icon)
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()
    
    //투표View
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
        
        let subtitle = UILabel()
        subtitle.text = "최근 투표 제목"
        subtitle.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        subtitle.font = .systemFont(ofSize: 11, weight: .light)
        view.addSubview(subtitle)
        subtitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(52)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeVoteIcon"))
        view.addSubview(icon)
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()
    
    //멤버View
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
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()
    
    let memberCount:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
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
        
        let subtitle = UILabel()
        subtitle.text = "1/31 최근 일정 제목"
        subtitle.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        subtitle.font = .systemFont(ofSize: 11, weight: .light)
        view.addSubview(subtitle)
        subtitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(52)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeVoteIcon"))
        view.addSubview(icon)
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
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
        
        let subtitle = UILabel()
        subtitle.text = "D-1 최근 할 일 제목"
        subtitle.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 1)
        subtitle.font = .systemFont(ofSize: 11, weight: .light)
        view.addSubview(subtitle)
        subtitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(52)
            make.leading.equalToSuperview().inset(16)
        }
        
        let icon = UIImageView(image: UIImage(named: "homeVoteIcon"))
        view.addSubview(icon)
        icon.layer.cornerRadius = 8
        icon.layer.masksToBounds = true
        icon.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        VOTE_WIDTH = (SCREEN_WIDTH/2)-16
        self.setUpNaviBar()
        self.configureCollectionView()
        self.configureScrollView()
        collectionView.register(HomeMainCollectionViewCell.self, forCellWithReuseIdentifier: HomeMainCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchDataFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpNaviBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.red]
        self.navigationController?.navigationBar.tintColor = .black
        let backBarButton = UIBarButtonItem(title: "돌아가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.isNavigationBarHidden = true
    }
    

    // 처음에 Meeting 정보를 CoreData에서 받아옴(서버에서 받아오지 않는다)
    // 받아오는데 실패하면 서버에서 받아오기(새로고침이랑 같은 로직 적용)
    private func fetchDataFromCoreData(){
        let meetings = client.getMeetings()
        guard meetings.count > 0 else {return} // 서버 fetch
        func fetch() throws -> [MeetingData] {
            self.user = client.getUser() // 유저 받아오기
            let meetings = client.getMeetings()
            if meetings.count > 0 {return meetings}
            throw CoreDataClient.CoreDataError.coreDataError(message: "알 수 없는 이유로 Meeting 데이터가 빈값으로 나옴")
        }
        func completionHandler<T>(_ result:Result<T, Error>) -> Void{
            switch result{
            case let .success(data):
                guard let meetings = data as? [MeetingData] else {return} // refresh
                self.meetingList = meetings
                let currentMeetingId = self.user?.currentMeetingId
                self.currentMeetingId = currentMeetingId ?? meetings[0].id
            case let .failure(error):
                print(error) // refresh
            }
        }
        fetchData(fetch: fetch, completion: completionHandler(_:))
    }
    
    // 모임이 바뀌면 그에 따라 화면 내용 바꾸기
    private func updateViewFromCurrentMeeting(_ meeting:MeetingData){
        
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
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(groupChangeStackView.snp.bottom).inset(-17)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        //scrollView 위에 contentView를 올림
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(SCROLL_VIEW_HEIGHT)
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
            $0.width.equalTo(VOTE_WIDTH)
        }
        
        // memberView
        memberView.snp.makeConstraints{
            $0.top.equalTo(chattingView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(VOTE_WIDTH)
        }
        
        memberView.addSubview(memberCount)
        memberCount.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(15)
        }
        let 명 = UILabel()
        명.text = "명"
        명.font = .systemFont(ofSize: 10, weight: .regular)
        memberView.addSubview(명)
        명.snp.makeConstraints{ make in
            make.leading.equalTo(memberCount.snp.trailing).inset(-4)
            make.bottom.equalToSuperview().inset(18)
        }
        
        //캘린더view autolayout 설정
        calenderView.snp.makeConstraints{
            $0.top.equalTo(voteView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.leading.equalToSuperview().inset(8)
            $0.width.equalTo(VOTE_WIDTH)
        }
        
        //할일view autolayout 설정
        todoView.snp.makeConstraints{
            $0.top.equalTo(memberView.snp.bottom).inset(-20)
            $0.height.equalTo(140)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(VOTE_WIDTH)
        }
        
        chattingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapChattingView)))
        memberView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMemberView)))
        announcementView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAnnouncementView)))
        
    }
    
    
    @objc func tapGroupChangeStackView(){
//        self.view.layoutIfNeeded()
        if self.meetingScrolled{
            groupChangeTitle.text = "모임명"
            groupChangeTitle.font = .systemFont(ofSize: 24, weight: .bold)
            self.contentView.snp.remakeConstraints{ make in
                make.width.equalToSuperview()
                make.height.equalTo(SCROLL_VIEW_HEIGHT)
                make.top.bottom.leading.trailing.equalToSuperview()
            }
        } else{
            var text = ""
            if let user = self.user{
                text = "\(user.name)님 어느 모임에 참가하시겠습니까?"
            } else{
                text = "어느 모임에 참가하시겠습니까?"
            }
            groupChangeTitle.text = text
            groupChangeTitle.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            animations: {
//                self.testViewTopConstraint?.update(inset: 100)
                if self.meetingScrolled{
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
                self.meetingScrolled = !self.meetingScrolled
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
    @objc func tapAnnouncementView(){
        print("공지사항 클릭")
//        pushViewController(target: self, storyBoardName: "Announcement", identifier: AnnouncementViewController.identifier)
        pushViewController(target: self, storyBoardName: "Member", identifier: MemberViewController.identifier)
        
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


