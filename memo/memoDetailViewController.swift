import Foundation
import UIKit

final class MemoDetailVC: UIViewController {
    var text: String = ""
    
    @IBOutlet weak var detailText: UITextView!
    
    override func viewDidLoad() {
        detailText.text = text
    }
    
}
