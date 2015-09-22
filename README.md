#GHOST TERMINAL!

Ghost Terminal takes all of the excitement of the popular spelling game GHOST and allows you to play against a relentless computer in your terminal.


###Installation
You must have Ruby version 2.0 or higher

Follow these steps in your terminal:

1. Clone the GitHub repo into the desired folder with `git clone https://github.com/jgertz26/ghost.git`
2. Install the bundler gem with `gem install bundler`
3. Run `bundle install`
4. Create the words database with `createdb wordgames`
5. Create the database table and populate it with `ruby import.rb`. THIS WILL TAKE SOME TIME.  Go make a sandwich or something while you wait.

#####Run the game with the command `ruby game.rb`, exit with ctrl + C

###Here are the rules:
- Each round you will begin by entering a letter.  
- The computer will add a letter to yours and continue to spell out a word.  
- **The object of the game is to avoid completing a valid word.**  Only words with 4 or more letters are considered valid.
- The game is scored like HORSE.  If you complete a word, you will be given a G (then an H, then an O, S and T)
- First player to receive all the letters in GHOST loses tragically
- You must be creating a valid word when you add a letter or you will promptly be called for your LIES.
