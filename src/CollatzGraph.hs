module CollatzGraph where

import DirectedGraph

{-
    Constructing the minimal directed subgraph of the odd‑only Collatz graph
    that contains all odd numbers from 1 to n.
-}


collatzGraph :: Integer -> DirectedGraph
collatzGraph n = DG (build (filter odd [1..n]) [])


collatzNextOdd :: Integer -> Maybe Integer
collatzNextOdd 1 = Nothing
collatzNextOdd n | even n = if odd afterDiv then Just afterDiv else collatzNextOdd afterDiv
                 | otherwise = if odd afterOdd then Just afterOdd else collatzNextOdd afterOdd
                     where 
                        afterOdd = 3 * n + 1   
                        afterDiv = div n 2


build :: [Integer] -> [(Integer, Maybe Integer)] -> [(Integer, Maybe Integer)]
build [] al = al
build (x:xs) al | x `elem` nodes graph = build xs al
                | otherwise = nextOdd (collatzNextOdd x)
                where nextOdd Nothing = build xs ((x, Nothing) : al)
                      nextOdd (Just next) = let newAl = ((x, Just next) : al)
                                              in if next `elem` nodes graph
                                                    then build xs newAl
                                                 else 
                                                    build (next : xs) newAl
                      graph = DG al

