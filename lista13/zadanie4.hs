newtype StateComput s a = SC (s -> (a,s))

instance Monad (StateComput s) where
        return result = SC (\state -> (result, state))
        (>>=) (SC f) g = SC (\state -> 
                let (value, newState) = f state
                    (SC aux) = g value
                in aux newState)

------
------ Poniżej są zadania 2 i 3, z drobnymi modyfikacjami, żeby korzystać z StateComput
------

-- Zadanie 2
type RandomState = Int

initr :: Int -> StateComput RandomState ()
initr x = SC (\_ -> ((),x))

random :: StateComput RandomState Int
random = SC (\seed ->
        let     newSeed' = 16807 * (seed `mod` 127773) - 2836 * (seed `div` 12773)
                newSeed  = if newSeed' > 0 then newSeed' else newSeed + 2147483647
        in (newSeed, newSeed))

jednaLosowaLiczba :: Int -> Int
jednaLosowaLiczba seed = fst (frand seed) where
        SC frand = random

testowanko :: StateComput RandomState [Int]
testowanko = do
        x1 <- random
        x2 <- random
        initr 5
        x1' <- random
        x2' <- random
        return [x1, x2, x1', x2']

testowanko2 :: Int -> [Int]
testowanko2 = fst . frand where
        SC frand = testowanko

-- Zadanie 3
type SSCState = String

runSSC :: StateComput SSCState a -> String -> a
runSSC (SC f) = fst . f

getc :: StateComput SSCState Char
getc = SC (\(x:xs) -> (x,xs))

ungetc :: Char -> StateComput SSCState ()
ungetc x = SC (\xs -> ((),(x:xs)))

isEOS :: StateComput SSCState Bool
isEOS = SC (\xs -> (null xs, xs))

countLines :: String -> Int
countLines = runSSC $ lines 0 where
        lines :: Int -> StateComput SSCState Int
        lines n = do
                b <- isEOS
                if b
                        then return n
                        else do
                                ch <- getc
                                lines (if ch == '\n' then n+1 else n)