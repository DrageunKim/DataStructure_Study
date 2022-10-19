import UIKit

public class BinaryTreeNode<T: Comparable> {
    public var value: T
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?
    public weak var parent: BinaryTreeNode?
    
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }
    
    public init(value: T, left: BinaryTreeNode?, right: BinaryTreeNode?, parent: BinaryTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }
    
    public func insertNodeFromRoot(value: T) {
        if let _ = self.parent {
            print("You can onley add new nodes from the root node of the tree")
            return
        }
        self.addNode(value: value)
    }
    
    private func addNode(value: T) {
        if value < self.value {
            if let leftChild = leftChild {
                leftChild.addNode(value: value)
            } else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                leftChild = newNode
            }
        } else {
            if let rightChild = rightChild {
                rightChild.addNode(value: value)
            } else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                rightChild = newNode
            }
        }
    }
    
    // 재귀적으로 노드를 순회하는 인오더 트리 워크
    public class func traverseInOrder(node: BinaryTreeNode?) {
        // Nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
        guard let node = node else {
            return
        }
        
        // leftChild에서 재귀적으로 메소드를 호출하고
        // rightChild 값을 출력한 뒤, rightChild로 이동
        BinaryTreeNode.traverseInOrder(node: node.leftChild)
        print(node.value)
        BinaryTreeNode.traverseInOrder(node: node.rightChild)
    }
    
    // 재귀적으로 노드를 순회하는 프리오더 트리 워크
    public class func traversePreOrder(node: BinaryTreeNode?) {
        // Nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
        guard let node = node else {
            return
        }
        
        // 메소드를 재귀적으로 호출해서 루트 노드 값을 출력한 뒤
        // leftChild와 rightChild 순으로 순회
        print(node.value)
        BinaryTreeNode.traversePreOrder(node: node.leftChild)
        BinaryTreeNode.traversePreOrder(node: node.rightChild)
    }
    
    // 재귀적으로 노드를 순회하는 포스트오더 트리 워크
    public class func traversePostOrder(node: BinaryTreeNode?) {
        // Nil인 잎에 도달하면 재귀적인 함수 호출이 중단됨
        guard let node = node else {
            return
        }
        
        // 재귀적으로 메소드를 호출하면서 leftChild에서 시작해서
        // rightChild로 이동한 뒤, 루트 노드에서 순회를 종료함
        BinaryTreeNode.traversePostOrder(node: node.leftChild)
        BinaryTreeNode.traversePostOrder(node: node.rightChild)
        print(node.value)
    }
    
    public func search(value: T) -> BinaryTreeNode? {
        // 키값을 찾은 경우
        if value == self.value {
            return self
        }
        
        // 해당 키값이 현재 노드의 키값보다 작을 경우
        // 좌측 서브트리에서 재귀적으로 검색을 시작
        // 그렇지 않은 경우 우측 서브트리에서 검색 시작
        if value < self.value {
            guard let left = leftChild else {
                return nil
            }
            return left.search(value: value)
        } else {
            guard let right = rightChild else {
                return nil
            }
            return right.search(value: value)
        }
    }
    
    // 노드 삭제
    public func delete() {
        if let left = leftChild {
            
            if let _ = rightChild {
                // 대상 노드가 좌측 및 우측, 두개의 자식 요소를 모두 지닌 경우 ->
                // 후손 교환 작업을 수행
                self.exchangeWithSuccessor()
            } else {
                // 대상 노드가 좌측 자식 요소를 지닌 경우 ->
                // 대상 노드의 self.parent와 self.child를 바로 연결함
                // 이를 위해서는 먼저 대상 노드가 부모 노드의 우측 서브
                // 트리에 속한 자식의 좌측 노드인지 알아야 함
                self.connectParentTo(child: left)
            }
        } else if let right = rightChild {
            // 대상 노드가 우측 자식 요소를 지닌 경우 ->
            // 대상 노드의 self.parent와 self.child를 바로 연결함
            // 이를 위해서는 먼저 대상 노드가 부모 노드의 우측 서브
            // 트리에 속한 자식의 좌측 노드인지 알아야 함
            self.connectParentTo(child: right)
        } else {
            self.connectParentTo(child: nil)
        }
        
        // 노드 참조값을 삭제
        self.parent = nil
        self.leftChild = nil
        self.rightChild = nil
    }
    
    // 삭제 대상 노드의 후손을 위해 노드 교환을 수행
    private func exchangeWithSuccessor() {
        guard let right = self.rightChild, let left = self.leftChild else {
            return
        }
        let successor = right.miminum()
        print("succssor : \(successor)")
        successor.delete()
        
        successor.leftChild = left
        left.parent = successor
        
        if right !== successor {
            successor.rightChild = right
            right.parent = successor
        } else {
            successor.rightChild = nil
        }
        self.connectParentTo(child: successor)
    }
    
    private func connectParentTo(child: BinaryTreeNode?) {
        guard let parent = self.parent else {
            child?.parent = self.parent
            return
        }
        
        if parent.leftChild === self {
            parent.leftChild = child
            child?.parent = parent
        } else if parent.rightChild === self {
            parent.rightChild = child
            child?.parent = parent
        }
    }
    
    public func miminum() -> BinaryTreeNode {
        if let left = leftChild {
            return left.miminum()
        } else {
            return self
        }
    }
}

let rootNode = BinaryTreeNode(value: 10)
rootNode.insertNodeFromRoot(value: 20)
rootNode.insertNodeFromRoot(value: 5)
rootNode.insertNodeFromRoot(value: 21)
rootNode.insertNodeFromRoot(value: 8)
rootNode.insertNodeFromRoot(value: 4)

BinaryTreeNode.traverseInOrder(node: rootNode)
print("---")
BinaryTreeNode.traversePreOrder(node: rootNode)
print("---")
BinaryTreeNode.traversePostOrder(node: rootNode)
print("---")
print("Search result: " + "\(rootNode.search(value: 1)?.value)")
print("Search result: " + "\(rootNode.search(value: 4)?.value)")
print("---")
rootNode.leftChild?.delete()
//rootNode.rightChild?.delete()
BinaryTreeNode.traverseInOrder(node: rootNode)
