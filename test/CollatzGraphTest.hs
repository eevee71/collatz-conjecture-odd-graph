module Main where

import System.Environment (getArgs)
import DirectedGraph
import CollatzGraph

{-
    Test verifies that the generated graph contains every odd number from 1 to n, 
    and that all root nodes have values <= n.
-}


main :: IO ()
main = do
    (arg:_) <- getArgs
    let n = read arg
    let graph = collatzGraph n
    let oddMissing = filter (`notElem` nodes graph) [1,3..n]
    let rootsTooBig = filter (> n) (roots graph)

    if null oddMissing && null rootsTooBig
        then putStrLn "\x1b[32mGraph test OK\x1b[0m"
        else do
            putStrLn "\x1b[31mGraph test FAILED\x1b[0m"
            if not (null oddMissing) then
                putStrLn $ "Missing odd nodes: " ++ show oddMissing
            else return ()
            if not (null rootsTooBig) then
                putStrLn $ "Roots > n: " ++ show rootsTooBig
            else return ()
