import Control.Monad 
import Data.List 

perms :: (Eq a) => [a] -> [[a]]
perms [] = [[]]
perms xs = concatMap (\x -> map (x:) (perms $ delete x xs)) xs

perms2 :: (Eq a) => [a] -> [[a]]
perms2 [] = [[]]
perms2 xs = [y:ys | y <- xs, ys <- perms2 (delete y xs)]

perms3 :: (Eq a) => [a] -> [[a]]
perms3 [] = [[]]
perms3 xs = do
        x <- xs
        ys <- perms3 (delete x xs)
        return (x:ys)