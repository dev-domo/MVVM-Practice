import Combine
import UIKit

final class MovieDetailViewController: UIViewController {
    
    private let detailView = MovieDetailView()
    private let detailViewModel: MovieDetailViewModel
    private let input = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    init(detailViewModel: MovieDetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setData()
        input.send()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setData() {
        let input = MovieDetailViewModel.Input(handleDetailButtonDidTap: input.eraseToAnyPublisher())
        let output = detailViewModel.transform(input: input)
        
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
    
    private func updateUI(from entity: MovieDetailEntity) {
        detailView.do {
            $0.dateLabel.text = detailViewModel.formatDate(entity.openDate)
            $0.nameLabel.text = entity.name
            $0.timeLabel.text = detailViewModel.formatRunnintTime(entity.runningTime)
        }
    }
}
