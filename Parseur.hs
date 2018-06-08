import Data.List.Split


initFilter :: String -> String
initFilter ('{':xs) = xs
initFilter (_:xs) = initFilter xs

-- labelListFilter :: [String] -> [(String,String)]
-- labelListFilter x:xs = [(a,b) | a <- labelNodeFilter xs, b <- (initLabelInLabelFilter (finalLabelInLabelFilter x))]


-- replacée par myfilter }; -> mais gardée au cas ou
finalFilter :: String -> String
finalFilter list = 	if (last list) == '}' 
					then init list 
					else do finalFilter list

-- Fonctions pour l'affichage de liste de Tuple de String
formatString :: (String, String) -> String
formatString (s1,s2) = "("++s1++","++s2++")"

formatStringInList :: [(String,String)] -> [String]
formatStringInList [] = []
formatStringInList (x:xs) = (formatString x):formatStringInList xs

formatString2 :: (String, String, String) -> String
formatString2 (s1,s2,s3) = "("++s1++","++s2++","++s3++")"

formatStringInList2 :: [(String,String,String)] -> [String]
formatStringInList2 [] = []
formatStringInList2 (x:xs) = (formatString2 x):formatStringInList2 xs
	
printElements :: [String] -> IO ()
printElements = mapM_ putStrLn	
--

-- split oneOf
myFilter :: String -> String -> [String]
myFilter x y = split (condense . dropDelims $ oneOf x) y
--

arrowFilter :: [String] -> [String]
arrowFilter xs = [x |	x<-xs, arrowContain x == True]

labelFilter :: [String] -> [String]
labelFilter xs = [x |	x<-xs, arrowContain x == False && x/="" && x/="\n"]

arrowContain :: String -> Bool
arrowContain [] = False
arrowContain ('-':'>':xs) = True
arrowContain (_:xs) = arrowContain xs

-- Filtering and concat in (a,b) for label part

filter1 :: [String] -> [String]
filter1 [] = []
filter1 (x:xs) = (removeSpace (labelNodeFilter x)): filter1 xs

filter2 :: [String] -> [String]
filter2 [] = []
filter2 (x:xs) = (finalLabelInLabelFilter (initLabelInLabelFilter x)): filter2 xs

removeSpace :: String -> String
removeSpace xs = [x | x <- xs, notElem x "\n\t"]

initLabelInLabelFilter :: String -> String
initLabelInLabelFilter ('"':xs) = xs
initLabelInLabelFilter (_:xs) = initLabelInLabelFilter xs
								
finalLabelInLabelFilter :: String -> String
finalLabelInLabelFilter('"':xs) = []
finalLabelInLabelFilter (x:xs) = x:(finalLabelInLabelFilter xs)


labelNodeFilter :: String -> String
labelNodeFilter ('[':xs) = []
labelNodeFilter (x:xs) = x:(labelNodeFilter xs)

labelConcat :: [String] -> [String] -> [(String,String)]
labelConcat [] [] = []
labelConcat (_:xs) [] = []
labelConcat [] (_:ys) = []
labelConcat (x:xs) (y:ys) = (x,y):(labelConcat xs ys)

--Filtering and concat in (a,b) for linked node part

linkConcat :: [String] -> [(String,String)]
linkConcat [] = []
linkConcat (x:xs) = ((leftOfArrow ( removeSpace2 x)),(rightOfArrow ( removeSpace2 x))):linkConcat xs

removeSpace2 :: String -> String
removeSpace2 xs = [x | x<-xs, notElem x " \n\t"]

leftOfArrow :: String -> String
leftOfArrow ('-':'>':xs) = []
leftOfArrow (x:xs) = x:(leftOfArrow xs)

rightOfArrow :: String -> String
rightOfArrow ('-':'>':xs) = xs
rightOfArrow (x:xs) = rightOfArrow xs

--Editing link bewteen nodes/labels and Links

myGet :: [(String,String)] -> String -> String
myGet l x = head [b | (a,b)<-l, a==x]

analyse :: Bool -> String
analyse b =	if b==True then return 'Q'
			else do return 'R'

isQuestion :: String -> Bool
isQuestion [] = False
isQuestion ('?':xs) = True
isQuestion (_:xs) = isQuestion xs

--

main = do
-- Lecture Fichier dot 
	doc <- readFile "Qualite.dot"
-- Supression du debut du fichier dot ( graphviz { .... et de .... } et split sur ;
	let initDoc = initFilter doc
	let list = myFilter "};" initDoc
-- Separation de la liste en deux listes:
-- 	-> L'une contenant les lien inter nodes
	let linkList = arrowFilter list;
--	-> L'autre contenant les labels
	let labelListTemp = labelFilter list;
	let labelList = drop 1 labelListTemp; -- supression du edge qui etait au debut du dot
-- Recuperation des informations importantes de la liste des labels:
--	-> nodes et labels
--	-> A noter que les deux listes sont de tailles egales et nodes[1] corresponds à labels[1]
	let nodes = filter1 labelList
	let labels = filter2 labelList
-- Concatenation des deux listes en une liste de couple [(node1, label1),...,(nodeN, labelN)]
	let labelTupleList = labelConcat nodes labels
	-- let printable1 = formatStringInList labelTupleList
	-- printElements printable1
-- Recuperation d'une liste de tuple avec (a,b) <=> a -> b
	let linkTupleList = linkConcat linkList
	-- let printable2 = formatStringInList linkTupleList
	-- printElements printable2
	let finalList = [(analyse(isQuestion(myGet labelTupleList a)),myGet labelTupleList a, myGet labelTupleList b) | (a,b)<-linkTupleList]
	let printable3 = formatStringInList2 finalList
	printElements printable3
	