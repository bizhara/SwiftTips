//
//  NSURL.extension.swift
//
//  Created by khara on 2016/05/17.
//

import Foundation

extension NSURL {
  /// 短縮 URL の復元（独自の難読化には非対応）
  func resolveURL(completion completion_: (resolvedURL: NSURL) -> Void) {
    let request = NSMutableURLRequest(URL: self)
    request.HTTPMethod = "HEAD" // Body データは読み込まない（負荷軽減）
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, err: NSError?) in
      let httpResponse: NSHTTPURLResponse? = response as? NSHTTPURLResponse
      completion_(resolvedURL: httpResponse?.statusCode == 200 ? httpResponse!.URL! : self)
    })
    task.resume()
  }
}
