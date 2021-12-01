import Foundation
import UIKit

final class memoTableVC:UITableViewController {
    @IBOutlet var titleTableView: UITableView!
    
    var memos = Memos()
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        //To addMemoVC
        if let navigationVC = segue.destination as? UINavigationController,
           let addMemoVC = navigationVC.topViewController as? AddMemoVC {
            addMemoVC.delegate = self
        }
        
        //To addMemoVC
        if let MemoDetailVC = segue.destination as? MemoDetailVC {
            MemoDetailVC.delegate = self
        }
        
        //To MemoDetailVC
        if segue.identifier == "memoDetailSegue" {
            if let indexPath = titleTableView.indexPathForSelectedRow{
                guard let destination = segue.destination as? MemoDetailVC else {
                    fatalError("Failed to prepare MemoDetailVC")
                }
                destination.text = memos.details[indexPath.row]
                destination.index = indexPath.row
            }
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return memos.titles.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier:"titleCell", for: indexPath)
        cell.textLabel?.text = memos.titles[indexPath.row]
        return cell
    }
}

extension memoTableVC: AddMemoVCDelegate,MemoDetailVCDelegate {
    func addNewMemo(
        withTitle maybeTitle: String?,
        withDetail maybeDetail: String?
    ) {
        if let title = maybeTitle, let detail = maybeDetail {
            print("title: ", title)
            print("detail: ", detail)
            memos.titles.append(title)
            memos.details.append(detail)
            memos.saveStructToStrage()
            tableView.reloadData()
        }
    }

    func editMemo(
        withDetail maybeDetail: String?,
        index maybeIndex: Int?
    ) {
        if let detail = maybeDetail, let index = maybeIndex {
            print("edit detail: ", detail)
            memos.details[index] = detail
            memos.saveStructToStrage()
            tableView.reloadData()
        }
    }
}
