merge :: Ord a => ([a], [a]) -> [a]
merge ([], ys) = ys
merge (xs, []) = xs
merge (xs@(x:xs'), ys@(y:ys'))
  | y <= x    = y:merge(xs, ys')
  | otherwise = x:merge(xs', ys)

msort :: Ord a => [a] -> [a]
msort xs = msortn xs (length xs)

msortn :: Ord a => [a] -> Int -> [a]
msortn [] 0 = []
msortn [x] 1 = [x]
msortn xs n = merge (msort newlist m, msort (drop m newlist) (n-m))
  where m = n `div` 2
        newlist = take n xs