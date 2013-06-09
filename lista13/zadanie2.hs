newtype Random a = MkRandom (Int -> (a, Int))

instance Monad (Random) where
        return res = MkRandom (\seed -> (res, seed))
        (>>=) (MkRandom f) g = MkRandom (\seed -> 
                let (value, newSeed) = f seed
                    (MkRandom aux) = g value
                in aux newSeed)

initr :: Int -> Random ()
initr x = MkRandom (\_ -> ((),x))

random :: Random Int
random = MkRandom (\seed ->
        let     newSeed' = 16807 * (seed `mod` 127773) - 2836 * (seed `div` 12773)
                newSeed  = if newSeed' > 0 then newSeed' else newSeed + 2147483647
        in (newSeed, newSeed))

jednaLosowaLiczba :: Int -> Int
jednaLosowaLiczba seed = fst (frand seed) where
        MkRandom frand = random

testowanko :: Random [Int]
testowanko = do
        x1 <- random
        x2 <- random
        initr 5
        x1' <- random
        x2' <- random
        return [x1, x2, x1', x2']

testowanko2 :: Int -> [Int]
testowanko2 = fst . frand where
        MkRandom frand = testowanko