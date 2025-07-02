import SnapKit
import Then
import UIKit

final class MovieDetailView: UIView {
    
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let stackView = UIStackView()
    let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        nameLabel.do {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textAlignment = .center
        }
        
        dateLabel.do {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.textAlignment = .center
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        timeLabel.do {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.textAlignment = .center
        }
    }
    
    private func setLayout() {
        stackView.addSubViews(nameLabel, dateLabel)
        addSubViews(stackView, timeLabel)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(300)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalTo(stackView)
            $0.width.equalTo(98)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(stackView)
            $0.width.equalTo(98)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
}
