import Foundation

func urlGenerator(fileName:String) -> URL?{
    //保存先URLの作成
    guard let url = try? FileManager
        .default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent(fileName)
    else {
        print("urlGenerator: failed to make url")
        return nil
    }
    return url
}

class Memos: Codable {
    var titles : [String]
    var details: [String]
    
    init(){
        if
            let url = urlGenerator(fileName: "sample.json"),
            let data = try? Data(contentsOf: url),
            let memos = try? JSONDecoder().decode(Memos.self, from: data)
        {
            self.titles = memos.titles
            self.details = memos.details
        }
        else {
            self.titles = []
            self.details = []
        }
    }

    func saveStructToStrage() {
        guard
            let url = urlGenerator(fileName: "sample.json"),
            let data = try? JSONEncoder().encode(self)
        else { return }
        //書き込み
        do {
            try data.write(to: url)
            print("save: successed")
        } catch let error {
            print (error)
        }
    }
}
