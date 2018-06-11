module createHTML 
		(Link,
		createFile
		)
		where


-- type Link = (String, String, String)

-- getFirst :: Link -> String
-- getFirst (a,b,c) = a

-- getSecond :: Link -> String
-- getSecond (a,b,c) = b

-- getThird :: Link -> String
-- getThird (a,b,c) = c

type Link = (String, String)

getFirst :: Link -> String
getFirst (a,b) = a

getSecond :: Link -> String
getSecond (a,b) = b


htmlStyle = (Node "html" [] [
				Node "head" [] [
					Node "title" [] [
						Title
					]
				]
				Node "body" [] [
					-- Node ("img [src="ENSISA.jpg" height="50px" width="200px""]) []
					Node "h2" [] [
						Question
					]
					IterateAnswer [
						Node "p" [] [
							Node "a" [L "href"] [
                                LinkTarget
                            ]
						]
					]		
				]
]		

createFiles :: String -> [Link] -> String
createFiles subject link = printNode subject link


subjectFilter :: String -> [(String, a)] -> [(String, a)]
subjectFilter _ [] = []
subjectFilter subject ((a, b):liste) = if a==subject
                                     then (a,b):(subjectFilter subject liste)
                                     else subjectFilter subject liste


printNode :: String -> [Link] -> String

printNode subject link = subject
printNode subect [] = []
printNode subject ((name,_):_) = name
printNode subject ((_,target):_) = target



-- [(question, reponse | (Sujet1, question)<-Liste1, (Sujet2, réponse)<-Liste2, Sujet2 == Sujet1]