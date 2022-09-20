//
//  SegmentAnalytics.swift
//  ExampleApp
//
//  Created by Jacob Gable on 9/20/22.
//

import Foundation
import Segment

public class SegmentAnalytics {
  private static var analytics: Analytics? = nil
  
  public static func initialize(writeKey: String) {
    let configuration = Configuration(writeKey: writeKey)
       .trackApplicationLifecycleEvents(true)
       .apiHost("analytics-ingestion.kraftful.com")
       .flushInterval(10)
    
    Analytics.debugLogsEnabled = true
    analytics = Analytics(configuration: configuration)
  }
  
  public static func track(event: String) {
    if let client = analytics {
      client.track(name: event)
    }
  }
}
