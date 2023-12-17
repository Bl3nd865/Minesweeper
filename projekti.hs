{- Written by Douglas Lewit of Northeastern Illinois University and Oakton Community College.
   I think Haskell is a really nice language! -}

import System.IO
import Control.Concurrent
import System.Random
import qualified Data.List 

{- Okay, this dictionary or word list is ridiculously long!  But I really enjoyed filling it up with
   random words that just popped into my neurotic, eccentric brain! I can only imagine what a professional
   clinical psychologist might say after reviewing this long list of words!!! -}
dictionary = ["Arrays", "Lists", "Vectors", "Compiler", "Interpreter", "Imperative", "Functional", "Object-Oriented",
              "Python", "Ruby", "Perl", "Java", "OCaml", "Haskell", "Racket", "Erlang", "Computers", "Robots", "Algorithms",
              "Recursion", "Looping", "Debugger", "Software", "Electronics", "Technology", "Inheritance", "Composition",
              "Encapsulation", "Encryptian", "Fortran", "Cobol", "Lisp", "Assembler", "Halloween", "Thanksgiving", "Christmas", "Birthdays",
              "Parades", "Museums", "Zoos", "Decryptian", "Coding", "Programming", "Databases", "Customers", "Students",
              "Teachers", "Professors", "Adjuncts", "Tenure", "Research", "Complexity", "Campus", "Major", "Minor", "Conditionals",
              "Assignments", "Expressions", "Algebra", "Geometry", "Trigonometry", "Calculus", "Colleges", "Universities",
              "Grades", "Projects", "Systems", "Pedagogy", "Disciplines", "Probability", "Statistics", "Actuaries", "Tables",
              "Insurance", "Companies", "Greed", "Capitalism", "Socialism", "Communism", "Simple", "Complex", "Compound", "Witches",
              "Warlocks", "Wizards", "Sorcery", "Demonology", "Demons", "Angels", "Saints", "God", "Goddess", "Religion", "Prayers",
              "Sacrifice", "Animals", "Humans", "Atheism", "Christianity", "Judaism", "Islam", "Buddhism", "Hinduism", "Shinto", "Wicca",
              "Witchcraft", "Satanism", "Santeria", "Voodoo", "Cabala", "Goetia", "Medieval", "Feudal", "Lord", "Lady", "Macbeth",
              "Shakespeare", "Derivative", "Differentiate", "Integrate", "Integral", "Exponential", "Logarithmic", "Emacs", "Vim",
              "Eclipse", "Idle", "Dinosaurs", "Monsters", "Vampire", "Werewolf", "Coyote", "Snake", "Serpent", "Straight", "Curved",
              "Heterosexual", "Homosexual", "Bisexual", "Asexual", "Sexual", "Sensuous", "Passion", "Passionate", "Redundant", "Pain",
              "Pleasure", "Contentment", "Happiness", "Sadness", "Depression", "Ecstasy", "Frightened", "Enlightened", "Illuminated",
              "Confused", "Bewildered", "Bewitched", "Befuddled", "Diabolical", "Haunted", "Devil", "Satan", "Lucifer", "Rebel", "Christ",
              "Holy", "Sacred", "Profane", "Bible", "Inspired", "Charlatan", "Fraud", "Leader", "Enthusiasm", "Discouraged", "Encouragement",
              "Anger", "Rage", "Hate", "Love", "Revenge", "Forgive", "Forgiveness", "Peace", "War", "Fertility", "Sterility", "Man", "Boy",
              "Girl", "Woman", "Male", "Female", "Positive", "Negative", "Neutral", "Magic", "Genie", "Bottle", "Fire", "Smoke", "Wind",
              "Water", "Earth", "Rain", "Thunder", "Lightning", "Storms", "Polymorphic", "Polymorphism", "Microsoft", "Apple", "Excel",
              "Pages", "Keynote", "Numbers", "Applications", "Programs", "Courses", "Classes", "Studies", "Academics", "Philosophy",
              "Asatru", "Theodism", "Odin", "Woden", "Thor", "Frigga", "Freya", "Zeus", "Hera", "Ares", "Hephaestus", "Hestia",
              "Aphrodite", "Athena", "Hercules", "Xena", "Perseus", "Poseidon", "Demeter", "Persephone", "Hades", "Apollo", "Artemis",
              "Hecate", "Hermes", "Medusa", "Dogs", "Puppies", "Funny", "Furry", "Hairy", "Hungry", "Horny", "Erection", "Orgasm",
              "Expensive", "Acceptance", "Rejection", "Stubborn", "Assertive", "Aggressive", "Hostile", "Passive", "Sick", "Healthy",
              "Strong", "Power", "Powerful", "Strength", "Robust", "Masculine", "Feminine", "Roses", "Thorns", "Carnivore", "Omnivore",
              "Herbivore", "Yoga", "Swimming", "Running", "Stretching", "Weightlifting", "Muscular", "Muscles", "Hormones",
              "Estrogen", "Testosterone", "Steroids", "Heart", "Brain", "Dumb", "Smart", "Intelligent", "Intellect", "Intellectual",
              "Scholar", "Philosopher", "Esoteric", "Arcane", "Mysterious", "Magical", "Mystery", "Enigma", "Hidden", "Occult",
              "Occultism", "Books", "Doctor", "Lawyer", "Attorney", "Judge", "Policemen", "Chef", "Prisoner", "Custodian", "Janitor",
              "Tailor", "Blacksmith", "Carpenter", "Machinist", "Mechanic", "Plumber", "Manager", "Salesman", "Accountant", "Actor",
              "Actress", "Theater", "Opera", "Ballet", "Nurse", "Hospital", "Cemetery", "Park", "Mountains", "Forests", "Oceans",
              "Macho", "Manly", "Sweaty", "Bulky", "Jock", "Athlete", "Heavy", "Iron", "Steel", "Copper", "Aluminum", "Gold", "Silver",
              "Tungsten", "Alloys", "Platinum", "Uranium", "Plutonium", "Hero", "Heroine", "Terrorists", "Zionists", "Soldiers", "Physicist", 
              "Chemist", "Biologist", "Astronomer", "Astronomy", "Geologist", "Oceanographer", "Estrogen", "Progesterone", "Welder", "Silversmith",
              "Goldsmith", "Hunter", "Farmer", "Agriculture", "Horticulture", "Nerd",
              "Nerdy", "Geek", "Greek", "Roman", "Russian", "American", "Brazilian", "Canadian", "Martian",
              "Earthling", "Egyptian", "Neanderthal", "Australian", "Aussie", "Chinese", "Japanese", "Asian",
              "Occidental", "Oriental", "Eastern", "Western", "Southern", "Northern", "Outer", "Inner", "Space",
              "Spatial", "Rodeo", "Cowboy", "Farrier", "Wrangler", "Anvil", "Hammer", "Forge", "Lathe", "Volcano",
              "Earthquake", "Eruption", "Tornado", "Cyclone", "Hurricane", "Twister", "Hydrogen", "Helium",
              "Sun", "Moon", "Stars", "Planets", "Stellar", "Planetarium", "Aquarium", "Nova", "Quasar",
              "Electron", "Proton", "Neutron", "Electricity", "Magnetism", "Gravity", "Einstein", "Brain",
              "Mendeleev", "Elements", "Elemental", "Elementals", "Fundamentals", "Automobiles", "Cars", "Trains",
              "Airplanes", "Bus", "Buses", "Travel", "Transportation", "Education", "Educated", "Student",
              "Scholar", "Aristocrat", "Autocrat", "Dictator", "King", "Queen", "Prince", "Princess", "President",
              "Pope", "Papacy", "Priest", "Priestess", "Graveyard", "Mausoleum", "Mortician", "Funeral", "Death",
              "Life", "Zombie", "Alive", "Unconscious", "Conscious", "Consciousness", "Conscience", "Ethics",
              "Morals", "Morality", "Good", "Evil", "Right", "Left", "Wrong", "Sinister"]
             

