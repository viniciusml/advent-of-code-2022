@testable import advent_of_code
import XCTest

extension ClosedRange {
    func embraces(_ other: Self) -> Bool {
        return other.clamped(to: self) == other
    }
}

extension Range {
    func embraces(_ other: Self) -> Bool {
        return other.clamped(to: self) == other
    }
}

final class DayFourTests: XCTestCase {
    
    func testFirstPart() {
        let parsed = Parser.parse(.content(day: "Four"), separator: "\n")
        
        let ranges = parsed.map { line in
            let pairs = line.components(separatedBy: ",")
            return pairs.map { pair in
                let initialAndFinal = pair.components(separatedBy: "-")
                if let first = initialAndFinal.first, let final = initialAndFinal.last, let intFirst = Int(first), let intFinal = Int(final) {
                    return (intFirst...intFinal)
                } else { fatalError() }
            }
        }
        
        let result = ranges.map { range in
            range[0].embraces(range[1]) || range[1].embraces(range[0])
        }.filter { $0 == true }
        
        XCTAssertEqual(result.count, 477)
    }
    
    func testSecondPart() {
        let parsed = Parser.parse(.content(day: "Four"), separator: "\n")
        
        let ranges = parsed.map { line in
            let pairs = line.components(separatedBy: ",")
            return pairs.map { pair in
                let initialAndFinal = pair.components(separatedBy: "-")
                if let first = initialAndFinal.first, let final = initialAndFinal.last, let intFirst = Int(first), let intFinal = Int(final) {
                    return (intFirst...intFinal)
                } else { fatalError() }
            }
        }
        
        let result = ranges.map { range in
            range[1].overlaps(range[0])
        }.filter { $0 == true }
        
        XCTAssertEqual(result.count, 830)
    }
}
