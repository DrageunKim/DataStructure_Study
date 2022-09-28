## 4장 : 정렬 알고리즘

> 데이터를 처리하기 위한 가장 근원적인 방법인 알고리즘에 대해 알아보기!
>
> ✏️ 알고리즘 : 일련의 연속된 데이터를 입력값으로 받아서 해당 데이터를 처리한 뒤 이를 출력값으로 반환
>
> - 삽입 정렬 알고리즘 : 소규모 데이터세트에 적합한 방법
> - 병합 정렬 알고리즘 
> - 신속 정렬 알고리즘
>   - 톱다운방식의 정렬 기법인 분리와 정복 디자인 패턴을 따름
>     - 재귀적 알고리즘의 일종으로 크고 복잡한 문제를 작은 문제들로 분할한 뒤 해결한 다음 
>       다시 크고 복잡한 문제의 해답으로 반환하는 기법

#### a. 삽입 정렬 알고리즘

- 간단하면서도 인기 높은 정렬 알고리즘
- 대규모 데이터세트를 처리하기에는 매우 비효율적인 방법
- 규모가 크지 않은 경우 유용한 방법
- 평균 런타임은 O(n2)

##### 1. 알고리즘 개요

- 효율성 높은 인플레이스 정렬 방식을 사용
- `Comparable` 프로토콜에 부합하는 어떤 타입이든 처리할 수 있음
  - 개별적인 데이터를 상호 비교 할 수 있어야 하기 때문에 `Comparable` 프로토콜에 부합해야함

- N-1회 반복하며, i = 1인 경우 N-1회 반복 시행됨을 의미
- 처음 정렬 순서를 정할 때 <u>0번째 요소의 순서가 이미 정해졌음을 감안해서 i - 1로 시작</u>
- 아래 코드는 삽입 알고리즘

```swift
public func insertionSort<T: Comparable>(_ list: inout [T]) {
  if list.count <= 1 {
    return
  }
  
  for i in 1..<list.count {
    let x = list[i]
    var j = i
    while j > 0 && list[j - 1] > x {
      list[j] = list[j - 1]
      j -= 1
    }
    list[j] = x
  }
}
```

##### 2. 삽입 정렬 알고리즘 활용 사례

- 삽입 정렬 기법은 요소들 대부분이 정렬된 상태이거나 순서를 약간씩만 바꿔도 될 때 활용할 수 있는 방법!
- 대표적인 사례가 카드 게임

##### 3. 최적화

- 삽입 정렬은 이차 알고리즘으로, 대규모 데이터세트를 만났을 때, 이를 최적화 할 수 있는 방법이 별로 없음
- 따라서, 대규모 데이터세트를 처리해야할 경우 **병렬 정렬** 또는 **신속 정렬**과 같은 다른 알고리즘을 활용!!

***

#### b. 병합 정렬 알고리즘

- 분리정복 알고리즘으로 정렬에 따른 시간 소모가 삽입 정렬에 비해 적음

- 재귀적으로 작동하며 미정렬 상태의 데이터세트를 두 개로 나누는 일을 반복해서 데이터세트에 속한
  아이템이 하나인 상태가 되거나 빈 상태가 되면 정렬된 상태로 판단하며,

  이를 더 이상 분해할 수 없는 최소 단위 요소 또는 베이스 케이스라고 부른다.

- 이후 대부분의 정렬 작업은 `merge` 함수에서 수행하며, 나뉘어 있는 두 개 요소를 하나로 합치는 일을 반복!
- `merge` 함수는 병합 작업을 위해 동일한 크기의 배열을 임시로 만들어 사용하므로 O(n)보다는 큰 공간을 차지
  - 이러한 이유로 병합 정렬은 배열보다는 연결 목록의 정렬 작업에서 좀 더 나은 성능을 발휘

##### 1. 배열 기반 병렬 정렬 알고리즘

컬렉션 정렬을 위한 분리정복 작업은 아래 세 가지 절차를 따름

- 분리
  - 컬렉션 S가 0 또는 1인 경우, 더이상 정렬할 것이 없으므로 종료
  - 그렇지 않을 경우 컬렉션을 **S1**과 **S2**로 나눔
  - 이 때 S1에는 S의 N/2만큼의 요소가 포함되어 있고, S2에는 나머니 N/2만큼의 요소가 포함되어 있어야함
- 정복
  - S1과 S2를 재귀적으로 나눠서 (요소의 수가 1인) 베이스 케이스 단계까지 나눈 뒤 정렬을 시작
- 결합
  - S1과 S2의 하위 목록을 병합해서 정렬된 시퀀스로 만든 뒤 이를 다시 반환

##### ✓ 배열 기반으로 `mergeSort` 함수를 정의

`mergeSort` 함수는 재귀적으로 호출되며, 호출될 때마다 목록을 반으로 나누기 시작해서 
목록에 포함된 요소가 0 또는 1이 될 때까지 반복함

```swift
public func mergeSort<T: Comparable>(_ list: [T]) -> [T] {
  if list.count < 2 {
    return list
  }
  
  let center = (list.count) / 2
  return merge(mergeSort([T](list[0..<center])), rightHalf: mergeSort([T](list[center..<list.count])))
}
```

