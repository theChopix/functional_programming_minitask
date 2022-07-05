## BuildHeap 

Task was to make a haskell program (in time limit and without use of any external sources) implementing function 'buildHeap'.  

### Input

array of any type that satisfies `(Eq a, Ord a)` e.t. type that defines equality and inequality & is totally ordered

### Output

max-heap data from given elements of array, displayed using indentations

### Example

`buildHeap([1, 2, 3, 4, 5])` 

`------2`  
`---4`  
`------1`  
`5`  
`---3`  

### Compilation (in terminal)

`ghci heap.hs`
