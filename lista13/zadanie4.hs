newtype StateComput s a = SC (s -> (a,s))

instance Monad (StateComput s) where
        return result = SC (\state -> (result, state))
        (>>=) (SC f) g = SC (\state -> 
                let (value, newState) = f state
                    (SC aux) = g value
                in aux newState)
-- Przyda się tutaj drobny komentarz, konkretnie dlaczego piszemy "StateComput s",
-- a nie "StateComput" albo "StateComput s a".
-- W tym miejscu, zamieszane są rodzaje. (sprawdzane przez :k w repl'u)
-- Kiedy wejdziemy w definicję monady, to mamy tam typy funkcji, np. bind:
---- m a -> (a -> m b) -> m b
-- StateComput jest rodzaju "* -> * -> *", a tutaj wymagane jest od nas, aby m było rodzaju "* -> *"
-- Po zaaplikowaniu do konstruktora typów jednego z parametrów, dostajemy to co chcieliśmy.
-- Czyli ogólnie jest tutaj podobnie jak z typami i funkcjami (curried).
-- Pasuje nam to, gdyż typ stanu w naszej monadzie się nie zmienia - jak już używamy monady stanowej,
-- to typ jest cały czas taki sam, za to zmienia się typ wartości przekazywanej
-- w powyższym bindzie mamy np. "m a" i "m b", gdzie "a" i "b" to są właśnie typy wartości,
-- a "m" to jest nasze "StateComput s".


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