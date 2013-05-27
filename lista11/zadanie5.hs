lengthr = foldr (\_ x -> x+1) 0
lengthr' = foldr (const (+1)) 0
lengthl = foldl (\x _ -> x+1) 0
lengthl' = foldl (\x -> const (x+1)) 0
(+++) = flip $ foldr (:)
concat = foldr (++) []
reverse = foldl (flip (:)) []
sum = foldl (+) 0
