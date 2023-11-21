//
//  DiseaseTableView.swift
//  DiseaseNotification
//
//  Created by 정성윤 on 2023/11/20.
//

import Foundation
import UIKit
import UserNotifications
struct Post: Decodable {
    let dissCd : String //질병코드
    let dt : String //예측진료데이터 연월일
    let cnt : Int //질병예측진료건수
    let risk : String //질병예측위험도
    let dissRiskXpln : String //질병위험도 지침
}
class DiseaseTableView : UIViewController {
    var tableView = UITableView()
    var currentPage = 0
    var posts : [Post] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(
            red: CGFloat((0x2D31AC & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((0x2D31AC & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(0x2D31AC & 0x0000FF) / 255.0,
            alpha: 1.0)
        self.title = "질병"
        if let navigationBar = navigationController?.navigationBar {
                navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]}
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = UIColor(
            red: CGFloat((0x2D31AC & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((0x2D31AC & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(0x2D31AC & 0x0000FF) / 255.0,
            alpha: 1.0)
        setTableview()
        setUpViews()
        // 처음에 초기 데이터를 불러옴
        let fetchs = ["1","2","3","4","5","15","16"]
        for fetch in fetchs{
            fetchPosts(dissCd: fetch) { [weak self] (newPosts, error) in
                    guard let self = self else { return }
                    
                    if let newPosts = newPosts {
                        // 초기 데이터를 posts 배열에 추가
                        self.posts += newPosts
                        
                        // 테이블 뷰 갱신
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        print("Initial data fetch - Success")
                    } else if let error = error {
                        // 오류 처리
                        print("Error fetching initial data: \(error.localizedDescription)")
                    }
                }
        }
    }
    func setUpViews() {
        let StackView = UIStackView()
        StackView.distribution = .fill
        StackView.backgroundColor = .white
        StackView.axis = .vertical
        StackView.addArrangedSubview(tableView)
        self.view.addSubview(StackView)
        StackView.snp.makeConstraints{ (make) in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.bottom.equalToSuperview().offset(-0)
        }
        tableView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.trailing.equalToSuperview().inset(0)
        }
    }
}
extension DiseaseTableView : UITableViewDelegate, UITableViewDataSource {
    func setTableview() {
        //UITableViewDelegate, UITableDataSource 프로토콜을 해당 뷰컨트롤러에서 구현
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //UITableView에 셀 등록
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.dissCd
        cell.commentLabel.text = "예측진료데이터 연월일 : " + post.dt
        cell.dangerView.text = "위험도 : " + "\(post.risk)"
        switch post.risk {
        case "관심":
            cell.dangerView.textColor = .black
        case "주의":
            cell.dangerView.textColor = .brown
        case "경고":
            cell.dangerView.textColor = .orange
        case "위험":
            cell.dangerView.textColor = .red
        default:
            cell.dangerView.textColor = .black
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = posts[indexPath.row]
        showPostDetail(post: post)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //셀을 선택했을 때 해당 게시물의 상세 내용을 보여주기 위함
    func showPostDetail(post: Post){
        let detailViewController = DiseaseDetailViewController(post: post)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    //https://velog.io/@yeahg_dev/공공데이터포털-SERVICEKEYISNOTREGISTEREDERROR-원인-파헤치기
    func fetchPosts(dissCd: String, completion: @escaping ([Post]?, Error?) -> Void) {
        let residence = UserDefaults.standard.string(forKey: "residence")
        var zncd = 99
        switch residence {
        case "서울":
            zncd = 11
        case "부산":
            zncd = 26
        case "대구":
            zncd = 27
        case "인천":
            zncd = 28
        case "광주":
            zncd = 29
        case "대전":
            zncd = 30
        case "울산":
            zncd = 31
        case "경기":
            zncd = 41
        case "강원":
            zncd = 42
        case "충북":
            zncd = 43
        case "충남":
            zncd = 44
        case "전북":
            zncd = 45
        case "전남":
            zncd = 46
        case "경북":
            zncd = 47
        case "경남":
            zncd = 48
        case "제주":
            zncd = 49
        case "전국":
            zncd = 99
        default:
            zncd = 99
        }
        var urls = "http://apis.data.go.kr/B550928/dissForecastInfoSvc/getDissForecastInfo?serviceKey=h4hO27P1QmkBazJt0HvhbEmpyJh8geIPaF6UHTdu8Q6YdeX%2FxwIr%2FcMXyQoPsyyETxW%2BWTQWQlK85ISBHl2nOg%3D%3D&numOfRows=1&pageNo=1&type=json&dissCd=\(dissCd)&znCd="
        if zncd == 99{
            urls = "http://apis.data.go.kr/B550928/dissForecastInfoSvc/getDissForecastInfo?serviceKey=h4hO27P1QmkBazJt0HvhbEmpyJh8geIPaF6UHTdu8Q6YdeX%2FxwIr%2FcMXyQoPsyyETxW%2BWTQWQlK85ISBHl2nOg%3D%3D&numOfRows=1&pageNo=1&type=json&dissCd=\(dissCd)&znCd="
        }
        
        let urlss = URL(string: urls)
        // URLRequest 생성
        var request = URLRequest(url: urlss!)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("에러 : \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, nil)
                return
            }
            print(String(data: data, encoding: .utf8) ?? "데이터 출력 실패")

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let response = json?["response"] as? [String: Any], let bodys = response["body"] as? [String:Any],
                   let items = bodys["items"] as? [[String:Any]]{
                    var posts = [Post]()
                    for item in items {
                        if let cnt = item["cnt"] as? Int,
                           let dis = item["dissCd"] as? String,
                           let dissRiskXpln = item["dissRiskXpln"] as? String,
                           let dt = item["dt"] as? String,
                           let r = item["risk"] as? Int{
                            var dissCd = ""
                            var risk = ""
                            switch dis {
                            case "1":
                                dissCd = "감기"
                            case "2":
                                dissCd = "눈병"
                            case "3":
                                dissCd = "식중독"
                            case "4":
                                dissCd = "천식"
                            case "5":
                                dissCd = "피부염"
                            case "15":
                                dissCd = "심뇌혈관 질환"
                            case "16":
                                dissCd = "온열질환"
                            default:
                                dissCd = "감기"
                            }
                            switch r {
                            case 1:
                                risk = "관심"
                            case 2:
                                risk = "주의"
                            case 3:
                                risk = "경고"
                                LocalNotificationHelper.scheduleNotification(title: "알려질병", body: "\(dissCd) 유행 질병이 경고 수준입니다.\n\(dissRiskXpln)", seconds: 15, identifier: "identifier")
                            case 4:
                                risk = "위험"
                                LocalNotificationHelper.scheduleNotification(title: "알려질병", body: "\(dissCd) 유행 질병이 위험 수준입니다.\n\(dissRiskXpln)", seconds: 15, identifier: "identifier")
                            default:
                                risk = "관심"
                            }
                           let post = Post(dissCd: dissCd, dt: dt, cnt: cnt, risk: risk, dissRiskXpln: dissRiskXpln)
                            posts.append(post)
                        }
                    }
                    completion(posts, nil)
                }
            } catch let error as DecodingError {
                print("JSON 디코딩 에러: \(error)")
                completion(nil, error)
            } catch {
                print("기타 에러: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
}
