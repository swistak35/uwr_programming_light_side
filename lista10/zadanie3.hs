merge_unique :: Ord a => [a] -> [a] -> [a]
merge_unique [] ys = ys
merge_unique xs [] = xs
merge_unique xs@(x:xs') ys@(y:ys')
  | y < x     = y:(merge_unique xs ys')
  | y == x    = merge_unique xs ys'
  | otherwise = x:merge_unique xs' ys

d235, d235' :: [Integer]
d235 = 1:merge_unique (map (2*) d235) (merge_unique (map (3*) d235) (map (5*) d235))
d235' = 1 : foldl1 merge_unique [ map (n*) d235' | n <- [2,3,5] ]

--merge (x:xs) (y:ys) = case compare x y of
--    LT -> x : merge xs (y:ys)
--    GT -> y : merge (x:xs) ys
--    EQ -> x : merge xs ys