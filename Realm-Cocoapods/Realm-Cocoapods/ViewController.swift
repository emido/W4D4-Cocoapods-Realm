//
//  ViewController.swift
//  Realm-Cocoapods
//
//  Created by steve on 2018-02-08.
//  Copyright © 2018 steve. All rights reserved.
//

import UIKit
import ScrollableGraphView

class ViewController: UIViewController, ScrollableGraphViewDataSource  {
  
  let linePlotData = [11.0, 22.0, 44.5, 8.9, 4.5, 33, 11]
  
  func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
    // Return the data for each plot.
    switch(plot.identifier) {
    case "line":
      return linePlotData[pointIndex]
    default:
      return 0
    }
  }
  
  func label(atIndex pointIndex: Int) -> String {
    return "FEB \(pointIndex)"
  }
  
  func numberOfPoints() -> Int {
    return linePlotData.count
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    createGraph()
  }

  private func createGraph() {
    // Compose the graph view by creating a graph, then adding any plots
    // and reference lines before adding the graph to the view hierarchy.
    let frame = view.frame
    let graphView = ScrollableGraphView(frame: frame, dataSource: self)
    
    let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
    let referenceLines = ReferenceLines()
    
    graphView.addPlot(plot: linePlot)
    graphView.addReferenceLines(referenceLines: referenceLines)
    view.addSubview(graphView)
  }

}

