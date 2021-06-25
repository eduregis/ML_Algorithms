//
//  DMCView.swift
//  ML_Algorithms
//
//  Created by Eduardo Oliveira on 17/06/21.
//

import SwiftUI

struct DMCView: View {
    
    @State var listOfMapPoints: [MapPoint] = []
    @State var pointsToTest: [MapPoint] = []
    @State var mapPointTest: MapPoint = MapPoint(xPos: 0, yPos: 0, group: .red)
    @State var pointsTested: [MapPoint] = []
    
    @State var isTrained: Bool = false
    @State var isTested: Bool = false
    
    @State var DMC_Centroids: [MapPoint] = [MapPoint(xPos: 0, yPos: 0, group: .red), MapPoint(xPos: 0, yPos: 0, group: .blue), MapPoint(xPos: 0, yPos: 0, group: .green)]
    @State var DMC_Result: MapPoint?
    @State var DMC_Test_Range: Int = 30
    @State var results: [Bool] = []
    @State var resultText: String = "  "
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ZStack {
                    if let mapPointTest = mapPointTest {
                        if isTested {
                            ForEach(DMC_Centroids, id: \.self) { point in
                                ZStack {
                                    Path { path in
                                        path.move(to: CGPoint(x: (2 * mapPointTest.xPos) + 3, y: (2 * mapPointTest.yPos) + 7))
                                        path.addLine(to: CGPoint(x: (2 * point.xPos) + 3, y: (2 * point.yPos) + 7))
                                    }
                                    .stroke(point.color, lineWidth: 2)
                                    .opacity(DMC_Result != nil ? (DMC_Result?.group == point.group ? 1.0 : 0.3) : 0.3)
                                }
                            }
                        }
                    }
                }
                ZStack {
                    ForEach(listOfMapPoints, id: \.self) { point in
                        Circle()
                            .frame(width: 5, height: 5)
                            .offset(x: CGFloat(point.xPos) * 2, y: CGFloat(point.yPos) * 2)
                            .foregroundColor(point.color)
                    }
                    if isTrained {
                        ForEach(pointsToTest, id: \.self) { point in
                            Text("x")
                                .font(.system(size: 12))
                                .offset(x: CGFloat(point.xPos) * 2, y: CGFloat(point.yPos) * 2)
                                .foregroundColor(Color.orange)
                        }
                        ForEach(pointsTested, id: \.self) { point in
                            Text("x")
                                .font(.system(size: 12))
                                .offset(x: CGFloat(point.xPos) * 2, y: CGFloat(point.yPos) * 2)
                                .foregroundColor(Color.orange)
                        }

                        if let mapPointTest = mapPointTest {
                            Text("x")
                                .font(.system(size: 12))
                                .offset(x: CGFloat(mapPointTest.xPos) * 2, y: CGFloat(mapPointTest.yPos) * 2)
                                .foregroundColor(isTested ? mapPointTest.color : Color.orange)
                        }
                    }
                }
//                if isTested {
//                    ZStack {
//                        ForEach(DMC_Centroids, id: \.self) { point in
//                            Circle()
//                                .opacity(0.2)
//                                .frame(width: 100, height: 100)
//                                .offset(x: CGFloat(2 * point.xPos) - 50, y: CGFloat(2 * point.yPos) - 50)
//                                .foregroundColor(point.color)
//                        }
//                    }
//                }
            }
            .frame(width: 300, height: 320)
            .border(Color("Foreground"), width: 3)
            HStack {
                Text(resultText)
                    .font(.title3).bold()
                    .isHidden(!isTested)
            }
            .frame(width: 300)
            HStack {
                Button {
                    train()
                } label: {
                    ZStack {
                        Text("Treinar")
                            .font(.title2).bold()
                            .padding(10)
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(5.0)
                    .opacity(isTrained ? 0.5 : 1.0)
                }
                .disabled(isTrained)
                
                Button {
                    test()
                } label: {
                    ZStack {
                        Text("Testar")
                            .font(.title2).bold()
                            .padding(10)
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(5.0)
                    .opacity(isTrained && !isTested ? 1.0 : 0.5)
                }
                .disabled(!isTrained || isTested)
                
                Button {
                    reset()
                } label: {
                    ZStack {
                        Text("Resetar")
                            .font(.title2).bold()
                            .padding(10)
                            .foregroundColor(.white)
                    }
                    .background(Color.red)
                    .cornerRadius(5.0)
                    .opacity(isTrained ? 1.0 : 0.5)
                }
                .disabled(!isTrained)
            }
            .padding(.top, 30)
        }.padding(.top, 32)
    }
    
    func train() {
        let points = MapPoint.points.shuffled()
        listOfMapPoints = Array(points.dropFirst(DMC_Test_Range))
        pointsToTest = Array(points.prefix(DMC_Test_Range))
        mapPointTest = pointsToTest.first!
        pointsToTest.remove(at: 0)
        
        var newCentroids: [MapPoint] = []
        for centroid in DMC_Centroids {
            let filteredMapPoints = listOfMapPoints.filter { $0.group == centroid.group }
            var xPos: CGFloat = 0
            var yPos: CGFloat = 0
            for mapPoint in filteredMapPoints {
                xPos += CGFloat(mapPoint.xPos)
                yPos += CGFloat(mapPoint.yPos)
            }
            newCentroids.append(MapPoint(xPos: Int(xPos/CGFloat(filteredMapPoints.count)), yPos: Int(yPos/CGFloat(filteredMapPoints.count)), group: centroid.group!))
        }
        DMC_Centroids = newCentroids
        
        isTrained = true
    }
    
    func newTest() {
        pointsTested.append(mapPointTest)
        if pointsToTest.count > 0 {
            mapPointTest = pointsToTest.first!
            pointsToTest.remove(at: 0)
            test()
        } else {
            var success: CGFloat = 0.0
            for result in results {
                if result {
                    success += 1.0
                }
            }
            resultText = "\(Double(round(100*(100.0 * success/CGFloat(DMC_Test_Range)))/100))% de sucesso!"
        }
    }
    
    func test() {
        if pointsToTest.count >= 0 {
            var minDistance: CGFloat = 1000.0
            for centroid in DMC_Centroids {
                let distance = CGPointDistance(from: CGPoint(x: centroid.xPos, y: centroid.yPos), to: CGPoint(x: mapPointTest.xPos, y: mapPointTest.yPos))
                if distance < minDistance {
                    minDistance = distance
                    DMC_Result = centroid
                }
            }
            isTested = true
            results.append(DMC_Result?.group == mapPointTest.group)
            resultText = (DMC_Result?.group == mapPointTest.group) ? "Acertou! (\(pointsTested.count + 1) - \(DMC_Test_Range))" : "Errou! (\(pointsTested.count + 1) - \(DMC_Test_Range))"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                newTest()
            }
        }
    }
    
    func reset() {
        listOfMapPoints = []
        pointsToTest = []
        pointsTested = []
        resultText = "  "
        results = []
        
        isTrained = false
        isTested = false
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}

