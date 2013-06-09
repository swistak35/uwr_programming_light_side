newtype SSC a = SSC (String -> (a, String))

instance Monad (SSC) where
        return res = SSC (\stream -> (res, stream))
        (>>=) (SSC f) g = SSC (\stream -> 
                let (value, rest) = f stream
                    (SSC aux) = g value
                in aux rest)

runSSC :: SSC a -> String -> a
runSSC (SSC f) = fst . f

getc :: SSC Char
getc = SSC (\(x:xs) -> (x,xs))

ungetc :: Char -> SSC ()
ungetc x = SSC (\xs -> ((),(x:xs)))

isEOS :: SSC Bool
isEOS = SSC (\xs -> (null xs, xs))


-- Uwaga, ta funkcja liczy ilość znaków nowej linii, a nie ilość linii.
-- Ex. countLines "test" zwróci 0, a countLines "test\ntest" zwróci 1.
-- Wypadałoby ją przezwać countNewLines lub zmienić `lines 0` na `lines 1`.
countLines :: String -> Int
countLines = runSSC $ lines 0 where
        lines :: Int -> SSC Int
        lines n = do
                b <- isEOS
                if b
                        then return n
                        else do
                                ch <- getc
                                lines (if ch == '\n' then n+1 else n)