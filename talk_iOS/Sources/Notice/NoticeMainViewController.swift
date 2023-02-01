
import UIKit

class NoticeMainViewController: UIViewController {
    
    static let identifier = "NoticeMainViewController"
    let table =  UITableView()
    
    var navigationLeftTitleButton:UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "알림"
        button.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var navigationRightTitleButton:UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "모두 삭제"
        button.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 16)], for: .normal)
        button.tintColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.6)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nil
        self.navigationItem.leftBarButtonItem = navigationLeftTitleButton
        self.navigationItem.rightBarButtonItem = navigationRightTitleButton
        table.delegate = self
        table.dataSource = self
        layout()
        attribute()
    }
    
    
    func layout() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    struct noticeDataModel{
        var noticeType : String
        var noticeName : String
        var meetingName : String
        var time : String
        var unreadNotice : Bool
    }
    
    func attribute(){
        table.register(NoticeTableViewControllerCell.classForCoder()
                       , forCellReuseIdentifier: "cell")
    }
        var sampleData: [noticeDataModel] = [
            noticeDataModel(noticeType: "공지", noticeName: "모임 규칙", meetingName: "모임1", time: "1시간 전", unreadNotice: true),
            noticeDataModel(noticeType: "투표", noticeName: "정기 모임 회식 장소", meetingName: "모임2", time: "1월 22일", unreadNotice: false),
            noticeDataModel(noticeType: "할 일", noticeName: "유저 인증 만드세요", meetingName: "모임3", time: "2시간 전", unreadNotice: true),
            noticeDataModel(noticeType: "채팅", noticeName: "탈주하지마세요", meetingName: "모임1", time: "10시간 전", unreadNotice: false),
            noticeDataModel(noticeType: "일정", noticeName: "4월 정기 모임 안내", meetingName: "모임2", time: "12월 21일", unreadNotice: false)
        ]


}



extension NoticeMainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewControllerCell.identifier, for:indexPath) as? NoticeTableViewControllerCell else {return UITableViewCell()}
        let rowIndex = indexPath.row
        let member : noticeDataModel
        member = self.sampleData[rowIndex]
        // MyView
        cell.contentView.addSubview(cell.myView)
        cell.myView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        cell.myView.addSubview(cell.profileImage)
        cell.profileImage.snp.makeConstraints{
            $0.width.height.equalTo(50)
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalToSuperview().inset(16)
        }
        
        cell.myView.addSubview(cell.noticeType)
        cell.noticeType.snp.makeConstraints{
            $0.leading.equalTo(cell.profileImage.snp.trailing).inset(-16)
            $0.top.equalTo(cell.profileImage.snp.top)
            
        }
        
        cell.myView.addSubview(cell.noticeName)
        cell.noticeName.snp.makeConstraints{
            $0.leading.equalTo(cell.noticeType.snp.leading)
            $0.top.equalTo(cell.noticeType.snp.bottom).inset(-7)
        }
        
        cell.myView.addSubview(cell.meetingName)
        cell.meetingName.snp.makeConstraints{
            $0.leading.equalTo(cell.noticeType.snp.leading)
            $0.top.equalTo(cell.noticeName.snp.bottom).inset(-7)

        }
        
        cell.myView.addSubview(cell.bar)
        cell.bar.snp.makeConstraints{
            $0.top.equalTo(cell.meetingName.snp.top)
            $0.leading.equalTo(cell.meetingName.snp.trailing).inset(-5)
            

        }
        
        cell.myView.addSubview(cell.time)
        cell.time.snp.makeConstraints{
            $0.top.equalTo(cell.meetingName.snp.top)
            $0.leading.equalTo(cell.bar.snp.trailing).inset(-5)

        }
        
        if(member.unreadNotice){
            cell.myView.addSubview(cell.unreadNotice)
            cell.unreadNotice.snp.makeConstraints{
                $0.top.equalTo(cell.noticeType.snp.top)
                $0.trailing.equalToSuperview().inset(30)
            }
        }
        if(member.unreadNotice){
            cell.myView.backgroundColor = UIColor(red: 0.271, green: 0.553, blue: 0.784, alpha: 0.05)
        }
        
        tableView.rowHeight = 104
        cell.noticeType.text = member.noticeType
        cell.noticeName.text = "\(member.noticeName)"
        cell.meetingName.text = member.meetingName
        cell.bar.text = "|"
        cell.time.text = member.time
        
       return cell
    }
        
}


class NoticeTableUnreadIcon : UIView{
    static let identifier = "unread"
    var unreadView : UIView = {
        let unreadView = UIView()
        unreadView.backgroundColor = UIColor(red: 0.922, green: 0.184, blue: 0.188, alpha: 1)
        unreadView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        unreadView.layer.cornerRadius = unreadView.frame.height/2
        return unreadView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(unreadView)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class NoticeTableViewControllerCell:UITableViewCell{
    static let identifier = "cell"
    let myView = UIView()
    var profileImage:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.layer.cornerRadius = view.frame.height/2
        return view
        
    }()
    
    var noticeType:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black

        return label
    }()
    
    var noticeName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black


        return label
    }()
    
    var meetingName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.5)
        label.numberOfLines = 1

        return label
    }()
    
    var bar:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    var time:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.094, green: 0.078, blue: 0.255, alpha: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    var unreadNotice : NoticeTableUnreadIcon = {
        let view = NoticeTableUnreadIcon()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: InviteChattingPartnerTableViewCell.identifier)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
