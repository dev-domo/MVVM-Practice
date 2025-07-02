import Combine
import UIKit
import Then

class BoxofficeViewController: UIViewController {
    
    private let boxofficeView = BoxofficeView()
    private let boxofficeViewModel = BoxofficeViewModel(
        boxofficeUseCase: BoxofficeUseCase(boxofficeRepository: BoxofficeRepository(network: APIService()))
    )
    private let input = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []
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
        let input = BoxofficeViewModel.Input(handleNexButtonDidTap: input.eraseToAnyPublisher())
        
        let output = boxofficeViewModel.transform(input: input)
        
        output.result
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .success(let entity):
                    self.updateUI(from: entity)
                case .failure(let error):
                    print("Error: ", error)
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(from entity: BoxofficeEntity) {
        boxofficeView.do {
            $0.rankLabel.text = entity.rank
            $0.movieTitleLabel.text = entity.name
            $0.audienceLabel.text = boxofficeViewModel.formatAudience(entity.audienceCount)
            movieCode = entity.code
        }
    }
    
    @objc
    private func nextButtonDidTap() {
        input.send()
    }
    
    @objc
    private func detailButtonDidTap() {
//        guard let code = movieCode else { return }
//        
//        let viewModel = boxofficeViewModel.getDetailViewModel(from: code)
//        let detailViewController = DetailViewController(detailViewModel: viewModel)
//        
//        self.navigationController?.pushViewController(detailViewController, animated: true)
//        
//        Task {
//            await viewModel.handleDetailButtonDidTap()
//        }
    }
}
