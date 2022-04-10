import UIKit

struct NewsModel{
    let articles: [Articles]
}

struct Articles{
    let author: String
    let title: String
    let description: String
    let publishedAt: Date
    let url: String
    let urlToImage: String
}
