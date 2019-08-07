-- Agda definition of C-- abstract syntax trees
-- and Haskell bindings to the ones generated by the parser.

module V2.AST where

open import Library

{-# FOREIGN GHC import qualified Data.Text #-}
{-# FOREIGN GHC import While.Abs #-}
{-# FOREIGN GHC import While.Print #-}

data Id : Set where
  mkId : List Char → Id

{-# COMPILE GHC Id = data Ident (Ident) #-}

data Type : Set where
  bool int : Type

{-# COMPILE GHC Type = data Type
  ( TBool
  | TInt
  ) #-}

data Boolean : Set where
  true false : Boolean

{-# COMPILE GHC Boolean = data Boolean (BTrue | BFalse) #-}

data Exp : Set where
  eId       : (x : Id)                 → Exp
  eInt      : (i : ℤ)                  → Exp
  eBool     : (b : Boolean)            → Exp
  ePlus     : (e e' : Exp)             → Exp
  eGt       : (e e' : Exp)             → Exp
  eAnd      : (e e' : Exp)             → Exp


{-# COMPILE GHC Exp = data Exp
  ( EId
  | EInt
  | EBool
  | EPlus
  | EGt
  | EAnd
  ) #-}

record Decl : Set where
  constructor dInit
  field declType : Type
        declId   : Id
        declExp  : Exp
open Decl public

{-# COMPILE GHC Decl = data Decl
  ( DInit
  ) #-}

record Program : Set where
  constructor program
  field
    theDecls : List Decl
    theMain  : Exp
open Program public

{-# COMPILE GHC Program = data Program (Prg) #-}

-- Pretty printer

instance
  PrintId : Print Id
  print {{PrintId}} (mkId s) = String.fromList s

private
  postulate
    printType    : Type    → String
    printBoolean : Boolean → String
    printExp     : Exp     → String
    printProgram : Program → String

{-# COMPILE GHC printType    = \ t -> Data.Text.pack (printTree (t :: Type))    #-}
{-# COMPILE GHC printBoolean = \ b -> Data.Text.pack (printTree (b :: Boolean)) #-}
{-# COMPILE GHC printExp     = \ e -> Data.Text.pack (printTree (e :: Exp))     #-}
{-# COMPILE GHC printProgram = \ p -> Data.Text.pack (printTree (p :: Program)) #-}

instance
  PrintType : Print Type
  print {{PrintType}} = printType

  PrintBoolean : Print Boolean
  print {{PrintBoolean}} = printBoolean

  PrintExp : Print Exp
  print {{PrintExp}} = printExp

  PrintProgram : Print Program
  print {{PrintProgram}} = printProgram

-- Eq instances

instance
  EqId : Eq Id
  _≟_ {{EqId}} (mkId x) (mkId y) = case x ≟ y of λ where
    (yes p) → yes (cong mkId p)
    (no ¬p) → no (λ { refl → ¬p refl })

  EqType : Eq Type
  _≟_ {{EqType}} = λ where
    bool bool → yes refl
    bool int  → no λ ()
    int  bool → no λ ()
    int  int  → yes refl
