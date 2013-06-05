import Control.Monad 
import Data.List 

permi :: [a] -> [[a]]
permi [] = [[]]
permi (x:xs) = concatMap (insert' x) $ permi xs

permi2 :: [a] -> [[a]] 
permi2 [] = [[]] 
permi2 (x:xs) = [zs | ys <-permi2 xs, zs <- insert' x ys] 

permi3 :: [a] -> [[a]]
permi3 [] = [[]]
permi3 (x:xs) = do
        ys <- permi3 xs
        zs <- insert' x ys
        return zs

insert' x [] = [[x]] 
insert' x l@(y:ys) = [x:l] ++ (map (y:) $ insert' x ys)

