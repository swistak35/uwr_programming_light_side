roots0 :: (Double, Double, Double) -> [Double]
roots0 (a,b,c)
  | a == 0      = error "Idz byc dwumianem/stala gdzie indziej"
  | cres == GT  = [((-b-sqrt(delta))/2*a), ((-b+sqrt(delta))/2*a)]
  | cres == EQ  = [-b/2*a]
  | otherwise   = []
  where delta = b*b-4*a*c
        cres = compare delta 0

roots1 :: (Double, Double, Double) -> [Double]
roots1 (a,b,c)
  | a == 0      = []
  | delta > 0   = [((-b-sqrt(delta))/2*a), ((-b+sqrt(delta))/2*a)]
  | delta == 0  = [-b/2*a]
  | otherwise   = []
  where delta = b*b-4*a*c


data Roots = No | One Double | Two (Double, Double) deriving Show
roots2 :: (Double, Double, Double) -> Roots
roots2 (a,b,c)
  | a == 0      = No
  | delta > 0   = Two (((-b-sqrt(delta))/2*a), ((-b+sqrt(delta))/2*a))
  | delta == 0  = One (-b/2*a)
  | otherwise   = No
  where delta = b*b-4*a*c

roots3 :: Double -> Double -> Double -> [Double]
roots3 a b c
  | a == 0      = []
  | delta > 0   = [((-b-sqrt(delta))/2*a), ((-b+sqrt(delta))/2*a)]
  | delta == 0  = [-b/2*a]
  | otherwise   = []
  where delta = b*b-4*a*c

roots4 :: [Double] -> [Double]
roots4 (a:b:c:[])
  | a == 0      = []
  | delta > 0   = [((-b-sqrt(delta))/2*a), ((-b+sqrt(delta))/2*a)]
  | delta == 0  = [-b/2*a]
  | otherwise   = []
  where delta = b*b-4*a*c