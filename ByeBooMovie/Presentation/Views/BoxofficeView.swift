import Then
import SnapKit
import UIKit

final class BoxofficeView: UIView {
    
    private let titleLabel = UILabel()
    private let movieView = UIView()
    let rankLabel = UILabel()
    let movieTitleLabel = UILabel()
    let audienceLabel = UILabel()
    private let movieInfoStackView = UIStackView()
    let nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        titleLabel.do {
            $0.text = "영화 랜덤박스"
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 18, weight: .bold)
        }
        
        movieView.do {
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
        }
        
        rankLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 25, weight: .bold)
        }
        
        movieTitleLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
        }
        
        audienceLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 17, weight: .regular)
        }
        
        movieInfoStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.alignment = .center
        }
        
        nextButton.do {
            $0.setTitle("다른 영화", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = 8
        }
    }
    
    private func setLayout() {
        movieInfoStackView.addSubViews(rankLabel, movieTitleLabel, audienceLabel)
        movieView.addSubview(movieInfoStackView)
        addSubViews(titleLabel, movieView, movieInfoStackView, nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.centerX.equalToSuperview()
        }
        
        movieView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(250)
        }
        
        movieInfoStackView.snp.makeConstraints {
            $0.center.equalTo(movieView)
            $0.width.equalTo(180)
            $0.height.equalTo(225)
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(movieInfoStackView).offset(50)
            $0.leading.equalTo(movieInfoStackView).offset(5)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(rankLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(movieInfoStackView)
        }
        
        audienceLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(movieInfoStackView)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(movieView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }
}
