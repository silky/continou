module Image where

import Color

type Coord = (Double, Double)
type Image a = Coord -> a
type Grid a = [[a]]

always :: a -> Image a
always = const

leftAndRight :: a -> a -> Image a
leftAndRight l r = \(x,y) -> if x < 0 then l else r

lerp :: (Enum a, Fractional a) => a -> a -> Int -> [a]
lerp s e n = [(e - s) / n' * i + s | i <- [0..n']]
    where n' = fromIntegral (n - 1)

grid :: Coord -> Coord -> Int -> Int -> Grid Coord
grid (l,b) (r,t) w h =
        [[(x,y) | x <- lerp l r w] | y <- lerp t b h]

render :: Image a -> Grid Coord -> Grid a
render f = map (map f)

