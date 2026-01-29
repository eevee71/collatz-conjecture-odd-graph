module GraphDraw (drawGraph) where

import Graphics.Gloss
import DirectedGraph

{-
    Rendering of a directed graph using Gloss.
    - X-axis: Node levels based on distance to 'node 1'.
    - Y-axis: Symmetrical centering for nodes on the same level.
-}

type NodePosition = (Integer, (Float, Float))

lightBlue = makeColor 0.68 0.85 0.90 1.0


drawGraph :: DirectedGraph -> Picture
drawGraph graph  = Pictures (map drawEdge edges ++ map drawNode pos)
                    where
                        pos = nodePositions graph
                        edges = computeEdges graph pos


positionOf :: Integer -> [NodePosition] -> (Float, Float)
positionOf n ps | null l = (0, 0)
                | otherwise = snd (head l)
                    where 
                        l = filter (\x -> fst x == n) ps


computeEdges :: DirectedGraph -> [NodePosition] -> [((Float, Float), (Float, Float))]
computeEdges (DG al) pos = [(positionOf n pos, positionOf v pos) | (n, Just v) <- al]


nodePositions :: DirectedGraph -> [NodePosition]
nodePositions (DG al) = [(n, (fromIntegral lvl * 160, getY n lvl)) | (n, lvl) <- levels]
  where
    levels = nodeLevels (DG al)
    getY n lvl = (idx - (fromIntegral (length nodesOnSameLevel) - 1) / 2) * 80
        where 
            nodesOnSameLevel = [v | (v, l) <- levels, l == lvl]
            idx = head [i | (v, i) <- zip nodesOnSameLevel [0..], v == n]
 
   
drawNode :: NodePosition -> Picture
drawNode (n, (x,y)) = Translate x y $ Pictures
    [ Color lightBlue (circleSolid 30),
     Color black (circle 30),
     Translate (-13) (-7) $ Scale 0.12 0.12 $ Color black $ Text (show n)
    ]


arrow :: (Float, Float) -> (Float, Float) -> Picture
arrow (x1, y1) (x2, y2) =
    let r = 35
        size = 12
        dx = x2 - x1
        dy = y2 - y1
        angle = atan2 dy dx * 180 / pi
        d = sqrt (dx*dx + dy*dy)
        x = x2 - (dx / d) * r  
        y = y2 - (dy / d) * r
        tri = Polygon [(size/2,0), (-size/2, size/2), (-size/2, -size/2)]
    in Translate x y $ Rotate (-angle) $ Color black tri


drawEdge :: ((Float, Float), (Float, Float)) -> Picture
drawEdge ((x1,y1), (x2,y2)) = Pictures [Color black $ Line [(x1,y1), (x2,y2)], arrow (x1,y1) (x2,y2)]

