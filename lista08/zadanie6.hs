data Bar = Bar1 | Bar2 deriving (Eq, Show, Enum)
data Baz = Baz1 | Baz2 | Baz3 deriving (Eq, Show, Enum)

data Tara = Parka (Bar, Baz) deriving (Eq, Show)

--instance Enum Tara where
--  toEnum n = Parka ((toEnum (n `div` amount)), (toEnum (n `mod` amount)))
--  fromEnum (Parka (bar, baz)) = (fromEnum bar) * amount + (fromEnum baz)
-- ale amount = ((length [(toEnum 0 :: Bar)..]) + 1)

instance Enum Tara where
  toEnum n = Parka ((toEnum (n `div` ((length [(toEnum 0 :: Bar)..]) + 1))), (toEnum (n `mod` ((length [(toEnum 0 :: Bar)..]) + 1))))
  fromEnum (Parka (bar, baz)) = (fromEnum bar) * ((length [(toEnum 0 :: Bar)..]) + 1) + (fromEnum baz)