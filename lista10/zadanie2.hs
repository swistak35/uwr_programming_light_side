cross :: (a -> c, b -> d) -> (a, b) -> (c, d)
cross (f, g) = pair (f . fst, g . snd)

pair :: (a -> b, a -> c) -> a -> (b, c)
pair (f, g) x = (f x, g x)

halve :: [a] -> ([a], [a])
halve xs = (take n xs, drop n xs)
  where n = length(xs) `div` 2

merge :: Ord a => ([a], [a]) -> [a]
merge ([], ys) = ys
merge (xs, []) = xs
merge (xs@(x:xs'), ys@(y:ys'))
  | y <= x    = y:merge(xs, ys')
  | otherwise = x:merge(xs', ys)

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge . cross (msort,msort) . halve $ xs