import Foundation

struct Day: Strideable {
    var day: Date

    // Strideable
    func distance(to other: Self) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: day)
        let end = calendar.startOfDay(for: other.day)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day!
    }

    func advanced(by n: Int) -> Self {
        var copy = self
        let calendar = Calendar.current
        let components = DateComponents(day: n)
        copy.day = calendar.date(byAdding: components, to: copy.day)!
        return copy
    }
}

struct Month: Strideable {
    var day: Date

    private var interval: DateInterval {
        Calendar.current.dateInterval(of: .month, for: day)!
    }

    var start: Date { interval.start }
    var end: Date { interval.end }

    // Strideable
    func distance(to other: Self) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: day)
        let end = calendar.startOfDay(for: other.day)
        let components = calendar.dateComponents([.month], from: start, to: end)
        return components.month!
    }

    func advanced(by n: Int) -> Self {
        var copy = self
        let calendar = Calendar.current
        let components = DateComponents(month: n)
        copy.day = calendar.date(byAdding: components, to: copy.day)!
        return copy
    }

    var pretty: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM y"
        return formatter.string(from: day)
    }
}

struct Week: Strideable {
    var day: Date

    private var interval: DateInterval {
        Calendar.current.dateInterval(of: .weekOfYear, for: day)!
    }

    var start: Date { interval.start }
    var end: Date { interval.end }

    // Strideable
    func distance(to other: Self) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: day)
        let end = calendar.startOfDay(for: other.day)
        let components = calendar.dateComponents([.weekOfYear], from: start, to: end)
        return components.weekOfYear!
    }

    func advanced(by n: Int) -> Self {
        var copy = self
        let calendar = Calendar.current
        let components = DateComponents(weekOfYear: n)
        copy.day = calendar.date(byAdding: components, to: copy.day)!
        return copy
    }
}

extension Date {
    var day: Day {
        get { .init(day: self) }
        set { self = newValue.day }
    }

    var week: Week {
        get { .init(day: self) }
        set { self = newValue.day }
    }

    var month: Month {
        get { .init(day: self) }
        set { self = newValue.day }
    }
}
