module Task4 ( Tree (..), buildHeap) where
data Tree a = Leaf | Node a (Tree a) (Tree a)

tostr :: (Show a) => Tree a -> Int -> String
tostr Leaf d = ""
tostr (Node x l r) d = tostr l (d+1) ++ concat (replicate d "---") ++ show x
    ++ "\n" ++ (tostr r (d+1))

instance (Show a) => Show (Tree a) where
    show tree = tostr tree 0

minDepth :: Tree a -> Int
minDepth Leaf = 1
minDepth (Node x left right) = 1 + min (minDepth left) (minDepth right)

enforce :: (Eq a, Ord a) => Tree a -> Tree a
enforce Leaf = Leaf
enforce (Node x Leaf Leaf) = Node x Leaf Leaf
enforce (Node x (Node y left right) Leaf) 
                            | x < y = (Node y (Node x (enforce left) (enforce right)) Leaf)
                            | otherwise = (Node x (Node y (enforce left) (enforce right)) Leaf)
enforce (Node x Leaf (Node z left' right')) 
                                        | x < z = (Node z Leaf (Node x (enforce left') (enforce right')))
                                        | otherwise = (Node x Leaf (Node z (enforce left') (enforce right')))
enforce (Node x (Node y left right) (Node z left' right')) 
                                                    | x < y = (Node y (Node x (enforce left) (enforce right)) (Node z (enforce left') (enforce right')))
                                                    | x < z = (Node z (Node y (enforce left) (enforce right)) (Node x (enforce left') (enforce right')))
                                                    | otherwise = (Node x (Node y (enforce left) (enforce right)) (Node z (enforce left') (enforce right')))

insert :: (Eq a, Ord a) => a -> Tree a -> Tree a
-- insert x (Node y left right) = Node y (insert x left) right
insert x (Node y left right) 
                        | (minDepth left) > (minDepth right) = (enforce (Node y left (insert x right))) 
                        | otherwise = (enforce (Node y (insert x left) right))
insert x Leaf = (Node x Leaf Leaf)

buildHeap :: (Eq a, Ord a) => [a] -> Tree a
buildHeap [] = Leaf
buildHeap [x] = Node x Leaf Leaf
buildHeap (x:xs) = insert x (buildHeap xs)