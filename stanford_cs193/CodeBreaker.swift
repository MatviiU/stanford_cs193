//
//  CodeBreaker.swift
//  stanford_cs193
//
//  Created by Matvii Ulytskyi on 10.09.2026.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: Array<Code> = []
    let pegChoices: Array<Peg>
    
    init(pegChoices: Array<Peg> = [.red, .blue, .green, .yellow]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
}

struct Code {
    var kind: Kind
    var pegs: Array<Peg> =  Array(repeating: Code.missing, count: 4)
    
    static let missing: Peg = .clear
    
    enum Kind: Equatable {
        case master
        case guess
        case attempt(Array<Match>)
        case uknown
    }
    
    mutating func randomize(from pegChoices: Array<Peg>) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: Array<Match> {
        switch kind {
            case .attempt(let matches): return matches
            default: return []
        }
    }
    
    func match(against otherCode: Code) -> Array<Match> {
        var result: Array<Match> = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                result[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        
        for index in pegs.indices {
            if result[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    result[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        
        return result
    }
}
