import UIKit
import Then

class BoxofficeViewController: UIViewController {
    
    private let boxofficeView = BoxofficeView()
    private let boxofficeViewModel = BoxofficeViewModel(apiService: APIService())
    private var output: BoxofficeViewModel.Output?
    private var movieCode: String?
    
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
        boxofficeView.detailButton.addTarget(self, action: #selector(detailButtonDidTap), for: .touchUpInside)
    }
    
    private func setData() {
        let input = BoxofficeViewModel.Input(
            handleNexButtonDidTap: { [weak self] in
                await self?.boxofficeViewModel.handleNextButtonDidTap()
            }
        )
        
        output = boxofficeViewModel.transform(input: input)
        
        output?.updateUI.onChange = { [weak self] data in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                self?.boxofficeView.rankLabel.text = data.rank
                self?.boxofficeView.movieTitleLabel.text = data.movieNm
                self?.boxofficeView.audienceLabel.text = data.audiAcc
                self?.movieCode = data.movieCd
            }
        }
    }
    
    @objc
    private func nextButtonDidTap() {
        Task {
            await boxofficeViewModel.handleNextButtonDidTap()
        }
    }
    
    @objc
    private func detailButtonDidTap() {
        guard let code = movieCode else { return }
        
        let viewModel = boxofficeViewModel.getDetailViewModel(from: code)
        let detailViewController = DetailViewController(detailViewModel: viewModel)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        Task {
            await viewModel.handleDetailButtonDidTap()
        }
    }
}
