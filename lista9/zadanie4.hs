fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

--fibList = 1:1:zipWith (+) fibList (tail fibList)
fib' = (!!) fibList where fibList = 1:1:zipWith (+) fibList (tail fibList)
