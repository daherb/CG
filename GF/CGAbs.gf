abstract CGAbs = {
  flags startcat = Sentence ;
  cat Cat ;
      CGType ;
      CG CGType ;
      Sentence ;
  data
    Single : Cat -> CGType ;
    FSlash : CGType -> CGType -> CGType ;
    BSlash : CGType -> CGType -> CGType ;

  fun
    -- To form startcat
    complete : CG (Single S) -> Sentence ;
    -- The categories
    N : Cat ;
    S : Cat ;
    NP : Cat ;
    -- The combinators
    FB : ({x,y,z} : CGType) -> CG (FSlash x y) -> CG (FSlash y z) -> CG (FSlash x z) ;
    BB : ({z,y,x} : CGType) -> CG (BSlash z y) -> CG (BSlash y x) -> CG (BSlash z x) ;
    FS : ({x,y} : CGType) -> CG (FSlash x y) -> CG y -> CG x ;
    BS : ({y,x} : CGType) -> CG y -> CG (BSlash y x) -> CG x ;
    -- X -> T -> T/(T\X)
    FT : ({x,y} : CGType) -> CG x -> CG (FSlash y (BSlash x y)) ;
    -- BT : ({x,y} : CGType) -> CG x -> CG (BSlash y (FSlash y x)) ;
    -- X -> T -> T\(T/X)
    BT : ({x,y} : CGType) -> CG x -> CG (BSlash (FSlash y x) y) ;

    -- The lexicon
    -- man : CG (Single N) ;
    -- sleeps : CG (BSlash (Single N) (Single S)) ;
    -- john : CG (Single N) ;
    -- mary : CG (Single N) ;
    -- loves : CG (FSlash (BSlash (Single N) (Single S)) (Single N));
    -- the : CG (FSlash (Single N) (Single N));
    -- that : CG (FSlash (Single N) (Single N));
    -- small : CG (FSlash (Single N) (Single N));
    -- hungry : CG (FSlash (Single N) (Single N));
    -- brown : CG (FSlash (Single N) (Single N));
    -- dog : CG (Single N) ;
    the : CG (FSlash (Single NP) (Single N)) ;
    dog : CG (Single N) ; 
    bit : CG (FSlash (BSlash (Single NP) (Single S)) (Single NP)) ;
    john : CG (Single NP) ;

}