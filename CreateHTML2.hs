module CreateHTML2 (Link, Style, createFile) where

type Link = (String, String)

getFirst :: Link -> String
getFirst (a,b) = a

getSecond :: Link -> String
getSecond (a,b) = b

data Style = Style String String String String String String String String String String deriving (Show, Eq, Read)

_style = (Style "<html> <head> <title>" "</title> </head> <body> <h2>" "</h2>" "<section id=relation>" "<p>" "<a href=\""  ".html\">"  "</a> </p>" "</section>" "</body> </html>")

createFile :: String -> [Link] -> Style -> String
createFile subject link style = creationFile subject link _style

creationFile :: String -> [Link] -> Style -> String
creationFile subject link (style@(Style beginPage endHead endSubject _ _ _ _ _ _ endPage)) = concat [beginPage, subject, endHead, endSubject, endPage]

sectionLink :: String -> [Link] -> Style -> String
sectionLink subject link _style = section (createLink subject link _style) _style
        where section [] _ = []
              section links (Style _ _ _ sectionBegin _ _ _ _ sectionEnd _) = concat [sectionBegin,links,sectionEnd]

createLink :: String -> [Link] -> Style -> String
createLink _ [] _= ""
createLink subject ((a,b):xs) style@(Style _ _ _ _ _ tag1 tag2 tag3 _ _ )= if a==subject 
                                                                        then concat [b,tag1,b,tag2,tag3, createLink subject xs _style]
                                                                        else createLink subject xs style

