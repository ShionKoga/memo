import XCTest
@testable import memo

class memoTests: XCTestCase {
    
    var initialCount:Int = 0
    var memos = Memos()//タスクキル前を想定したインスタンス
    var memos2:Memos!  //タスクキル後を想定したインスタンス
    var titles:[String] = []
    var details:[String] = []
    
    override func setUp() {
        super.setUp()
        self.initialCount = self.memos.titles.count
        self.memos.appendMemo(title: "a", detail: "apple")
        //新しく生成したインスタンスで評価したい（タスクキル後を想定）
        self.memos2 = Memos()
        self.titles = memos2.titles
        self.details = memos2.details
    }
    
    func testAppendMemo() throws {
        let titlesTailIndex = self.titles.count - 1
        let detailsTailIndex = self.titles.count - 1
        if titlesTailIndex < 0 || detailsTailIndex < 0 {
            XCTFail("append後なのにカウントが0なら失敗")
            return
        }
        XCTAssertEqual(self.titles[titlesTailIndex], "a", "タイトルが追加される")
        XCTAssertEqual(self.details[detailsTailIndex], "apple", "内容が追加される")
        XCTAssertEqual(self.titles.count, self.initialCount + 1, "メモの個数が1つ増える")
        XCTAssertEqual(self.details.count, self.initialCount + 1, "メモの個数が1つ増える")
    }
    
    func testEditDetail() throws {
        self.memos.editDetail(index: self.initialCount, detail: "apple apple")
        let titlesTailIndex = self.titles.count - 1
        let detailsTailIndex = self.titles.count - 1
        if titlesTailIndex < 0 || detailsTailIndex < 0 {
            XCTFail("append後なのにカウントが0なら失敗")
            return
        }
        XCTAssertEqual(self.titles[titlesTailIndex], "a", "タイトルは更新されない")
        XCTAssertEqual(self.details[detailsTailIndex], "apple apple", "内容は更新される")
        XCTAssertEqual(self.titles.count, self.initialCount + 1, "メモの個数は変わらない")
        XCTAssertEqual(self.details.count, self.initialCount + 1, "メモの個数は変わらない")
    }
    
    func testRemoveMemo() throws {
        self.memos.removeMemo(at: initialCount)
        XCTAssertEqual(self.titles.count, self.initialCount, "メモの個数が一つ減る")
        XCTAssertEqual(self.details.count, self.initialCount, "メモの個数が一つ減る")
    }
}
