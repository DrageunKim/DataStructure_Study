// 삽입정렬 예시
func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    var sort = array
    
    for i in 1..<array.count {
        var j = i
        let temp = sort[j]
        while j > 0 && temp < sort[j - 1] {
            sort[j] = sort[j - 1]
            j -= 1
        }
        
        sort[j] = temp
    }
    return sort
}
let test = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
print(insertionSort(test))

// 병합정렬 예시
public func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    if array.count < 2 {
        print("split - array : \(array)")
        return array
    }
    
    let center = array.count / 2
    
    print("split - array : \(array)")
    
    return merge(leftHalf: mergeSort([T](array[0..<center])),
                 rightHalf:mergeSort([T](array[center..<array.count])))
}

private func merge<T: Comparable>(leftHalf: [T], rightHalf: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var tempList = [T]()
    
    //tempList.reserveCapacity(leftHalf.count + rightHalf.count)
    
    while leftIndex < leftHalf.count && rightIndex < rightHalf.count {
        if leftHalf[leftIndex] < rightHalf[rightIndex] {
            tempList.append(leftHalf[leftIndex])
            leftIndex = leftIndex + 1
            
        } else if leftHalf[leftIndex] > rightHalf[rightIndex] {
            tempList.append(rightHalf[rightIndex])
            rightIndex = rightIndex + 1
        }
        else {
            tempList.append(leftHalf[leftIndex])
            tempList.append(rightHalf[rightIndex])
            leftIndex = leftIndex + 1
            rightIndex = rightIndex + 1
        }
    }
    
    tempList += leftHalf[leftIndex..<leftHalf.count]
    tempList += rightHalf[rightIndex..<rightHalf.count]
    
    print("merge - array : \(tempList)")
    
    return tempList
}

let numbers = [-1, 0, 1, 2, 5, 13, 15, 20, 68, 59, 51, 45, 77]
print(mergeSort(numbers)) // [-1, 0, 1, 2, 5, 13, 15, 20, 45, 51, 59, 68, 77]

// split - array : [-1, 0, 1, 2, 5, 13, 15, 20, 68, 59, 51, 45, 77]
// split - array : [-1, 0, 1, 2, 5, 13]
// split - array : [-1, 0, 1]
// split - array : [-1]
// split - array : [0, 1]
// split - array : [0]
// split - array : [1]
// merge - array : [0, 1]
// merge - array : [-1, 0, 1]
// split - array : [2, 5, 13]
// split - array : [2]
// split - array : [5, 13]
// split - array : [5]
// split - array : [13]
// merge - array : [5, 13]
// merge - array : [2, 5, 13]
// merge - array : [-1, 0, 1, 2, 5, 13]
// split - array : [15, 20, 68, 59, 51, 45, 77]
// split - array : [15, 20, 68]
// split - array : [15]
// split - array : [20, 68]
// split - array : [20]
// split - array : [68]
// merge - array : [20, 68]
// merge - array : [15, 20, 68]
// split - array : [59, 51, 45, 77]
// split - array : [59, 51]
// split - array : [59]
// split - array : [51]
// merge - array : [51, 59]
// split - array : [45, 77]
// split - array : [45]
// split - array : [77]
// merge - array : [45, 77]
// merge - array : [45, 51, 59, 77]
// merge - array : [15, 20, 45, 51, 59, 68, 77]
// merge - array : [-1, 0, 1, 2, 5, 13, 15, 20, 45, 51, 59, 68, 77]
// [-1, 0, 1, 2, 5, 13, 15, 20, 45, 51, 59, 68, 77]

// 신속정렬 예시
func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    if array.count < 2 {
        print("last array : \(array)")
        return array
    }
    else { print("array : \(array)") }

    let pivot = array.first!
    print("pivot : \(pivot)")
    
    let smaller = array.filter { $0 < pivot }
    let larger = array.filter { $0 > pivot }
    
    print("smaller : \(smaller)")
    print("larger : \(larger)")

    let result = quickSort(smaller) + [pivot] + quickSort(larger)
    
    print("smaller + pivot + larger : \(result)")
    
    return result
}

let array = [3, 2, 5, 1, 4]

print(quickSort(array)) // [1, 2, 3, 4, 5]

// array : [3, 2, 5, 1, 4]
// pivot : 3
// smaller : [2, 1]
// larger : [5, 4]
// array : [2, 1]
// pivot : 2
// smaller : [1]
// larger : []
// last array : [1]
// last array : []
// smaller + pivot + larger : [1, 2]
// array : [5, 4]
// pivot : 5
// smaller : [4]
// larger : []
// last array : [4]
// last array : []
// smaller + pivot + larger : [4, 5]
// smaller + pivot + larger : [1, 2, 3, 4, 5]
// [1, 2, 3, 4, 5]
