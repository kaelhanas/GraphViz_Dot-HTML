module CreateHTML2 (Question, Answer, Style, createPage, myStyle) where

type Question = (String, String)
type Answer = (String, String)

-- getFirst :: Link -> String
-- getFirst (a,b) = a

-- getSecond :: Link -> String
-- getSecond (a,b) = b

data Style = Style String String String String String String String String String String deriving (Show, Eq, Read)

myStyle = (Style "<html> <head> <title>" "</title> </head> <body> <h2>" "</h2>" "<section id=relation>" "<p>" "<a href=\""  ".html\">"  "</a> </p>" "</section>" "</body> </html>")


createPage :: String -> [Question] -> [Answer] -> Style -> String
createPage subject quest ans style@(Style beginHeader endHeader endQuestion _ _ _ _ _ _ endPage) = 
	concat[beginHeader, subject, endHeader, getQuestion subject quest, endQuestion, linkSection subject ans style, endPage] 											
	
getQuestion :: String -> [Question] -> String
getQuestion _ [] = ""
getQuestion subject ((a,b):xs) = if a==subject	then b
												else getQuestion subject xs
												

linkSection :: String -> [Answer] -> Style -> String
linkSection subject ans style@(Style _ _ _ beginSection _ _ _ _ endSection _) = concat[beginSection, writeAnswer subject ans style, endSection]

writeAnswer :: String -> [Answer] -> Style -> String
writeAnswer _ [] _ = ""
writeAnswer subject ((a,b):xs) style@(Style _ _ _ _ link1 link2 link3 link4 _ _) =
	if a==subject
	then concat[link1,link2,b,link3,b,link4, writeAnswer subject xs style]
	else writeAnswer subject xs style