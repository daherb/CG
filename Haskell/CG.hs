import Debug.Trace
data BaseCat = N | S | NP deriving (Eq) ;
data Cat = B BaseCat | LS Cat Cat | RS Cat Cat | AP Cat Cat deriving (Eq) ;

instance Show BaseCat where
  show N = "N";
  show S = "S";
  show NP = "NP";

instance Show Cat where
  show (LS c1 c2) = "(" ++ show c1 ++ "\\" ++ show c2 ++ ")"
  show (RS c1 c2) = "(" ++ show c1 ++ "/" ++ show c2 ++ ")"
  show (AP c1 c2) = "(" ++ show c1 ++ "*" ++ show c2 ++ ")"
  show (B c) = show c

data Rule = R String Cat
type Grammar = [Rule]

grammar :: Grammar
grammar = [ R "man" (B N), R "woman" (B N), R "John" (B NP), R "Mary" (B NP), R "sleeps" (LS (B NP) (B S)), R "loves" (RS (LS (B NP) (B S)) (B NP)), R "a" (RS (B NP) (B N)), R "some" (RS (B NP) (B N)), R "every" (RS (B NP) (B N)), R "a" (B NP), R "b" (B NP) ]

sentence1 = "John sleeps"
sentence2 = "John loves Mary"
sentence3 = "a man loves every woman"
sentence4 = "a loves b"
antisentence1 = "John loves"

recognizeCat :: Grammar -> Cat -> String -> Bool
recognizeCat gram cat sent =
  let ws = words sent in recognize' ws []
  where
    recognize' :: [String] -> [[Cat]] -> Bool
    recognize' [] [[cat]] = True
    recognize' [] _ = False
    recognize' (w:ws) [] =
      let cs = [c | (R t c) <- gram, t == w] in recognize' ws [cs]
    recognize' (w:ws) cs =
      let wcs = [c | (R t c) <- gram, t == w] in
      trace (show w ++ " "++ show (wcs:cs)) $ recognize' ws (reduce (wcs:cs))

recognize :: Grammar -> String -> Bool
recognize gram sent = recognizeCat gram (B S) sent
  
reduce :: [[Cat]] -> [[Cat]]
reduce p@(c:cc:cs)
--  | compatible cc c = trace ("Reduce1 " ++ show p) $ let (n,nn) = combine cc c in reduce $ filter (not . null) $ n:(reduce $ nn:cs)
  | compatible cc c = trace ("Reduce1 " ++ show p) $ (reduce $ (combine cc c):cs)
  | otherwise = trace ("Reduce2 " ++ show p) $ c:(reduce $ cc:cs)
reduce p = trace ("Reduce3 " ++ show p) p

compatible :: [Cat] -> [Cat] -> Bool
compatible c c2 = let r = or [applicable t t2 | t <- c, t2 <- c2 ] in trace ("Compatible " ++ show c ++ " " ++ show c2 ++ "-->" ++ show r) r

applicable :: Cat -> Cat -> Bool
applicable c c2 =  case (apply c c2) of { (AP _ _) ->  False ; _ -> True }

-- combine :: [Cat] -> [Cat] -> ([Cat],[Cat])
combine :: [Cat] -> [Cat] -> [Cat]
combine c c2 =
  let -- notApplicable1 = [t | t <- c, not $ any (applicable t) c2]
      -- notApplicable2 = [t2 | t2 <- c2, not $ any (flip applicable $ t2) c]
      applied = [apply t t2 | t <- c, t2 <- c2, applicable t t2 ]
  in applied -- (notApplicable1,notApplicable2 ++ applied)
     
apply :: Cat -> Cat -> Cat
apply c p2@(LS c1 c2)
  | c == c1 = c2
  | otherwise = AP c p2
apply p1@(RS c c1) c2
  | c1 == c2 = c
  | otherwise = AP p1 c2
apply c c2 = AP c c2
-- application
-- associativity
-- composition
-- raising
-- division
