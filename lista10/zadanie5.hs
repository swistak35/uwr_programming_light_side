class Monoid a where
  e :: a
  (***) :: a -> a -> a
infixl 6 ***
(^^^) :: Monoid a => a -> Integer -> a
infixr 7 ^^^
(^^^) a 0 = e
(^^^) a n
  | n < 0           = error "No."
  | n `mod` 2 == 0  = half *** half
  | otherwise       = a *** half *** half
  where half = a ^^^ (n `div` 2)

--instance Monoid Integer where
--  (***) x y = x+y
--  e = 0

instance Monoid Integer where
  (***) x y = x*y `mod` 9876543210
  e = 1