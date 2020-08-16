{-# LANGUAGE DeriveGeneric #-}

module Types.MediaScreeningKeywordList where

import Data.Aeson
import Control.Monad
import GHC.Generics

data MediaScreeningKeywordList = MediaScreeningKeywordList
  { id :: String
  , name :: String
  , keywords :: [String]
  } deriving (Generic, Show)

instance ToJSON MediaScreeningKeywordList where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON MediaScreeningKeywordList
