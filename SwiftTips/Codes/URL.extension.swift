//
//  URL.extension.swift
//
//  Created by khara on 2016/05/17.
//

import Foundation

extension URL {
  /// 短縮 URL の復元（独自の難読化には非対応）
  public func resolveURL(completion completion_: @escaping (_ resolvedURL: URL) -> Void) {
    var request = URLRequest(url: self)
    request.httpMethod = "HEAD" // Body データは読み込まない（負荷軽減）

    let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, err: Error?) in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      completion_(httpResponse.statusCode == 200 ? httpResponse.url! : self)
    }
    task.resume()
  }
}
