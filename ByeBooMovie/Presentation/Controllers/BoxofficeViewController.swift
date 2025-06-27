import UIKit
import Then

class BoxofficeViewController: UIViewController {
    
    private let boxofficeView = BoxofficeView()
    private let boxofficeViewModel = BoxofficeViewModel(apiService: APIService())
    
    override func loadView() {
        view = boxofficeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setActions()
        setData()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setActions() {
        boxofficeView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    private func setData() {
        self.boxofficeViewModel.onCompleted = { [weak self] _ in
            DispatchQueue.main.async {
                self?.boxofficeView.do {
                    $0.rankLabel.text = self?.boxofficeViewModel.rank
                    $0.movieTitleLabel.text = self?.boxofficeViewModel.title
                    $0.audienceLabel.text = self?.boxofficeViewModel.audience
                }
            }
        }
    }
    
    @objc
    private func nextButtonDidTap() {
        Task {
            await boxofficeViewModel.handleNextButtonDidTap()
        }
    }
}
