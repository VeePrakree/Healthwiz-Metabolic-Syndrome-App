//
//  ContentView.swift
//  First App
//
//  Created by Vivek on 8/27/22.
//

import SwiftUI
   
struct ContentView: View {
    @State private var showCalculator = false
   
    var body: some View {
        NavigationView {
            VStack {
                Text("About Us")
                    .font(.system(size: 36))

                Image("Description")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                               
                Image("Description2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
               
                Image("Description3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                               
                Spacer()
                    .frame(minHeight: 10, maxHeight: 50)
               
                NavigationLink(isActive: $showCalculator) {
                    Calculator()
                } label: {
                    Button("Continue") {
                        showCalculator = true
                    }
                } .font(.system(size: 30))
                    .buttonStyle(.bordered)

            }
           
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct Calculator: View {
    @State private var weightInput = ""
    @State private var heightInput = ""
    @State private var bpInput = ""
    @State private var glucoseInput = ""
    @State private var tgInput = ""
    @State private var hdlInput = ""
   
    @State private var weight = 0.0
    @State private var height = 0.0
    @State private var bp = 0.0
    @State private var glucose = 0.0
    @State private var tg = 0.0
    @State private var hdl = 0.0
    @State private var isMale = false
   
    @State private var bmi = 0.0
    @State private var uscore = 0.0
    @State private var probability = 0.0
   
    @State private var showScore = false
   
    var body: some View {
        //NavigationView {
            VStack {
                Text("Calculate Score")
                    .font(.system(size: 36))
               
                Form {
                    Picker("Gender", selection: $isMale) {
                        Text("🙎‍♂️ Male").tag(true)
                        Text("👩 Female").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                   
                    TextField("Weight (pounds)", text: $weightInput)
                    TextField("Height (inches)", text: $heightInput)
                    TextField("Blood Pressure (mmHg)", text: $bpInput)
                    TextField("Glucose (mg/dL)", text: $glucoseInput)
                    TextField("Triglycerides (mg/dL)", text: $tgInput)
                    TextField("HDL-cholesterol (mg/dL)", text: $hdlInput)
                   
                   
                    Button("Get Score") {
                        weight = Double(weightInput) ?? 0
                        height = Double(heightInput) ?? 0
                        bp = Double(bpInput) ?? 0
                        glucose = Double(glucoseInput) ?? 0
                        tg = Double(tgInput) ?? 0
                        hdl = Double(hdlInput) ?? 0

                        bmi = (weight * 0.4536)/pow((height * 0.0254), 2)

                        if (isMale) {
                            uscore = ((bmi/30 + tg/150 + glucose/100 - hdl/40 + bp/130) * 100).rounded() / 100.0
                        } else {
                            uscore = ((bmi/30 + tg/150 + glucose/100 - hdl/50 + bp/130) * 100).rounded() / 100.0
                        }

                        probability = ((exp(-11.2807 + 4.0324*uscore))/(1 + exp(-11.2807 + 4.0324*uscore)) * 100).rounded() / 100.0
                       
                        showScore = true
                    }
                   
                   
//                    NavigationLink(isActive: $showScore) {
//                        Score(isMale: $isMale,
//                              weightInput: $weightInput,
//                              heightInput: $heightInput,
//                              bpInput: $bpInput,
//                              glucoseInput: $glucoseInput,
//                              tgInput: $tgInput,
//                              hdlInput: $hdlInput)
//                    } label: {
//                        Button("Get Score") {
//                            weight = Double(weightInput) ?? 0
//                            height = Double(heightInput) ?? 0
//                            bp = Double(bpInput) ?? 0
//                            glucose = Double(glucoseInput) ?? 0
//                            tg = Double(tgInput) ?? 0
//                            hdl = Double(hdlInput) ?? 0
//
//                            bmi = (weight * 0.4536)/pow((height * 0.0254), 2)
//
//                            if (isMale) {
//                                uscore = ((bmi/30 + tg/150 + glucose/100 - hdl/40 + bp/130) * 100).rounded() / 100.0
//                            } else {
//                                uscore = ((bmi/30 + tg/150 + glucose/100 - hdl/50 + bp/130) * 100).rounded() / 100.0
//                            }
//
//                            probability = ((exp(-11.2807 + 4.0324*uscore))/(1 + exp(-11.2807 + 4.0324*uscore)) * 100).rounded() / 100.0
//                            showScore = true
//                        }
//                    }
                   
//                    Text("Score: " + String(uscore))
//                    Text("Probability: " + String(probability))
                   
                }
               
                NavigationLink("", destination: Score(uscore: $uscore, probability: $probability), isActive: $showScore)
            //}
        }
       
    }
}

struct Score: View {
//    @Binding var isMale: Bool
//    @Binding var weightInput: String
//    @Binding var heightInput: String
//    @Binding var bpInput: String
//    @Binding var glucoseInput: String
//    @Binding var tgInput: String
//    @Binding var hdlInput: String
//
//    lazy var weight = Double(weightInput) ?? 0.0
//    lazy var height = Double(heightInput) ?? 0
//    lazy var bp = Double(bpInput) ?? 0
//    lazy var glucose = Double(glucoseInput) ?? 0
//    lazy var tg = Double(tgInput) ?? 0
//    lazy var hdl = Double(hdlInput) ?? 0
//    lazy var uscore = calculateScore(isMale: isMale, weight: weight, height: height, bp: bp, glucose: glucose, tg: tg, hdl: hdl)
   
    @Binding var uscore: Double
    @Binding var probability: Double
   
   
    var body: some View {
       
       
        VStack {
            Text("Healthwiz Metabolic Syndrome Score: " + String(uscore))
            Text("Probability of being diagnosed: " + String(probability))
            Spacer()
           
        }
    }
   
    func add(a: Double, b: Double) -> Double {
        let sum = a+b
        return sum
    }
   
    func calculateScore(isMale: Bool, weight: Double, height: Double, bp: Double, glucose: Double, tg: Double, hdl: Double) -> Double {
        var bmi = 0.0
        var uscore = 0.0
        bmi = (weight * 0.4536)/pow((height * 0.0254), 2)

        if (isMale) {
            uscore = ((bmi/30 + tg/150 + glucose/100 - hdl/40 + bp/130) * 100).rounded() / 100.0
        } else {
            uscore = ((bmi/30 + tg/150 + glucose/100 - hdl/50 + bp/130) * 100).rounded() / 100.0
        }

        return uscore
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
