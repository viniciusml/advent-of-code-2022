@testable import advent_of_code
import XCTest

extension String {
    
    var toRPS: RPSParser.Match.RPS {
        switch self {
        case "X", "A": return .rock
        case "Y", "B": return .paper
        case "Z", "C": return .scissors
        default: fatalError("value is \(self)")
        }
    }
}

struct RPSParser {
    
    struct Match {
        enum RPS: Int {
            case rock = 1
            case paper = 2
            case scissors = 3
        }
        
        let playerOne: RPS
        let playerTwo: RPS
        
        var draw = 3
        var lost = 0
        var win = 6
        
        var matchResult: Int {
            switch (playerOne, playerTwo) {
            case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
                return playerOne.rawValue + draw
            case (.paper, .paper):
                return playerOne.rawValue + draw
            case :
                return playerOne.rawValue + draw
            case (.rock, .paper):
                return playerOne.rawValue + lost
            case (.rock, .scissors):
                return playerOne.rawValue + win
            case (.paper, .scissors):
                return playerOne.rawValue + lost
            case (.scissors, .rock):
                return playerOne.rawValue + lost
            case (.scissors, .paper):
                return playerOne.rawValue + win
            case (.paper, .rock):
                return playerOne.rawValue + win
            }
        }
    }
    
    static func parse(_ input: [String]) -> [Match] {
        let copy = input.dropLast(1)
        let result = copy.compactMap { eachPair in
            let pairWithOptionsPlayed = eachPair.components(separatedBy: " ")
            if let playerOne = pairWithOptionsPlayed.first, let playerTwo = pairWithOptionsPlayed.last {
                return Match(playerOne: playerOne.toRPS, playerTwo: playerTwo.toRPS)
            } else {
                return nil
            }
        }
        return result
    }
}

final class DayTwoTests: XCTestCase {
    
    func testFirstPart() {
        let fileResult = Parser.parse(.content(day: "Two"), separator: "\n")
        let match = RPSParser.parse(fileResult)
        
        XCTAssertEqual(match.count, 2500)
    }
}
