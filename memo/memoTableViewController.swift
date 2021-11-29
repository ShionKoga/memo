import Foundation
import UIKit

final class memoTableVC:UITableViewController {
    private var memos: [String:String] = [
        "zoomURL": "https://www.zoom.com"
    ]
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if let navigationVC = segue.destination as? UINavigationController,
           let addMemoVC = navigationVC.topViewController as? AddMemoVC {
            addMemoVC.delegate = self
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return memos.keys.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier:"titleCell", for: indexPath)
        let memoTitles = [String](memos.keys)
        cell.textLabel?.text = memoTitles[indexPath.row]
        return cell
    }
}

extension memoTableVC: AddMemoVCDelegate {
    func addNewMemo(
        withTitle maybeTitle: String?,
        withMemo maybeMemo: String?
    ) {
        if let title = maybeTitle, let memo = maybeMemo {
            memos[title] = memo
            print(memos)
            tableView.reloadData()
        }
    }
}
