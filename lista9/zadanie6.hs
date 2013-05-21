import Data.List
import Data.Char

--myfunction :: Integer -> Maybe (Char, Integer)
--myfunction 0 = Nothing
--myfunction n = Just ((intToDigit . fromEnum) (n `mod` 10), n `div` 10)
--myfunction n = if n>0 then Just ((intToDigit . fromEnum) (n `mod` 10), n `div` 10) else Nothing

integerToString :: Integer -> String
integerToString 0 = "0"
integerToString n = (reverse . unfoldr (\n -> if n>0 then Just ((intToDigit . fromEnum) (n `mod` 10), n `div` 10) else Nothing)) n