import Control.Monad

newtype Parser token m value = Parser ([token] -> m ([token], value))

instance (Monad m) => Monad (Parser token m) where
        return res = Parser (\tokens -> return (tokens, res))
        (>>=) (Parser f) g = Parser (\tokens ->
                (f tokens) >>= (\(rest, value) -> 
                let (Parser aux) = g value in aux rest))

instance (MonadPlus m) => MonadPlus (Parser token m) where
        mplus (Parser p) (Parser q) = Parser (\tokens -> (p tokens) `mplus` (q tokens))
        mzero = Parser (\tokens -> mzero)

parse :: Monad m => Parser token m value -> [token] -> m value
parse (Parser f) tokens = (f tokens) >>= (\(_, value) -> return value)

isElem :: (Eq token, MonadPlus m) => [token] -> Parser token m token
isElem ts = Parser (\(token':tokens') -> if token' `elem` ts then return (tokens', token') else mzero)

isEmpty :: (MonadPlus m) => Parser token m ()
isEmpty = Parser (\tokens -> if null tokens then return (tokens, ()) else mzero)

many :: (MonadPlus m) => Parser token m value -> Parser token m [value]
many parser@(Parser f) = Parser (\ts -> return (ts,[])) `mplus` (many1 parser)

many1 :: (MonadPlus m) => Parser token m value -> Parser token m [value]
--many1 parser@(Parser f) = Parser (\tokens -> let (Parser q) = (many parser) in (f tokens) >>= (\(ts, val) -> (q ts) >>= (\(ys, vals) -> return (ys, val:vals))))
many1 parser@(Parser f) = Parser (\tokens -> do
        let Parser q = many parser
        (ts,val) <- f tokens
        (ys,vals) <- q ts
        return (ys,val:vals))

option :: MonadPlus m => Parser token m value -> value -> Parser token m value 
option p val = Parser (\ts -> return (ts,val)) `mplus` p
--option p = (return undefined) `mplus` p -- bardziej uniwersalne, hehehe.

isToken :: (Eq t, MonadPlus m) => t -> Parser t m t
isToken t = Parser (\ts -> case ts of
        (t':ts') -> if t == t'
                then return $ (ts',t')
                else mzero
        [] -> mzero)

parse1 :: Parser Char [] Integer
parse1 = do {
                isToken '1';
                return 1
        } `mplus` do {
                isToken '1';
                isToken '+';
                n <- parse1;
                return $ n+1
        }

parse2 :: Parser Char [] ()
parse2 = do {
        isToken 'x';
        many (isToken 'x');
        isEmpty;
        --option (isToken 'x');
        return ()
}

runParser :: Parser token m value -> [token] -> m ([token], value)
runParser (Parser f) tokens = f tokens


----- Fajny przykład

data Token = Number Integer | LParen | RParen | OpPlus | OpTimes deriving (Eq)

atom :: Parser Token [] Integer
atom = parseNum `mplus` (do
        isToken LParen
        m <- skladnik
        isToken RParen
        return m)

czynnik :: Parser Token [] Integer
czynnik = do
        n <- atom
        ns <- many (do
                isToken OpTimes
                atom)
        return $ foldl (*) n ns

skladnik :: Parser Token [] Integer
skladnik = do
        n <- czynnik
        ns <- many (do
                isToken OpPlus
                czynnik)
        return $ foldl (+) n ns

parseNum :: Parser Token [] Integer
parseNum = Parser (\ts -> (case ts of
        (Number n):ts' -> return (ts',n)
        _ -> mzero))