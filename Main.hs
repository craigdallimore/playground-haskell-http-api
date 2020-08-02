module Main where

import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Data.Time.Clock

  {-
-- https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md
-- https://stackoverflow.com/questions/38853256/sessions-with-http-client

curl 'https://app.radar.pwc.com/radar/app/auth/login' \
  -H 'authority: app.radar.pwc.com' \
  -H 'accept: application/json' \
  -H 'cache: no-cache' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'origin: https://app.radar.pwc.com' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://app.radar.pwc.com/radar/' \
  -H 'accept-language: en-GB,en;q=0.9,en-US;q=0.8,fr;q=0.7,la;q=0.6,es;q=0.5' \
  --data-raw $'username=decoy9697%40gmail.com&password=Password123\u0021' \
  --compressed
-}



main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  now1 <- getCurrentTime
  request1 <- parseRequest "http://cnn.com"
  response1 <- httpLbs request1 manager

  putStrLn $ "The status code was: " ++ show ( statusCode $ responseStatus response1)
  -- print $ responseBody response

  let (jar1, _) = updateCookieJar response1 request1 now1 (createCookieJar [])
  putStrLn $ "new jar: " ++ show jar1

  req2 <- parseRequest "http://cnn.com"
  now2 <- getCurrentTime
  let (request2, jar2) = insertCookiesIntoRequest req2 jar1 now2

  response2 <- httpLbs request2 manager

  putStrLn $ "\nThe status code was: " ++ show ( statusCode $ responseStatus response2)
  -- print $ responseBody response2
