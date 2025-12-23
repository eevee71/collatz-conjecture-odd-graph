module DirectedGraph where

{-
    A simple directed graph represented 
    as an adjacency list [(Integer, [Integer])] with basic operations
-}


newtype DirectedGraph = DG [(Integer, [Integer])]


addNode :: Integer -> DirectedGraph -> DirectedGraph
addNode n (DG al) = DG ((n, []) : al)


addEdge :: Integer -> Integer -> DirectedGraph -> DirectedGraph
addEdge n v (DG al) = DG [(x, if x == n then v : l else l) | (x, l) <- al]


neighbors :: Integer -> DirectedGraph -> [Integer]
neighbors n (DG al) | null l = []
                    | otherwise = snd(head l)
                    where 
                        l = filter (\x -> fst x == n) al


hasNode :: Integer -> DirectedGraph -> Bool
hasNode n (DG al) = n `elem` map fst al


emptyDirectedGraph :: DirectedGraph
emptyDirectedGraph = DG []

