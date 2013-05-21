{-# LANGUAGE FlexibleInstances #-}

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

data Mtx2x2 a = Mtx2x2 a a a a deriving (Eq, Show)
--newtype IntegerMtx = IntegerMtx (Integer, Integer, Integer, Integer) deriving (Eq, Show)

--instance Monoid IntegerMtx where
--  (***) (IntegerMtx (a11, a12, a21, a22)) (IntegerMtx (b11, b12, b21, b22)) = IntegerMtx ((a11*b11+a12*b21), (a11*b21+a12*b22), (a21*b11+a22*b21), (a21*b12+a22*b22))
--  e = IntegerMtx (1, 0, 0, 1)

--mtx12 (IntegerMtx (a11, a12, a21, a22)) = a12
--fib n = mtx12 ((IntegerMtx (0, 1, 1, 1)) ^^^ n)

instance Monoid (Mtx2x2 Integer) where
  (***) (Mtx2x2 a11 a12 a21 a22) (Mtx2x2 b11 b12 b21 b22) = Mtx2x2 (a11*b11+a12*b21) (a11*b21+a12*b22) (a21*b11+a22*b21) (a21*b12+a22*b22)
  e = Mtx2x2 1 0 0 1

mtx12 :: Mtx2x2 a -> a
mtx12 (Mtx2x2 a11 a12 a21 a22) = a12

fib :: Integer -> Integer
fib n = mtx12 (x ^^^ n)
  where x = Mtx2x2 0 1 1 1 :: (Mtx2x2 Integer)