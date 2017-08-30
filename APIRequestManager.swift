import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getRepInfo(zip: String, callback: @escaping(RepInfoViewModel?) -> Void) {
        
        let endpoint = "https://www.googleapis.com/civicinfo/v2/representatives?key=AIzaSyBU0xkqxzxgDJfcSabEFYMXD9M-i8ugdGo&address=\(zip)"
        guard let myURL = URL(string: endpoint) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: myURL) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            guard let validData = data else { return }
            var repInfo: RepInfoViewModel? = nil
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                if let jsonDict = json as? [String: AnyObject], let validRepInfo = RepInfoViewModel(dict: jsonDict) {
                    repInfo = validRepInfo
                }
            } catch {
                print(error.localizedDescription)
            }
            callback(repInfo)
        }.resume()
    }
    
    func getArticles(searchTerm: String, callback: @escaping ([Article]?) -> Void) {
        let urlSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let endPoint = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=4eb9c9ccae8148b39c2e02cd90ff1e39&q=\(urlSearchTerm!)"
        
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: myURL) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let validData = data else { return }
            var articles: [Article]? = nil
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                if let validJson = json as? [String: AnyObject],
                    let responseDict = validJson["response"] as? [String: AnyObject],
                    let jsonDicts = responseDict["docs"] as? [[String: AnyObject]] {
                    articles = Article.getArticles(from: jsonDicts)
                }
            } catch {
                print(error.localizedDescription)
            }
            callback(articles)
        }.resume()
    }
    
    
    
    
    
    //This isn't going to be used in this implementation of the App.
    func getElections(endPoint: String = "https://www.googleapis.com/civicinfo/v2/elections?key=AIzaSyBU0xkqxzxgDJfcSabEFYMXD9M-i8ugdGo", callback: @escaping ([Election]?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error.debugDescription)")
            }
            guard let validData = data else { return }
            var elections: [Election]? = nil
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                if let jsonDict = json as? [String: AnyObject],
                    let electionDicts = jsonDict["elections"] as? [[String: AnyObject]] {
                    elections = []
                    for electionDict in electionDicts {
                        if let election = Election(dict: electionDict) {
                            print("valid election")
                            elections?.append(election)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
            callback(elections)
            }.resume()
    }
    
    //This isn't going to be used in this implementation of the App.
    func getVoterInfo(endPoint: String, callback: @escaping (VoterInfo?) -> Void) {
        
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: myURL) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            guard let validData = data else { return }
            var voterInfo: VoterInfo? = nil
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                if let jsonDict = json as? [String: AnyObject], let validVoterInfo = VoterInfo(dict: jsonDict) {
                    voterInfo = validVoterInfo
                }
            } catch {
                print(error.localizedDescription)
            }
            
            callback(voterInfo)
            }.resume()
    }
    
    func getImage(APIEndpoint: String, callback: @escaping (Data?) -> Void) {
            guard let customURL = URL(string: APIEndpoint) else { return }
            let session: URLSession = URLSession(configuration: .default)
            session.dataTask(with: customURL) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Encoutered networking error: \(error.debugDescription)")
                }
                guard let validData = data else { return }
                callback(validData)
                }.resume()
    }
}
