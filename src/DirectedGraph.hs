module DirectedGraph where

{-
    A simple directed graph with basic operations represented as an adjacency list [(Integer, Maybe Integer)], 
    in which each node has at most one outgoing edge, as induced by the Collatz function.
-}


newtype DirectedGraph = DG [(Integer, Maybe Integer)] deriving Show


child :: Integer -> DirectedGraph -> Maybe Integer
child n (DG al) | null l = Nothing
                | otherwise = snd (head l)
                    where 
                        l = filter (\x -> fst x == n) al


hasNode :: Integer -> DirectedGraph -> Bool
hasNode n g = n `elem` nodes g


emptyDirectedGraph :: DirectedGraph
emptyDirectedGraph = DG []


nodes :: DirectedGraph -> [Integer]
nodes (DG al) = map fst al


roots :: DirectedGraph -> [Integer]
roots (DG al) = filter (`notElem` [v | (_, Just v) <- al]) (nodes (DG al))


nodeLevels :: DirectedGraph -> [(Integer, Integer)]
nodeLevels (DG al) = map (\(n, _) -> (n, lvl n)) al
                    where 
                        lvl n = maybe 0 ((1 +) . lvl) (child n (DG al))

