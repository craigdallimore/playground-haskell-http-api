{-# LANGUAGE OverloadedStrings #-}

module Types.MediaScreeningKeywordList where

import Data.Aeson
import Control.Monad

data MediaScreeningKeywordList = MediaScreeningKeywordList
  { id :: String
  , name :: String
  , keywords :: [String]
  }


instance FromJSON MediaScreeningKeywordList where
  parseJSON (Object v) = MediaScreeningKeywordList <$>
                       v .: "id" <*>
                       v .: "name" <*>
                       v .: "keywords"
  parseJSON _          = mzero

instance Show MediaScreeningKeywordList where
  show mskl = "\nname: " ++ name mskl
           ++ "\nid: " ++ Types.MediaScreeningKeywordList.id mskl
           ++ "\nkeywords: " ++ foldr (\b a -> b ++ "\n" ++ a) "\n" (keywords mskl)

