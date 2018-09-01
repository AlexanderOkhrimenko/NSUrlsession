import Foundation

//: ## URL & URLComponents
//: ### URL from String

let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=abba"
let url = URL(string: urlString)
url?.absoluteString
url?.scheme
url?.host
url?.path
url?.query
url?.baseURL

//: 'baseURL' используется для постороения REST API urls.
let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string: "search", relativeTo: baseURL)
relativeURL?.absoluteString
relativeURL?.scheme
relativeURL?.host
relativeURL?.path
relativeURL?.query
relativeURL?.baseURL

//: ### URLComponetns & URL-encoding
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=music&entiti=song")
var queryItem = URLQueryItem(name: "term", value: "crowded house")
urlComponents?.queryItems?.append(queryItem)
urlComponents?.url

//: URL-encode "smiling cat face with heart-shaped eyes"
queryItem = URLQueryItem(name: "emoji", value: "🐱")
urlComponents?.queryItems?.append(queryItem)
urlComponents?.url

//------------------------

let myDefaultConfiguration = URLSessionConfiguration.default
myDefaultConfiguration.allowsCellularAccess
myDefaultConfiguration.waitsForConnectivity

myDefaultConfiguration.allowsCellularAccess = false
myDefaultConfiguration.allowsCellularAccess
myDefaultConfiguration.waitsForConnectivity = true

myDefaultConfiguration.multipathServiceType = .handover
let myDefaultSession = URLSession(configuration: myDefaultConfiguration)

myDefaultSession.configuration.allowsCellularAccess
myDefaultSession.configuration.waitsForConnectivity

myDefaultConfiguration.urlCache?.memoryCapacity
myDefaultConfiguration.urlCache?.diskCapacity

let ephemeralConfiguration = URLSessionConfiguration.ephemeral
ephemeralConfiguration.urlCache?.memoryCapacity
ephemeralConfiguration.urlCache?.diskCapacity

let cache = URLCache(memoryCapacity: 512000, diskCapacity: 2000000, diskPath: nil)
ephemeralConfiguration.urlCache = cache

ephemeralConfiguration.urlCache?.diskCapacity

//-----



