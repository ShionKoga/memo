import Foundation
import UIKit

protocol AddMemoVCDelegate: AnyObject {
    func addNewMemo(withTitle: String?, withMemo: String?)
}

final class AddMemoVC: UIViewController {
    
    @IBOutlet weak var newTitleTextField: UITextField!
    @IBOutlet weak var newTitleTextView: UITextView!
    
    weak var delegate: AddMemoVCDelegate? = nil

    @IBAction func didTapSaveButton(
        _ sender: UIBarButtonItem
    ) {
        delegate?.addNewMemo(
            withTitle: newTitleTextField.text,
            withMemo: newTitleTextView.text
        )
        dismiss(animated: true)
    }

    @IBAction func didTapCancelButton(
        _ sender: UIBarButtonItem
    ) {
        dismiss(animated: true)
    }
}
