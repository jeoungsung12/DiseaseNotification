//
//  DiseaseDetailView.swift
//  DiseaseNotification
//
//  Created by 정성윤 on 2023/11/20.
//

import Foundation
import UIKit

class DiseaseDetailViewController : UIViewController {
    let post : Post
    //이니셜라이저를 사용하여 Post 객체를 전달받아 post 속성에 저장
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(
            red: CGFloat((0x2D31AC & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((0x2D31AC & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(0x2D31AC & 0x0000FF) / 255.0,
            alpha: 1.0)
        self.title = post.dissCd // 질병 코드
        if let navigationBar = navigationController?.navigationBar {
                navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]}
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = UIColor(
            red: CGFloat((0x2D31AC & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((0x2D31AC & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(0x2D31AC & 0x0000FF) / 255.0,
            alpha: 1.0)
        setupViews()
    }
    func setupViews() {
        let StackView = UIStackView()
        StackView.spacing = 10
        StackView.distribution = .fill
        StackView.axis = .vertical
        //전체 다이어리 글
        let cntView = UIStackView()
        cntView.backgroundColor = .white
        cntView.layer.cornerRadius = 10
        cntView.layer.masksToBounds = true
        cntView.axis = .vertical
        cntView.distribution = .fill
        cntView.spacing = 10
        
        //질병예측진료건수
        let view = UIView()
        view.backgroundColor = .white
        let cntLabel = UILabel()
        cntLabel.textColor = .black
        cntLabel.backgroundColor = .white
        cntLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cntLabel.text = "질병예측진료건수 : "
        view.addSubview(cntLabel)
        cntLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().inset(20)
        }
        cntView.addArrangedSubview(view)
        view.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(0)
        }
        let cntsubView = UIStackView()
        cntsubView.backgroundColor = .white
        cntsubView.layer.cornerRadius = 10
        cntsubView.layer.masksToBounds = true
        cntsubView.axis = .horizontal
        cntsubView.distribution = .fill
        cntsubView.spacing = 10
        let cntexplain = UILabel()
        cntexplain.textColor = .lightGray
        cntexplain.backgroundColor = .white
        cntexplain.font = UIFont.boldSystemFont(ofSize: 20)
        cntexplain.text = "Cnt"
        cntsubView.addArrangedSubview(cntexplain)
        cntexplain.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().inset(0)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        let cnt = UITextField()
        cnt.isEnabled = false
        cnt.text = "\(post.cnt)"
        cnt.textColor = .black
        cnt.textAlignment = .left
        cnt.font = UIFont.boldSystemFont(ofSize: 30)
        cntsubView.addArrangedSubview(cnt)
        cnt.snp.makeConstraints{ (make) in
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(0)
            make.width.equalToSuperview().dividedBy(2)
        }
        cntView.addArrangedSubview(cntsubView)
        cntsubView.snp.makeConstraints{(make) in
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(0)
        }
        //질병별 예측 위험도 등급
        let view2 = UIView()
        view2.backgroundColor = .white
        let riskView = UIStackView()
        riskView.backgroundColor = .white
        riskView.layer.cornerRadius = 10
        riskView.layer.masksToBounds = true
        riskView.axis = .vertical
        riskView.distribution = .fill
        let riskLabel = UILabel()
        riskLabel.textColor = .black
        riskLabel.backgroundColor = .white
        riskLabel.font = UIFont.boldSystemFont(ofSize: 20)
        riskLabel.text = "질병별 예측 위험도 등급 : "
        view2.addSubview(riskLabel)
        riskLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().inset(20)
        }
        riskView.addArrangedSubview(view2)
        view2.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview().offset(0)
        }
        let risksubView = UIStackView()
        risksubView.backgroundColor = .white
        risksubView.layer.cornerRadius = 10
        risksubView.layer.masksToBounds = true
        risksubView.axis = .horizontal
        risksubView.distribution = .fill
        risksubView.spacing = 10
        let riskexplain = UILabel()
        riskexplain.textColor = .lightGray
        riskexplain.backgroundColor = .white
        riskexplain.font = UIFont.boldSystemFont(ofSize: 20)
        riskexplain.text = "Risk"
        risksubView.addArrangedSubview(riskexplain)
        riskexplain.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().inset(0)
            make.width.equalToSuperview().dividedBy(1.4)
        }
        let riskcnt = UITextField()
        riskcnt.isEnabled = false
        riskcnt.text = post.risk
        switch post.risk {
        case "관심":
            riskcnt.textColor = .black
        case "주의":
            riskcnt.textColor = .brown
        case "경고":
            riskcnt.textColor = .orange
        case "위험":
            riskcnt.textColor = .red
        default:
            riskcnt.textColor = .black
        }
        riskcnt.font = UIFont.boldSystemFont(ofSize: 30)
        risksubView.addArrangedSubview(riskcnt)
        riskcnt.snp.makeConstraints{ (make) in
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(0)
            make.width.equalToSuperview().dividedBy(2.2)
        }
        riskView.addArrangedSubview(risksubView)
        risksubView.snp.makeConstraints{(make) in
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        
        //질병위험도에 따른 행동요령
        let view3 = UIView()
        view3.backgroundColor = .white
        let plnView = UIStackView()
        plnView.backgroundColor = .white
        plnView.layer.cornerRadius = 10
        plnView.layer.masksToBounds = true
        plnView.spacing = 30
        plnView.axis = .vertical
        plnView.distribution = .fill
        let plnLabel = UILabel()
        plnLabel.textColor = .black
        plnLabel.backgroundColor = .white
        plnLabel.font = UIFont.boldSystemFont(ofSize: 20)
        plnLabel.text = "질병위험도에 따른 행동요령 : "
        view3.addSubview(plnLabel)
        plnLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().inset(20)
        }
        plnView.addArrangedSubview(view3)
        view3.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview().offset(0)
        }
        let pln = UITextView()
        pln.isEditable = false
        pln.text = post.dissRiskXpln
        pln.textColor = .lightGray
        pln.font = UIFont.boldSystemFont(ofSize: 15)
        plnView.addArrangedSubview(pln)
        pln.snp.makeConstraints{ (make) in
            make.height.equalTo(30)
            make.top.equalTo(plnLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        let hospitalBtn = UIButton()
        hospitalBtn.backgroundColor = .white
//        hospitalBtn.tintColor = UIColor(
//            red: CGFloat((0x2D31AC & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((0x2D31AC & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(0x2D31AC & 0x0000FF) / 255.0,
//            alpha: 1.0)
        hospitalBtn.setTitle("  가까운 병원 찾아보기", for: .normal)
        hospitalBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        hospitalBtn.setTitleColor(UIColor(
            red: CGFloat((0x2D31AC & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((0x2D31AC & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(0x2D31AC & 0x0000FF) / 255.0,
            alpha: 1.0), for: .normal)
        hospitalBtn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        hospitalBtn.addTarget(self, action: #selector(hospitalBtnTapped), for: .touchUpInside)
        plnView.addArrangedSubview(hospitalBtn)
        hospitalBtn.snp.makeConstraints{ (make) in
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-30)
        }
        let plnsp = UIView()
        plnsp.backgroundColor = .white
        plnView.addArrangedSubview(plnsp)
        
        let Spacing = UIView()
        Spacing.backgroundColor = .white
        StackView.addArrangedSubview(Spacing)
        StackView.addArrangedSubview(cntView)
        StackView.addArrangedSubview(riskView)
        let Spacing2 = UIView()
        Spacing2.backgroundColor = .white
        StackView.addArrangedSubview(plnView)
        StackView.addArrangedSubview(Spacing2)
        self.view.addSubview(StackView)
        StackView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 17.5)
            make.leading.trailing.equalToSuperview().inset(0)
        }
        cntView.snp.makeConstraints{ (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(0)
            make.height.equalToSuperview().dividedBy(5)
        }
        riskView.snp.makeConstraints{ (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(cntView.snp.bottom).offset(10)
            make.height.equalToSuperview().dividedBy(5)
        }
        plnView.snp.makeConstraints{ (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(riskView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-0)
        }
    }
    @objc func hospitalBtnTapped() {
        print("hospitalBtnTapped - called()")
        let Alert = UIAlertController(title: "가까운 병원 찾아보기", message: nil, preferredStyle: .alert)
        let MapAlert = UIAlertAction(title: "지도 검색", style: .default){ _ in
            self.navigationController?.pushViewController(HospitalWebViewController(post: "지도"), animated: true)
        }
        let SearchAlert = UIAlertAction(title: "도로명/행정동 검색", style: .default){ _ in
            self.navigationController?.pushViewController(HospitalWebViewController(post: "명"), animated: true)
        }
        let Ok = UIAlertAction(title: "취소", style: .default){ _ in }
        Alert.addAction(MapAlert)
        Alert.addAction(SearchAlert)
        Alert.addAction(Ok)
        self.present(Alert, animated: true)
    }
}
