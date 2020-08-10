{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Examples where

import Text.RawString.QQ
import Data.ByteString.Lazy (ByteString)

-------------------------------------------------------------------------------
-- Examples
-------------------------------------------------------------------------------

loginResponseEx :: ByteString
loginResponseEx = [r|
{
  "name": "Craig Dallimore",
  "requiresTeamSelection": true,
  "teams": [
    { "teamId": "a83a503fcbad4b4e99d405bf0c5eab8b", "teamName": "Blue" },
    { "teamId": "0b004e271b344f3ca2d2b8d00c92753b", "teamName": "Evidence Links" },
    { "teamId": "881beee766444ac8904c77dc027331a3", "teamName": "Guernsey" },
    { "teamId": "c294dda48c064ceea3404fe387a87c76", "teamName": "Nomura" },
    { "teamId": "a6d0bae65f194b2a859eede0d33779b4", "teamName": "PwC CEE" },
    { "teamId": "b37b34f02c1946a4a54e42de00166568", "teamName": "PwC Europe" },
    { "teamId": "157fc1c7013f427995e0ebd761cf33a3", "teamName": "PwC India" },
    { "teamId": "653a77a346184e69b45530edd6f157f8", "teamName": "PwC UAE" },
    { "teamId": "1310f35e3879428b91e543ef11b5ca03", "teamName": "PwC UK" },
    { "teamId": "e9e242bbf12146d0b3bf2d47fd889fb6", "teamName": "PwC UK Independence" },
    { "teamId": "23bd44053ef04d90bd667794dcd65437", "teamName": "PwC US" },
    { "teamId": "e7885926b45e48b1a4913d44471348f8", "teamName": "Radar QA" },
    { "teamId": "e9dea25c4f454144a24431c172f6a65d", "teamName": "Radar QA2" },
    { "teamId": "8032afac8c3f41638fb05bb8f5e458b9", "teamName": "Radar Team" }
  ]
}
|]

targetWorkflowSettingsEx :: ByteString
targetWorkflowSettingsEx = [r|
{
  "pepSanctionsEnabled": false,
  "pepSanctionsSources": [],
  "adverseMediaEnabled": false
}
|]

radarClassicSettingsEx :: ByteString
radarClassicSettingsEx = [r|
{
        "flags": ["Not Confirmed", "Confirmed", "Not Relevant"],
        "monitoringEnabled": false,
        "dataSourceProviders": [
          "bvd-mint-search",
          "farmyard.worldcheck-premium-plus-multisource",
          "dowjones-factiva-singlesource",
          "farmyard.worldcheck-premium-plus-singlesource",
          "emis-isi-singlesource",
          "farmyard.dowjones-watchlist-singlesource",
          "farmyard.dowjones-watchlist-multisource",
          "farmyard.dowjones-state-owned-companies"
        ],
        "dataSourceSettings": {
          "bvd-mint-search": { "password": "dsf324", "username": "PWCWS" },
          "dowjones-factiva-singlesource": {
            "encryptionToken": "S002H39QVBJ5DEu5DEqOTYtMpUmMD7yMHn0RtfqMGNw0rfYTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQQAA"
          }
        }
      }
|]

dataSourceSettingsEx :: ByteString
dataSourceSettingsEx = [r|
{
  "bvd-mint-search": { "password": "dsf324", "username": "PWCWS" },
  "dowjones-factiva-singlesource": {
    "encryptionToken": "S002H39QVBJ5DEu5DEqOTYtMpUmMD7yMHn0RtfqMGNw0rfYTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQQAA"
  }
}
|]

mediaScreeningKeywordListEx :: ByteString
mediaScreeningKeywordListEx = [r|
{
  "id": "f7e2029d1920429b928c89676c1c9280",
  "name": "English Adverse Phrase List",
  "keywords": [
      "abuse*",
      "accus*",
      "accuse",
      "alleg*",
      "arraign*"
    ]
}
|]

teamEx :: ByteString
teamEx = [r|
{
      "name": "Blue",
      "timeZone": "Europe/London",
      "targetWorkflowSettings": {
        "pepSanctionsEnabled": false,
        "pepSanctionsSources": [],
        "adverseMediaEnabled": false
      },
      "radarClassicSettings": {
        "flags": ["Not Confirmed", "Confirmed", "Not Relevant"],
        "monitoringEnabled": false,
        "dataSourceProviders": [
          "bvd-mint-search",
          "farmyard.worldcheck-premium-plus-multisource",
          "dowjones-factiva-singlesource",
          "farmyard.worldcheck-premium-plus-singlesource",
          "emis-isi-singlesource",
          "farmyard.dowjones-watchlist-singlesource",
          "farmyard.dowjones-watchlist-multisource",
          "farmyard.dowjones-state-owned-companies"
        ],
        "dataSourceSettings": {
          "bvd-mint-search": { "password": "dsf324", "username": "PWCWS" },
          "dowjones-factiva-singlesource": {
            "encryptionToken": "S002H39QVBJ5DEu5DEqOTYtMpUmMD7yMHn0RtfqMGNw0rfYTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQQAA"
          }
        }
      },
      "mediaScreeningKeywordLists": [
        {
          "id": "f7e2029d1920429b928c89676c1c9280",
          "name": "English Adverse Phrase List",
          "keywords": [
            "abuse*",
            "accus*",
            "accuse",
            "alleg*",
            "arraign*"
          ]
        }
      ],
      "tenant": "blue",
      "id": "a83a503fcbad4b4e99d405bf0c5eab8b"
    }
|]

teamItemEx :: ByteString
teamItemEx = [r|
  {
    "team": {
      "name": "Blue",
      "timeZone": "Europe/London",
      "targetWorkflowSettings": {
        "pepSanctionsEnabled": false,
        "pepSanctionsSources": [],
        "adverseMediaEnabled": false
      },
      "radarClassicSettings": {
        "flags": ["Not Confirmed", "Confirmed", "Not Relevant"],
        "monitoringEnabled": false,
        "dataSourceProviders": [
          "bvd-mint-search",
          "farmyard.worldcheck-premium-plus-multisource",
          "dowjones-factiva-singlesource",
          "farmyard.worldcheck-premium-plus-singlesource",
          "emis-isi-singlesource",
          "farmyard.dowjones-watchlist-singlesource",
          "farmyard.dowjones-watchlist-multisource",
          "farmyard.dowjones-state-owned-companies"
        ],
        "dataSourceSettings": {
          "bvd-mint-search": { "password": "dsf324", "username": "PWCWS" },
          "dowjones-factiva-singlesource": {
            "encryptionToken": "S002H39QVBJ5DEu5DEqOTYtMpUmMD7yMHn0RtfqMGNw0rfYTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQQAA"
          }
        }
      },
      "mediaScreeningKeywordLists": [
        {
          "id": "f7e2029d1920429b928c89676c1c9280",
          "name": "English Adverse Phrase List",
          "keywords": [
            "abuse*",
            "accus*",
            "accuse",
            "alleg*",
            "arraign*"
          ]
        }
      ],
      "tenant": "blue",
      "id": "a83a503fcbad4b4e99d405bf0c5eab8b"
    },
    "userCount": 52,
    "enabledUserCount": 52
  }
|]

teamsResponseEx :: ByteString
teamsResponseEx = [r|
[
  {
    "team": {
      "name": "Blue",
      "timeZone": "Europe/London",
      "targetWorkflowSettings": {
        "pepSanctionsEnabled": false,
        "pepSanctionsSources": [],
        "adverseMediaEnabled": false
      },
      "radarClassicSettings": {
        "flags": ["Not Confirmed", "Confirmed", "Not Relevant"],
        "monitoringEnabled": false,
        "dataSourceProviders": [
          "bvd-mint-search",
          "farmyard.worldcheck-premium-plus-multisource",
          "dowjones-factiva-singlesource",
          "farmyard.worldcheck-premium-plus-singlesource",
          "emis-isi-singlesource",
          "farmyard.dowjones-watchlist-singlesource",
          "farmyard.dowjones-watchlist-multisource",
          "farmyard.dowjones-state-owned-companies"
        ],
        "dataSourceSettings": {
          "bvd-mint-search": { "password": "dsf324", "username": "PWCWS" },
          "dowjones-factiva-singlesource": {
            "encryptionToken": "S002H39QVBJ5DEu5DEqOTYtMpUmMD7yMHn0RtfqMGNw0rfYTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQQAA"
          }
        }
      },
      "mediaScreeningKeywordLists": [
        {
          "id": "f7e2029d1920429b928c89676c1c9280",
          "name": "English Adverse Phrase List",
          "keywords": [
            "abuse*",
            "accus*",
            "accuse",
            "alleg*",
            "arraign*"
          ]
        }
      ],
      "tenant": "blue",
      "id": "a83a503fcbad4b4e99d405bf0c5eab8b"
    },
    "userCount": 52,
    "enabledUserCount": 52
  }
]
|]