putStrLnDelayed :: String -> IO ()
putStrLnDelayed word =
  do
    threadDelay 500000
    mapM_ (\t -> do {putStr [t]; hFlush stdout; threadDelay 175000}) (word ++ "\n")

fillInLetters' :: String -> Char -> String -> String -> String 
fillInLetters' accumulator c [] _ = reverse accumulator
fillInLetters' accumulator c _ [] = reverse accumulator
fillInLetters' accumulator c (h1:t1) (h2:t2) =
  if c == h1
  then fillInLetters' (h1:accumulator) c t1 t2 
  else fillInLetters' (h2:accumulator) c t1 t2 


fillInLetters :: Char -> String -> String -> String
fillInLetters = fillInLetters' ""


{- I probably should have used a case statement for this function.
-- Look at all those if-then-else expressions!  Ouch!  Well not to worry.
   I will use case statements the next time I write a program like this.
   There is always next time, right?
-}
guessTheWord' :: String -> String -> Int -> Int -> String -> IO ()
guessTheWord' displayed_word word guesses guesses_limit accumulator =
  do 
    if guesses > guesses_limit
    then do
           putStrLn "\nSorry, you used up all of your turns!  You lose the game!!!  Hahahahaha!!!"
           putStrLn $ "The secret word is " ++ "\"" ++ word ++ "\"" ++ "." ++ "\n"
    else do
       putStrLn $ "Number of turns you have left: " ++ (show (guesses_limit - guesses + 1))
       putStrLn $ "Characters you have used so far:\t" ++ (Data.List.sort accumulator)
       putStr "Guess a letter in the word: "
       hFlush stdout
       c' <- getLine 
       if c' == ""
       then do  -- What to do if getLine returns an empty list.
          putStrLn "\nSorry, but you must enter some character.  Follow the rules buddy!!!"
          guessTheWord' displayed_word word guesses guesses_limit accumulator 
       else do  -- What to do if getLine does not return an empty list!
          let c = c' !! 0 
          putStrLn "" 
          let new_displayed_word = fillInLetters c word displayed_word  
          if new_displayed_word == word
          then do
                 putStrLnDelayed new_displayed_word
                 putStrLn "YOU GUESSED THE RIGHT WORD!  YOU WIN THE GAME MR. OR MRS. SMARTY PANTS!!!"
                 putStrLn $ "You used up " ++ (show guesses) ++ " turns to guess the word!\n"
          else do
                 putStrLnDelayed new_displayed_word
                 if elem c word
                 then do
                     putStrLn "Congratulations!  You found a letter in the word!"
                     guessTheWord' new_displayed_word word guesses guesses_limit (c : accumulator)
                 else do
                     putStrLn $ "Too bad! \"" ++ [c] ++ "\" is not a letter in the secret word!"
                     putStrLn "You have just lost a turn."
                     guessTheWord' new_displayed_word word (guesses + 1) guesses_limit (c : accumulator)


guessTheWord :: String -> IO ()
guessTheWord word =
  guessTheWord' initial_display word 1 numberOfGuesses ""
  where initial_display = ['-' | x <- word]
        -- The maximum number of guesses is slightly more than  1.5 times
        -- the number of characters in the word.  I think that's pretty fair.
        numberOfGuesses = 1 + ceiling (1.5 * fromIntegral (length word))  


main :: IO ()
main = do
  let len = length dictionary - 1
  random_integer <- randomRIO (0, len)
  let word = dictionary !! random_integer
  putStrLn $ "\nThe word you're guessing begins with a capital letter, and contains " ++ (show (length word)) ++ " letters."
  guessTheWord word