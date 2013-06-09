import Control.Monad

tails1 :: [a] -> [[a]]
tails1 [] = [[]]
tails1 xs@(x:xs') = xs:tails1 xs'

tails2 :: [a] -> [[a]]
tails2 [] = [[]]
tails2 xs@(x:xs') = xs:[ys | ys <- tails2 xs']

tails3 :: [a] -> [[a]]
tails3 [] = [[]]
tails3 xs@(x:xs') = return xs `mplus` do
        ys <- tails3 xs'
        return ys