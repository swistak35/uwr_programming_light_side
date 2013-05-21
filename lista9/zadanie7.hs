testowa2 x = x `mod` 2 == 0
testowa3 x = x `mod` 3 == 0
testowa6 x = x `mod` 6 == 0

newtype FSet a = FSet (a -> Bool)

empty :: FSet a
empty = FSet (const False)

singleton :: Ord a => a -> FSet a
singleton x = FSet ((==) x)

fromList :: Ord a => [a] -> FSet a
--fromList list = FSet (\x -> elem x list)
fromList list = FSet (flip elem list)

union :: Ord a => FSet a -> FSet a -> FSet a
union set1 set2 = FSet (\x -> member x set1 || member x set2)

intersection :: Ord a => FSet a -> FSet a -> FSet a
intersection set1 set2 = FSet (\x -> member x set1 && member x set2)

member :: Ord a => a -> FSet a -> Bool
member x (FSet set) = set x
