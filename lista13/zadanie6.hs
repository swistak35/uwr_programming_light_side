data Term sig var = Var var | FunSym sig [Term sig var] 

instance Monad (Term sig) where 
        (>>=) (Var x) f = f x 
        (>>=) (FunSym s xs) f = FunSym s (map (\y -> y >>= f) xs)
        return x = Var x