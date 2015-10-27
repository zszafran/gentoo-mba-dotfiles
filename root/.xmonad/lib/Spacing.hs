{-# LANGUAGE DeriveDataTypeable, NoMonomorphismRestriction, MultiParamTypeClasses, ImplicitParams #-}
-------------------------------------------------------------------------------
-- | Allows dynamic modification of window spacing
-- ----------------------------------------------------------------------------
module Spacing (
               Spacing(..)
               , SPACING(..)
               , spacing
               ) where

import Graphics.X11 (Rectangle(..))
import Control.Arrow (second)
import XMonad.Util.Font (fi)

import XMonad.Layout.LayoutModifier
import XMonad.Core

data Spacing a = Spacing Int deriving (Show, Read)
data SPACING = SPACING Int  deriving (Read, Show, Eq, Typeable)

spacing :: Int -> l a -> ModifiedLayout Spacing l a
spacing p = ModifiedLayout (Spacing p)

instance Message SPACING

instance LayoutModifier Spacing a where
  pureModifier (Spacing p) _ _ wrs = (map (second $ shrinkRect p) wrs, Nothing)
  pureMess (Spacing x) m = case fromMessage m of
      Just (SPACING n) -> Just $ Spacing (x+n)
      Nothing -> Nothing

  modifierDescription (Spacing p) = "Spacing " ++ show p

shrinkRect :: Int -> Rectangle -> Rectangle
shrinkRect p (Rectangle x y w h) = Rectangle (x+fi p) (y+fi p) (w-2*fi p) (h-2*fi p)
