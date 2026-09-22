//
//  Code.swift
//  stanford_cs193
//
//  Created by Matvii Ulytskyi on 14.09.2026.
//
import SwiftUI

extension Peg {
    static let missing = Color.clear
}

struct Code {    
    var kind: Kind
    var pegs: Array<Peg> =  Array(repeating: Code.missingPeg, count: 4)
    
    static let missingPeg: Peg = .clear
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempt(Array<Match>)
        case uknown
    }
    
    mutating func randomize(from pegChoices: Array<Peg>) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
    }
    
    mutating func reset() {
        pegs = Array(repeating: Code.missingPeg, count: 4)
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    var matches: Array<Match>? {
        switch kind {
            case .attempt(let matches): return matches
            default: return nil
        }
    }
    
    func match(against otherCode: Code) -> Array<Match> {
        var pegsToMatch = otherCode.pegs
        
        let backwardsExactMatches = pegs.indices.reversed().map {index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }
        
        let exactMatches = Array(backwardsExactMatches.reversed())
        
        return pegs.indices.map {index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
    }
}
