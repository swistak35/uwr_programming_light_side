data Cyclist a = Elem (Cyclist a) a (Cyclist a) deriving (Show)

fromList :: [a] -> Cyclist a
fromList (x:xs) = let
                this = Elem prev x next 
                (next, prev) = aux this xs this
                in this

aux :: Cyclist a -> [a] -> Cyclist a -> (Cyclist a, Cyclist a) 
aux prev [] first = (first, prev) 
aux prev (x:xs) first = let
                        this = Elem prev x tmp 
                        (tmp, last) = aux this xs first 
                        in (this, last)

forward :: Cyclist a -> Cyclist a
forward (Elem _ _ next) = next

backward :: Cyclist a -> Cyclist a
backward (Elem prev _ _) = prev

label :: Cyclist a -> a
label (Elem _ a _)  = a

enumInts :: Cyclist Integer
enumInts = Elem (left enumInts) 0 (right enumInts)
        where   left current@(Elem prev x _) = Elem (left prev) (x-1) current
                right current@(Elem _ x next) = Elem current (x+1) (right next)

