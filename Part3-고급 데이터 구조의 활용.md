## 3장 : 스위프트 고급 데이터 구조의 활용

> 데이터 구조의 시각화를 통해 데이터의 입력과 출력, 그리고 처리 순서에 대한 개념을 명확하게 정리!
>
> - 기본적인 데이터 구조를 구현하기 위한 스위프트 프로토콜의 핵심 개념 정리
> - 스택 기반 배열과 연결 목록 기반 스택 구조의 구현
> - 다양한 큐 구조의 구현
> - 연결 목록의 개념

### 1. 반복기 , 시퀀스, 컬렉션

#### a. 반복기 : Iterator

:pencil2: **IteratorProtocol 프로토콜의 유일한 목적!**

- 컬렉션을 반복 순회하는 next() 메소드를 통해 컬렉션의 반복 상태를 캡슐화

#### b. 시퀀스 : Sequence

:pencil2: **시퀀스는 컬렉션 타입이 포함된 시퀀스 타입의 InteratorProtocol을 반환하는 팩토리 반복기로 생각!**

- 시퀀스 타입을 정의할 떄 associatedtype을 정의함으로써 실제 반복기 타입을 구체적으로 지정

#### c. 컬렉션 : Collection

:pencil2: **위치를 특정할 수 있는 다중 경로 시퀀스를 제공**

:pencil2: **컬렉션을 순회하면서 많은 요소를 인덱스 값으로 저장한 뒤 필요할 때 해당 인덱스 값으로 특정 요소를 가져옴**

 👉🏻 <u>반복기, 시퀀스와는 다르게 위치값을 가짐</u>

[Collection 프로토콜에 부합하는 타입을 만들기 위해서는 아래 네 가지를 정의해야함]

- startIndex 프로퍼티와 endIndex프로퍼티
- 컬렉션에서 특정 인덱스 위치에 삽입하기 위한 index(after:) 메소드
- 커스텀 타입 요소에 읽기전용 이상의 권한으로 접근하기 위한 서브스크립트

***

### 2. 스택 : Stack

#### a. 특징

- 스택은 LIFO 구조로 나중에 입력된 것이 먼저 출력되는 데이터 구조! **(접시를 쌓아올린 모습과 동일)**

- 스택은 개별 요소에 접근하는 방법을 강하게 제한한 인터페이스를 제공!
- 스택에서 사용되는 가장 일반적인 구조는 배열 또는 연결 목록

#### b. 메소드

- push() : 스택 하단의 요소를 추가
- pop() : 스택 상단의 요소를 꺼내서 **(삭제한 다음)** 반환
- peek() : 스택 상단의 요소를 꺼내서 **(삭제하지 않고)** 반환
- count() : 스택에 포함된 요소의 수를 반환
- isEmpty() : 스택에 포함된 요소가 없는 경우 true를, 그렇지 않은 경우 false를 반환
- isFull() : 스택에 포함될 요소의 수가 결정되어 있는 경우 스택기 꽉 찼으면 true, 그렇지 않은 경우 false 반환

#### c. 예시코드

```swift
public struct Stack<T> {
  private var elements = [T]()
  public init() {}
  
  public mutating func pop() -> T? {
    return self.elements.popLast()
  }
  
  public mutating func push() -> T? {
    return self.elements.append(elements)
  }
  
  public func peek() -> T? {
    return self.elements.last
  }
  
  public func isEmpty: Bool {
    return. self.elements.isEmpty
  }
  
  public func count: Int {
    return self.elements.count
  }
}
```

:book: 메소드를 통해 구조체에 포함된 데이터를 수정하고 싶을 경우 메소드 이름 앞에 `mutating` 키워드를 추가

***

### 3. 큐 : Queue

#### a. 특징

- 큐은 FIFO 구조로 먼저 입력된 것이 먼저 출력되는 데이터 구조! **(슈퍼마켓 계산대에 줄서는 모습과 동일)**

- 큐에서 사용되는 가장 일반적인 구조는 배열 
- **스택과는 다르게 특정 인덱스 위치를 표시!**

#### b. 메소드

- enqueue() : 큐의 맨 뒤에 새로운 요소를 추가
- dequeue() : 큐에서 첫번재 요소를 제거한 뒤 반환
- peek() : 큐의 첫번째 요소를 반환하되, 제거는 하지 않음
- clear() : 큐를 재설정해 빈 상태가 되게 함
- count() : 큐에 포함된 요소의 수를 반환
- isEmpty() : 큐에 비어있으면 true를, 그렇지 않은 경우 false를 반환
- isFull() : 큐가 꽉 차있으면 true, 그렇지 않은 경우 false 반환
- capacity : 큐 용량을 가져오거나 설정하기 위한 read/write 프로퍼티
- Insert(_:atIndex) : 큐의 특정 인덱스 위치에 요소를 삽입
- removeAtIndex(): 큐의 특정 인덱스 위치에 있는 요소를 제거

>  :book: Capacity VS Count 차이점
>
> - Capacity : 배열 속에 담을 수 있는 요소의 수를 반환
> - Count : 현재 배열에 담겨있는 요소의 수를 반환

#### c. 예시코드

```swift
public struct Queue<T> {
  private var data = [T] ()
  public init() {}
  
  public mutating func dequeue() -> T? {
    return data.removeFirst()
  }
  
  public mutating func peek() -> T? {
    return data.first()
  }
  
  public mutating func enqueue(element: T) {
    return data.append(element)
  }
  
  public mutating func clear() {
    return data.removeAll()
  }
  
  public var count: Int {
    return data.count()
  }
  
  public var capacity: Int {
    get {
    	return data.capacity
    }
    set {
      return data.reverseCapacity(newValue)
    }
  }
  
  public func isFull() -> Bool? {
    return count == data.capacity
  }
  
  public func isEmpty() -> Bool? {
    return data.isEmpty
  }
}
```

