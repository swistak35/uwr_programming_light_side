prod :: [Integer] -> Integer
prod xs = if wynik == Nothing then 0 else let Just n = wynik in n where 
      wynik = foldr (\n acc -> 
            if acc /= Nothing
            then 
                 let Just acc' = acc
                 in if n == 0
                    then Nothing
                    else Just (n*acc')
            else acc) (Just 1) xs

prod' :: Maybe Integer -> [Integer] -> Maybe Integer
prod' (Just x) [] = Just x
prod' acc (x:xs) = if x == 0 then Nothing else acc >>= (\mult -> prod' (Just $ mult*x) xs)

prod :: [Integer] -> Integer
prod xs = if res == Nothing then 0 else let Just x = res in x
        where res = prod' (Just 1) xs