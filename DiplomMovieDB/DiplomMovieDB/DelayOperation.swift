//
//  AsyncOperation.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 08.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

/// Класс для задержки поиска при поьзовательском вводе в строке поиска
class DelayOperation: AsyncOperation {
    public typealias Closure = (DelayOperation) -> Void
    let closure: Closure

    let delay: TimeInterval

    init(delay: TimeInterval, closure: @escaping Closure) {
        self.delay = delay
        self.closure = closure
    }

    override func main() {
        self.state = .executing
        let delayTime = DispatchTime.now() + Double(Int64(self.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.closure(self)
            self.state = .finished
        }
    }
}

/// Асинхронная операция для задержки ввода
class AsyncOperation: Operation {
    public enum State: String {
        case waiting = "isWaiting"
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
        case cancelled = "isCancelled"
    }

    open var state: State = State.waiting {
        willSet {
            willChangeValue(forKey: State.ready.rawValue)
            willChangeValue(forKey: State.executing.rawValue)
            willChangeValue(forKey: State.finished.rawValue)
            willChangeValue(forKey: State.cancelled.rawValue)
        }
        didSet {
            switch self.state {
            case .waiting:
                assert(oldValue == .waiting, "Invalid change from \(oldValue) to \(self.state)")
            case .ready:
                assert(oldValue == .waiting, "Invalid change from \(oldValue) to \(self.state)")
            case .executing:
                assert(
                    oldValue == .ready || oldValue == .waiting,
                    "Invalid change from \(oldValue) to \(self.state)"
                )
            case .finished:
                assert(oldValue != .cancelled, "Invalid change from \(oldValue) to \(self.state)")
            case .cancelled:
                break
            }
            didChangeValue(forKey: State.cancelled.rawValue)
            didChangeValue(forKey: State.finished.rawValue)
            didChangeValue(forKey: State.executing.rawValue)
            didChangeValue(forKey: State.ready.rawValue)
        }
    }

    open override var isReady: Bool {
        if self.state == .waiting {
            return super.isReady
        } else {
            return self.state == .ready
        }
    }

    open override var isExecuting: Bool {
        if self.state == .waiting {
            return super.isExecuting
        } else {
            return self.state == .executing
        }
    }

    open override var isFinished: Bool {
        if self.state == .waiting {
            return super.isFinished
        } else {
            return self.state == .finished
        }
    }

    open override var isCancelled: Bool {
        if self.state == .waiting {
            return super.isCancelled
        } else {
            return self.state == .cancelled
        }
    }

    open override var isAsynchronous: Bool {
        return true
    }
}
