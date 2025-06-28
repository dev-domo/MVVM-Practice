import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    let detailViewModel: DetailViewModel
    
    init(detailViewModel: DetailViewModel) {
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
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setData() {
        detailViewModel.onCompleted = { [weak self] _ in
            DispatchQueue.main.async {
                self?.detailView.do {
                    $0.nameLabel.text = self?.detailViewModel.movieName
                    $0.dateLabel.text = self?.detailViewModel.openDate
                    $0.timeLabel.text = self?.detailViewModel.runningTime
                }
            }
        }
    }
}
