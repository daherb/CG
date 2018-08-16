incomplete concrete CGFun of CGAbs = open Prelude, Predef in {
  lincat
    Cat, CGType, CG = Str ;
    Sentence = SS ;
  lin
    N = "" ;
    S = "" ;
    NP = "" ;
    Single c = c ;
    FSlash c1 c2 = c1 ++ c2 ;
    BSlash c2 c1 = c2 ++ c1 ;
    
    FB x y z xy yz = x ++ y ++ z ++ xy ++ yz ;
    BB x y z zy yx = x ++ y ++ z ++ zy ++ yx ;
    FS x y xy y2 = x ++ y ++ xy ++ y2 ;
    BS x y y2 yx = x ++ y ++ y2 ++ yx ;
    FT x y x2 = x ++ y ++ x2 ;
    BT x y x2 = x ++ y ++ x2 ;
    complete s = ss s ;
}