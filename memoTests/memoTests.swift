import XCTest
@testable import memo

class memoTests: XCTestCase {
    
    var initialCount:Int = 0
    var memos = Memos()
    
    override func setUp() {
        super.setUp()
        self.initialCount = self.memos.titles.count
        self.memos.appendMemo(title: "a", detail: "apple")
    }
    
    func testAppendMemo() throws {
        let memos2 = Memos()
        let titles = memos2.titles
        let details = memos2.details
        XCTAssertEqual(titles[titles.count - 1], "a", "タイトルが追加される")
        XCTAssertEqual(details[details.count - 1], "apple", "内容が追加される")
        XCTAssertEqual(titles.count, self.initialCount + 1, "メモの個数が1つ増える")
        XCTAssertEqual(details.count, self.initialCount + 1, "メモの個数が1つ増える")
    }
    
    func testEditDetail() throws {
        self.memos.editDetail(index: self.initialCount, detail: "apple apple")
        let memos2 = Memos()
        let titles = memos2.titles
        let details = memos2.details
        XCTAssertEqual(titles[titles.count - 1], "a", "タイトルは更新されない")
        XCTAssertEqual(details[details.count - 1], "apple apple", "内容は更新される")
        XCTAssertEqual(titles.count, self.initialCount + 1, "メモの個数は変わらない")
        XCTAssertEqual(details.count, self.initialCount + 1, "メモの個数は変わらない")
    }
    
    func testRemoveMemo() throws {
        self.memos.removeMemo(at: initialCount)
        let memos2 = Memos()
        let titles = memos2.titles
        let details = memos2.details
        XCTAssertEqual(titles.count, self.initialCount, "メモの個数が一つ減る")
        XCTAssertEqual(details.count, self.initialCount, "メモの個数が一つ減る")
    }
}
