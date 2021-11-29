import Foundation
import UIKit

final class memoTableVC:UITableViewController {
    @IBOutlet var titleTableView: UITableView!
    
    private var titles: [String] = [
        "zoomURL"
    ]
    private var memos: [String] = [
        "http://www.zoom.com"
    ]
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        //To addMemoVC
        if let navigationVC = segue.destination as? UINavigationController,
           let addMemoVC = navigationVC.topViewController as? AddMemoVC {
            addMemoVC.delegate = self
        }
        
        //To MemoDetailVC
        if segue.identifier == "memoDetailSegue" {
            if let indexPath = titleTableView.indexPathForSelectedRow{
                guard let destination = segue.destination as? MemoDetailVC else {
                    fatalError("Failed to prepare MemoDetailVC")
                }
                destination.text = memos[indexPath.row]
            }
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return titles.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier:"titleCell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}

extension memoTableVC: AddMemoVCDelegate {
    func addNewMemo(
        withTitle maybeTitle: String?,
        withMemo maybeMemo: String?
    ) {
        if let title = maybeTitle, let memo = maybeMemo {
            memos.append(memo)
            titles.append(title)
            tableView.reloadData()
        }
    }
}
