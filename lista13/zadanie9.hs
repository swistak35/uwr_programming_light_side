import Control.Monad

newtype Parser token st m value = Parser (([token],st) -> m ([token], st, value))

instance (Monad m) => Monad (Parser token st m) where
        return res = Parser (\(tokens,st) -> return (tokens, st, res))
        (>>=) (Parser f) g = Parser (\(tokens,st) ->
                (f (tokens,st)) >>= (\(rest, newSt, value) -> 
                let (Parser aux) = g value in aux (rest,st)))

instance (MonadPlus m) => MonadPlus (Parser token st m) where
        mplus (Parser p) (Parser q) = Parser (\(tokens, st) -> (p (tokens,st)) `mplus` (q (tokens,st)))
        mzero = Parser (\(tokens,st) -> mzero)

parse :: Monad m => Parser token st m value -> [token] -> st -> m value
parse (Parser f) tokens st = (f (tokens,st)) >>= (\(_, _, value) -> return value)

isElem :: (Eq token, MonadPlus m) => [token] -> Parser token st m token
isElem ts = Parser (\(token':tokens', st) -> if token' `elem` ts then return (tokens', st, token') else mzero)

isEmpty :: (MonadPlus m) => Parser token st m ()
isEmpty = Parser (\(tokens,st) -> if null tokens then return (tokens, st, ()) else mzero)

many :: (MonadPlus m) => Parser token st m value -> Parser token st m [value]
many parser@(Parser f) = (return []) `mplus` (many1 parser)

many1 :: (MonadPlus m) => Parser token st m value -> Parser token st m [value]
many1 parser@(Parser f) = Parser (\(tokens,st) -> let (Parser q) = (many parser) in (f (tokens,st)) >>= (\(ts, newSt, val) -> (q (ts, newSt)) >>= (\(ys, newSt', vals) -> return (ys, newSt', val:vals))))

option :: MonadPlus m => Parser token st m value -> Parser token st m value
option p = (return undefined) `mplus` p

isToken :: (Eq t, MonadPlus m) => t -> Parser t st m t
isToken t = Parser (\(ts,st) -> case ts of
        (t':ts') -> if t == t'
                then return $ (ts',st,t')
                else mzero
        [] -> mzero)

parse1 :: Parser Char () [] Integer
parse1 = do {
                isToken '1';
                return 1
        } `mplus` do {
                isToken '1';
                isToken '+';
                n <- parse1;
                return $ n+1
        }

parse2 :: Parser Char () [] ()
parse2 = do {
        isToken 'x';
        many (isToken 'x');
        isEmpty;
        --option (isToken 'x');
        return ()
}

runParser :: Parser token st m value -> [token] -> st -> m ([token], st, value)
runParser (Parser f) tokens st = f (tokens,st)