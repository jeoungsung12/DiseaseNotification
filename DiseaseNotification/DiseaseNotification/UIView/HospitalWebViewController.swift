//
//  HospitalWebViewController.swift
//  DiseaseNotification
//
//  Created by 정성윤 on 2023/11/21.
//

import Foundation
import UIKit
import WebKit

class HospitalWebViewController : UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var loadingIndicator: UIActivityIndicatorView!
    let hello = ""
    let post : String
    //이니셜라이저를 사용하여 Post 객체를 전달받아 post 속성에 저장
    init(post: String) {
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
        self.navigationController?.navigationBar.tintColor = .white
        // 웹 뷰 생성
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        webView.contentMode = .scaleAspectFit
        self.view.addSubview(webView)
        webView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.trailing.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
        }
        // 로딩 인디케이터 생성
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = .gray
        loadingIndicator.center = self.view.center
        self.view.addSubview(loadingIndicator)
        //응급의료포털(일반)
        var urlString = "https://www.e-gen.or.kr/egen/search_hospital.do?searchType=general"
        if(post == "지도"){
            urlString = "https://www.e-gen.or.kr/egen/search_hospital.do"
        }
        if let url = URL(string: urlString){
            // 웹 페이지를 로드하기 전에 로딩 화면 표시
            loadingIndicator.startAnimating()
            // 웹 페이지를 로드
            let request = URLRequest(url:url)
            webView.load(request)
        }
    }
    // 웹 페이지 로딩이 시작될 때 호출되는 메서드
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 로딩 화면 표시
        loadingIndicator.startAnimating()
    }
    // 웹 페이지 로딩이 종료될 때 호출되는 메서드
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 로딩 화면 숨김
        loadingIndicator.stopAnimating()
    }
}
