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

class HomeMainViewController:UIViewController {
    static let identifier = "HomeMainViewController"
    
    let COLLECTIONVIEW_HEIGHT:CGFloat = 190
    let COLLECTIONVIEW_CELL_SIZE = CGSize(width: 134, height: 183)
    
    var groupList:[HomeMainGroup] = []
    var groupDetail:HomeMainGroupDetail?
    
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNaviBar()
        self.configureView()
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
    }
    
    // 가입되어 있는 Group의 정보를 받아오는 함수
    private func getGroupData(){
        // 서버에서 Group Data 받아와야 됨
        groupList.append(contentsOf: [
            .init(groupName: "모임톡", imageName: "", selecting: true),
            .init(groupName: "모임톡", imageName: "", selecting: false),
            .init(groupName: "모임톡", imageName: "", selecting: false),
            .init(groupName: "모임톡", imageName: "", selecting: false),
            .init(groupName: "모임톡", imageName: "", selecting: false),
            .init(groupName: "모임톡", imageName: "", selecting: false),
            .init(groupName: "모임톡", imageName: "", selecting: false),
        ])
    }
    
    private func getGroupDetail(){
        // O 읽지않음 데이터 받아와야 됨
        self.groupDetail = .init(newAnno: 1, newChat: 2, newVote: 3, memberCount: 4, newSchedule: 5, newTodo: 6)
    }
    
    private func configureView(){
        
        //groupChangeStackView
        self.view.addSubview(groupChangeStackView)
        groupChangeStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(17)
        }
        
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


struct HomeViewController_Previews:PreviewProvider{
    static var previews: some View{
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container:UIViewControllerRepresentable{
       
        
        func makeUIViewController(context: Context) -> UIViewController {
            let homeMainViewController = HomeMainViewController()
            return UINavigationController(rootViewController: homeMainViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
