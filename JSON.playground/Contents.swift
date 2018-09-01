//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Настройка сесси
let conf = URLSessionConfiguration.default
conf.waitsForConnectivity = true
let defaultSession = URLSession(configuration: conf)

// Определение адреса
let urlString = "http://localhost:3000/posts/"
let url = URL(string: urlString)!

// Задание структуры данных
let decoder = JSONDecoder()
struct Post: Codable {
    let id: Int
    let author: String
    let title: String
}

var posts: [Post] = []
var errorMessage = ""


let task = defaultSession.dataTask(with: url) { data, response, error in
    defer { PlaygroundPage.current.finishExecution() }
    
    if let error = error {
        errorMessage += "DataTask error: " + error.localizedDescription + "\n"
       } else if let data = data,
        let response = response as? HTTPURLResponse,
            response.statusCode == 200 {
            do {
                let posts = try decoder.decode([Post].self, from: data)
                posts
            } catch let decodeError as NSError {
                errorMessage += "Decoder error : \(decodeError.localizedDescription)"
                return
        }
    }
}
task.resume()
