//
//  KNNView.swift
//  ML_Algorithms
//
//  Created by Eduardo Oliveira on 17/06/21.
//

import SwiftUI

struct KNNView: View {
    
    @State var listOfMapPoints: [MapPoint] = []
    @State var pointsToTest: [MapPoint] = []
    @State var mapPointTest: MapPoint? = nil
    @State var pointsTested: [MapPoint] = []
    
    @State var isTrained: Bool = false
    @State var isTested: Bool = false
    
    @State var KNN_Points: [MapPointWithDistance] = []
    @State var KNN_Value: Int = 7
    @State var KNN_Test_Range: Int = 30
    @State var KNN_Result: GroupCounter = GroupCounter(count: 0, group: .red)
    @State var results: [Bool] = []
    @State var resultText: String = "  "
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Vizinhos próximos: \(KNN_Value)")
                Spacer()
                Button(action: {
                    KNN_Value -= 1
                    if isTested {
                        test()
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                }
                .disabled(KNN_Value <= 1  || isTrained)
                .opacity((KNN_Value <= 1  || isTrained) ? 0.3 : 1.0)
                Button(action: {
                    KNN_Value += 1
                    if isTested {
                        test()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(KNN_Value >= 10 || isTrained)
                .opacity((KNN_Value >= 10  || isTrained) ? 0.3 : 1.0)
            }
            .frame(width: 300, height: 20)
            GeometryReader { geo in
                ZStack {
                    ForEach(listOfMapPoints, id: \.self) { point in
                        Circle()
                            .frame(width: 5, height: 5)
                            .offset(x: CGFloat(point.xPos) * 2, y: CGFloat(point.yPos) * 2)
                            .foregroundColor(point.color)
                    }
                    if let mapPointTest = mapPointTest {
                        Text("x")
                            .font(.system(size: 12))
                            .offset(x: CGFloat(mapPointTest.xPos) * 2, y: CGFloat(mapPointTest.yPos) * 2)
                            .foregroundColor(isTested ? mapPointTest.color : Color.orange)
                    }
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
                }
                ZStack {
                    if let mapPointTest = mapPointTest {
                        if isTested {
                            ForEach(KNN_Points, id: \.self) { point in
                                Path { path in
                                    path.move(to: CGPoint(x: (2 * mapPointTest.xPos) + 3, y: (2 * mapPointTest.yPos) + 7))
                                    path.addLine(to: CGPoint(x: (2 * point.mapPoint.xPos) + 3, y: (2 * point.mapPoint.yPos) + 7))
                                }
                                .stroke(point.mapPoint.color, lineWidth: 2)
                                .opacity(KNN_Result.group == point.mapPoint.group ? 1.0 : 0.3)
                            }
                        }
                    }
                    
                }
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
        }
    }
    
    func train() {
        let points = MapPoint.points.shuffled()
        listOfMapPoints = Array(points.dropFirst(KNN_Test_Range))
        pointsToTest = Array(points.prefix(KNN_Test_Range))
        mapPointTest = pointsToTest.first
        pointsToTest.remove(at: 0)
        
        isTrained = true
    }
    
    func newTest() {
        if mapPointTest != nil {
            pointsTested.append(mapPointTest!)
            if pointsToTest.count > 0 {
                mapPointTest = pointsToTest.first
                pointsToTest.remove(at: 0)
                test()
            } else {
                var success: CGFloat = 0.0
                for result in results {
                    if result {
                        success += 1.0
                    }
                }
                resultText = "\(Double(round(100*(100.0 * success/CGFloat(KNN_Test_Range)))/100))% de sucesso!"
            }
        }
    }
    
    func test() {
        if pointsToTest.count >= 0 {
            let groupCounters: [GroupCounter] = [GroupCounter(count: 0, group: .red), GroupCounter(count: 0, group: .blue), GroupCounter(count: 0, group: .green)]
            KNN_Points = []
            if let mapPointTest = mapPointTest {
                for mapPoint in listOfMapPoints {
                    let distance = sqrt(CGFloat((mapPointTest.xPos - mapPoint.xPos) * (mapPointTest.xPos - mapPoint.xPos) + (mapPointTest.yPos - mapPoint.yPos) * (mapPointTest.yPos - mapPoint.yPos)))
                    KNN_Points.append(MapPointWithDistance(mapPoint: mapPoint, distance: distance))
                }
                KNN_Points = Array(KNN_Points.sorted(by: { $0.distance < $1.distance }).prefix(KNN_Value))
            }
            for point in KNN_Points {
                for groupCounter in groupCounters {
                    if point.mapPoint.group == groupCounter.group {
                        groupCounter.plusCounter()
                    }
                }
            }
            KNN_Result = groupCounters[0]
            for groupCounter in groupCounters {
                if groupCounter.count > KNN_Result.count {
                    KNN_Result = groupCounter
                }
            }
            isTested = true
            results.append(KNN_Result.group == mapPointTest?.group)
            resultText = (KNN_Result.group == mapPointTest?.group) ? "Acertou! (\(pointsTested.count + 1) - \(KNN_Test_Range))" : "Errou! (\(pointsTested.count + 1) - \(KNN_Test_Range))"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                newTest()
            }
        }
        
    }
    
    func reset() {
        listOfMapPoints = []
        pointsToTest = []
        pointsTested = []
        mapPointTest = nil
        resultText = "  "
        results = []
        KNN_Points = []
        isTrained = false
        isTested = false
    }
}


