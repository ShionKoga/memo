import XCTest

class memoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        //メモ追加画面に遷移
        app.navigationBars["All memo"].buttons["Compose"].tap()
        let titleTextField = app.textFields["title_text_field"]
        let detailTextView = app.textViews["detail_text_view"]
        
        //タイトルの入力
        titleTextField.tap()
        titleTextField.typeText("a")

        //内容の入力
        detailTextView.tap()
        detailTextView.typeText("abcde")
        
        //保存して元の画面に戻る
        app.navigationBars["new memo"].buttons["Save"].tap()
        
        //一番下のセルをタップ
        let cells = app.cells.matching(identifier: "title_cell")
        let cellsCount = cells.count
        let lastCell = cells.element(boundBy: cellsCount - 1)
        lastCell.tap()
        print(app.textViews["detail_text"].value ?? "nil")
        
        //内容を編集
        app.textViews["detail_text"].tap()
        app.textViews["detail_text"].typeText("zzzz")
        
        //元の画面に戻る
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        //変更が効いてるか確認
        lastCell.tap()
        print(app.textViews["detail_text"].value ?? "nil")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        //追加したメモを削除
        lastCell.swipeLeft()
        lastCell.buttons["Delete"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
