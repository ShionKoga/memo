import Foundation
import UIKit

protocol MemoDetailVCDelegate: AnyObject {
    func editMemo(withDetail: String?, index: Int?)
}

final class MemoDetailVC: UIViewController {
    var text: String = ""
    var index: Int? = nil
    
    @IBOutlet weak var detailText: UITextView!
    
    override func viewDidLoad() {
        detailText.text = text
        backButton()
    }
    
    weak var delegate: MemoDetailVCDelegate? = nil
    
    private func backButton() {
        let chevronLeftImage: UIImage? = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(
//            title: "back",
            image: chevronLeftImage,
            style: .plain,
            target: self,
            action: #selector(onTapBackButton(_:))
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func onTapBackButton(_ sender: UIBarButtonItem) {
        delegate?.editMemo(withDetail: detailText.text, index: index)
        navigationController?.popViewController(animated: true)
    }
    
}
