import Control.Monad 
import Data.List 

sublist :: [a] -> [[a]]
sublist [] = [[]]
sublist (x:xs) = concatMap (\ys -> [x:ys, ys]) $ sublist xs

sublist2 :: [a] -> [[a]]
sublist2 [] = [[]]
sublist2 (x:xs) = [res | ys <- sublist2 xs, res <- [x:ys, ys]]

sublist3 :: [a] -> [[a]]
sublist3 [] = [[]]
sublist3 (x:xs) = do
        ys <- sublist3 xs
        res <- [x:ys, ys]
        return res

--permi :: [a] -> [[a]]
--permi [] = [[]]
--permi (x:xs) = concatMap (insert' x) $ permi xs

--permi2 :: [a] -> [[a]] 
--permi2 [] = [[]] 
--permi2 (x:xs) = [zs | ys <-permi2 xs, zs <- insert' x ys] 

--permi3 :: [a] -> [[a]]
--permi3 [] = [[]]
--permi3 (x:xs) = do
--        ys <- permi3 xs
--        zs <- insert' x ys
--        return zs

--insert' x [] = [[x]] 
--insert' x l@(y:ys) = [x:l] ++ (map (y:) $ insert' x ys)

