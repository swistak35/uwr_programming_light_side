nat2 :: [(Integer, Integer)]
nat2 = [(x, n-x) | n <- [0..], x <- [0..n]]