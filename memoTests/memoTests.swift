import XCTest
@testable import memo

class AfterTaskKill {
    var titles:[String]
    var details:[String]
    var titlesTail:String?
    var detailsTail:String?
    var titlesTailIndex:Int
    var detailsTailIndex:Int
    
    init (instance:Memos){
        self.titles = instance.titles
        self.details = instance.details
        self.titlesTail = self.titles.last
        self.detailsTail = self.details.last
        self.titlesTailIndex = self.titles.count - 1
        self.detailsTailIndex = self.details.count - 1
    }
}

class memoTests: XCTestCase {
    
    var initialCount:Int = 0
    var memos = Memos()//タスクキル前を想定したインスタンス
    
    override func setUp() {
        super.setUp()
        self.initialCount = self.memos.titles.count
        self.memos.appendMemo(title: "a", detail: "apple")
    }
    
    func testAppendMemo() throws {
        let afterKill = AfterTaskKill(instance: Memos())
        if afterKill.titlesTailIndex < 0 || afterKill.detailsTailIndex < 0 {
            XCTFail("append後なのにカウントが0だったら失敗")
            return
        }
        XCTAssertEqual(afterKill.titlesTail, "a", "タイトルが追加される")
        XCTAssertEqual(afterKill.detailsTail, "apple", "内容が追加される")
        XCTAssertEqual(afterKill.titles.count, self.initialCount + 1, "メモの個数が1つ増える")
        XCTAssertEqual(afterKill.details.count, self.initialCount + 1, "メモの個数が1つ増える")
    }
    
    func testEditDetail() throws {
        self.memos.editDetail(index: self.initialCount, detail: "apple apple")
        let afterKill = AfterTaskKill(instance: Memos())
        if afterKill.titlesTailIndex < 0 || afterKill.detailsTailIndex < 0 {
            XCTFail("append後なのにカウントが0だったら失敗")
            return
        }
        XCTAssertEqual(afterKill.titlesTail, "a", "タイトルは更新されない")
        XCTAssertEqual(afterKill.detailsTail, "apple apple", "内容は更新される")
        XCTAssertEqual(afterKill.titles.count, self.initialCount + 1, "メモの個数は変わらない")
        XCTAssertEqual(afterKill.details.count, self.initialCount + 1, "メモの個数は変わらない")
    }
    
    func testRemoveMemo() throws {
        self.memos.removeMemo(at: initialCount)
        let afterKill = AfterTaskKill(instance: Memos())
        if afterKill.titlesTailIndex < 0 || afterKill.detailsTailIndex < 0 {
            XCTFail("append後なのにカウントが0だったら失敗")
            return
        }
        XCTAssertEqual(afterKill.titles.count, self.initialCount, "メモの個数が一つ減る")
        XCTAssertEqual(afterKill.details.count, self.initialCount, "メモの個数が一つ減る")
    }
}
