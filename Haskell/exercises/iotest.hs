-- biblioteca para números pseudo-aleatórios
import System.Random(randomRIO)


-- função para interações do jogo
jogo :: Int -> Int -> IO()
jogo num cont = do
    putStrLn "Tentativa?"
    str <- getLine
    let t = read str
    if t < num
        then do 
            putStrLn "O Numero é maior que o seu!"
            jogo num (cont + 1)
        else if t > num 
            then do 
                putStrLn "O Numero é menor que o seu!"
                jogo num (cont + 1)
            else do
                putStr( "Acertou na "++ show t ++"º tentativa!")



-- ponto de entrada do programa
inicio :: IO ()
inicio = do
num <- randomRIO (1,1000) -- escolher um número
jogo num 1 -- começar o jogo; contagem = 1
