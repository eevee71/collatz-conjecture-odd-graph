module Main where

import System.Environment
import Graphics.Gloss
import DirectedGraph
import GraphDraw
import CollatzGraph

main :: IO ()
main = do
        (arg:_) <- getArgs
        let graph = collatzGraph (read arg)
        display
            (InWindow "Graph" (1000, 600) (100, 100))
             white
            (drawGraph graph)

