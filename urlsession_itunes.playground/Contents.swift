//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
config.waitsForConnectivity = true
let defaultSession = URLSession(configuration: config)

struct Track: Decodable {
    let trackName: String
    let artistName: String
    let previewUrl: String
}

struct TrackList: Decodable {
    let results: [Track]
}

class QueryService {
    var tracks: [Track] = []
    var errorMessage = ""
    
    func getSearchResults() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")!
        let task = defaultSession.dataTask(with: url) { data, response, error in
            defer { PlaygroundPage.current.finishExecution() }
            if let error = error {
                self.errorMessage += "DataTask error :" + error.localizedDescription + "\n"
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self.updateSearchResults(data)
                self.tracks
                self.errorMessage
            }
        }
        
    }
    
    func updateSearchResults(_ data: Data)  {
        let decoder = JSONDecoder()
        tracks.removeAll()
        
        do {
            let list = try decoder.decode(TrackList.self, from: data)
            tracks = list.results
        } catch let decodeError as NSError {
            errorMessage += "Decoder error: \(decodeError.localizedDescription)\n"
            return
        }
    }
}

QueryService().getSearchResults()
