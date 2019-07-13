load "./TinyToken.rb"
load "./TinyScanner.rb"
# if the file(s) are in the same directory, you can simply precede
# the file name(s) with ./

# filename.txt below is simply the "source code"
# that you write that adheres to your grammar rules
# if it is in the same directory as this file, you can
# simply include the file name, otherwise, you will need
# to specify the entire path to the file as we did above
# to load the other ruby modules
scan = Scanner.new("input.txt")
tok = scan.nextToken()

# somewhere in here, you need logic to write your tokens to a file
# we'll use this file later in our parser
# it is enough to just list one token/lexeme pair per line in our token file
# Example: 
# id y 
# = =
# ...i

output = File.open("tokentest.txt", "w") # used stack overflow, https://stackoverflow.com/questions/2777802/how-to-write-to-file-in-ruby
scanner = Scanner.new("input.txt")
tok = scan.nextToken()

# keep "fetching" one token at a time, using your scanner
# until there are no tokens left to scan 
while (tok.get_type() != Token::EOF)

   # display the first "Token" that you scanned in the Console
   puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
   
   # You will also need to write the token to a file. 
   output.puts "#{tok.get_type()} #{tok.get_text()}"

   # get the next token available (if there is one)
   tok = scan.nextToken()
end 

# There should be one token left (see the boolean condition above)
# Go ahead and display (I did this) and print it (you do this)
puts "Lexeme: #{tok.get_type()} Token type: #{tok.get_type()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

# Tests for various tokens that print to console and token file
puts "\nVarious tests for tokens"
output.puts "\nVarious tests for tokens"
tok = Token.new(Token::LPAREN, "(")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::RPAREN, ")")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::ADDOP, "+")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::SUBOP, "-")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::MULTIOP, "*")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::DIVISOP, "/")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::WS, "/n")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::PRINT, "print")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::INT, "123")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

tok = Token.new(Token::ID, "abc")
puts "Token: #{tok.get_type()} Lexeme: #{tok.get_text()}"
output.puts "#{tok.get_type()} #{tok.get_text()}"

output.close()
