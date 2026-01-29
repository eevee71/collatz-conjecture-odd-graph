module Main where

import System.Environment
import Graphics.Gloss
import DirectedGraph
import GraphDraw
import CollatzGraph

main :: IO ()
main = do
        args <- getArgs
        if null args then putStrLn "Missing argument"
        else do
            let graph = collatzGraph (read (head args))
            display
                (InWindow "Graph" (1000, 600) (100, 100))
                 white
                (drawGraph graph)

