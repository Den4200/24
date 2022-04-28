//
//  ContentView.swift
//  The 24 Game
//
//  Created by  on 4/6/22.
//

import ConfettiSwiftUI
import MathExpression
import RegEx
import SwiftUI

struct ContentView: View {
    @State private var expression = ""
    @State private var problems = PROBLEMS
    @State private var numbers = PROBLEMS.randomElement()!
    @State private var solved = 0
    @State private var confettiCounter = 0
    @State private var hasWon = false

    var evaluatedAnswer: Int {
        let regex = try! RegEx(pattern: #"(\d+)"#)

        if regex.matches(in: expression).map({ Int($0.values[0]!) ?? 0 }).sorted() == self.numbers.sorted() {
            let expr = (try? MathExpression(expression)) ?? (try! MathExpression("0"))
            return Int(expr.evaluate())
        } else {
            return 0
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text("The 24 Game")
                    .font(.largeTitle)
                    .bold()
                Text("Solved: \(self.solved)")
                    .padding(.bottom)

                hasWon ? (
                    VStack {
                        Spacer()

                        Text("Congratulations!")
                            .font(.largeTitle)
                            .bold()
                        Text("You have solved \(self.solved) puzzles.")
                            .padding(.bottom)

                        Button {
                            self.solved = 0
                            self.problems = PROBLEMS
                            self.hasWon = false
                        } label: {
                            Text("Reset")
                                .font(.title3)
                                .padding()
                                .border(Color.black, width: 2, cornerRadius: 16)
                        }

                        Spacer()
                    }
                ) : nil

                hasWon ? nil : (
                    VStack {
                        Group {
                            Text("\(self.numbers[0])")
                                .font(.title)
                                .bold()
                                .padding()
                                .frame(width: 80, height: 80, alignment: .center)
                                .border(Color.black, width: 4, cornerRadius: 16)
                                .padding()

                            HStack {
                                Text("\(self.numbers[1])")
                                    .font(.title)
                                    .bold()
                                    .padding()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .border(Color.black, width: 4, cornerRadius: 16)
                                    .padding()
                                Spacer()
                                Text("\(self.numbers[2])")
                                    .font(.title)
                                    .bold()
                                    .padding()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .border(Color.black, width: 4, cornerRadius: 16)
                                    .padding()
                            }
                            .padding()

                            Text("\(self.numbers[3])")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .padding()
                                .frame(width: 80, height: 80, alignment: .center)
                                .border(Color.black, width: 4, cornerRadius: 16)
                                .padding()
                        }
                        .frame(height: UIScreen.main.bounds.width / 4)

                        Spacer()

                        VStack {
                            Text("Answer")
                                .bold()
                            TextField("Answer", text: self.$expression)
                                .font(.title3)
                                .padding()
                                .border(Color.black, width: 2, cornerRadius: 16)
                        }

                        Spacer()

                        evaluatedAnswer == 24 ? (
                            Button {
                                self.solved += 1
                                self.confettiCounter += 1
                                self.expression = ""

                                if self.problems.count == 0 {
                                    self.hasWon = true
                                } else {
                                    self.numbers = self.problems.randomElement()!
                                    self.problems.removeAll(where: { $0 == self.numbers })
                                }
                            } label: {
                                Text("Correct! Next puzzle :)")
                                    .font(.title3)
                                    .padding()
                                    .border(Color.black, width: 2, cornerRadius: 16)
                            }
                        ) : nil

                        Spacer()
                    }
                )
            }
            .padding()
            ConfettiCannon(counter: self.$confettiCounter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