`merge` 함수는 두 개의 정렬 시퀀스인 S1과 S2를 병합한 뒤 개별 요소를 결합, 정렬한 결과를 반환함

```swift
private func merge<T: Comparable>(_ leftHalf: [T], rightHalf: [T]) -> [T] {
  var leftIndex = 0
  var rightIndex = 0
  var tmpList = [T]()
  tmpList.reserveCapacity(leftHalf.count + rightHalf.count)
  
  while (leftIndex < leftHalf.count && rightIndex < rightHalf.count) {
    if leftHalf[leftIndex] < rightHalf[rightIndex] {
      tmpList.append(leftHalf[leftIndex])
      leftIndex += 1
    } else if leftHalf[leftIndex] > rightHalf[rightIndex] {
      tmpList.append(rightHalf[rightInedx])
      rightIndex += 1
    } else {
      tmpList.append(leftHalf[leftIndex])
      tmpList.append(rightHalf[rightIndex])
      leftIndex += 1
      rightIndex += 1
    }
  }
  
  tmpList += [T](leftHalf[leftIndex..<leftHalf.count])
  tmpList += [T](rightHalf[rightIndex..<rightHalf.count])
  return tmpList
}
```

##### 2. 연결 목록 기반 병렬 정렬 알고리즘

LinkedList 구조를 일부 수정해서 연결 목록 요소를 직접 수정할 수 있도록 head 노드 프로퍼티를 외부로 드러냄

```swift
func mergeSort<T: Comparable>(list: inout LinkedList<T>) {
  var left = Node<T>?()
  var right = Node<T>?()
  
  if list.head == nil || list.head?.next == nil {
    return
  }
  
  frontBackSplit(list: &list, front: &left, back: &right)
  
  var leftList = LinkedList<T>()
  leftList.head = left
  
  var rightList = LinkedList<T>()
  rightList.head = right
  
  mergeSort(list: &leftList)
  mergeSort(list: &rightList)

  list.head = merge(left: leftList.head, right: rightList.head)
}
```

```swift
private func merge<T: Comparable>(left: node<T>?, right: Node<T>?) -> Node<T>? {
  var result: Node<T>? = nil
  
  if left == nil {
    return right
  } else if right == nil {
    return left
  }
  
  if left!.data <= right!.data {
    result = left
    result?.next = merge(left: left?.next, right: right)
  } else { 
  	result = right
    result?.next = merge(left: left, right: right?.next)
  }
  
  return result
}
```

```swift
private func frontBackSplit<T: comparable>(list: inout LinkedList<T>, front: inout Node<T>?, back: inout Node<T>?) {
  var fast: Node<T>?
  var slow: Node<T>?
  
  if list.head == nil || list.head?.next == nil {
    front = list.head
    back = nil
  } else {
    slow = list.head
    fast = list.head?.next
  
  	while fast != nil {
   	 fast = fast?.next
    	if fast != nil {
      	slow = slow?.next
      	fast = fast?.next
    	}
  	}
  
  	front = list.head
  	back = slow?.next
  	slow?.next = nil
  }
}
```

***

#### c. 신속 정렬 알고리즘

- 분리정복 알고리즘의 일종
- 인플레이스 정렬 기법을 사용하므로 효율성 또한 높음
- 피봇의 선택 여부에 따라 알고리즘의 성능이 크게 영향을 받는다는 점을 기억!

##### 1. 로무토의 신속 정렬 알고리즘

- Quicksort 함수와 Partition 함수 등 두개의 함수로 구성
  - Quicksort함수 : Partition 함수를 호출한 뒤 재귀적으로 스스로를 호출해서 배열 시퀀스의 lo와 hi요소를 정렬
  - Partition함수 : 배열의 서브시퀀스를 재배치하면서 정렬 작업을 진행하므로 신속 정렬 알고리즘의 메인 함라 할 수 있음

```swift
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
  if lo < hi {
    let pivot = partition(&list, lo: lo, hi: hi)
    
    quickSort(&list, lo: lo, hi: pivot - 1)
    quickSort(&list, lo: pivot + 1, hi: hi)
  }
}
```

```swift
func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
  let pivot = list[hi]
  var i = lo
  
  for j in lo..<hi {
    if list[j] <= pivot {
      swap(&list, i, j)
      i += 1
    }
  }
  
  swap(&list, i, hi)
  return i
}
```

##### 2. 호어의 신속 정렬 알고리즘

- 로무토의 것에 비해 좀 더 복잡하기는 하지만, 평균적으로 스왑 횟수가 세 배나 적고

  배열 요소가 모두 같을 때도 효율적으로 파티션을 만들어낸다는 장점이 있음

```swift
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
  if lo < hi {
    let pivot = partition(&list, lo: lo, hi: hi)
    
    quickSort(&list, lo: lo, hi: pivot)
    quickSort(&list, lo: pivot + 1, hi: hi)
  }
}
```

```swift
private func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
  let pivot = list[lo]
  var i = lo - 1
  var j = hi + 1
  
  while true {
    i += 1
    while list[i] < pivot { i += 1 }
    j -= 1
    while list[j] > pivot { j -= 1 }
    if i >= j {
      return j
    }
    swap(&list[i], &list[j])
  }
}
```

