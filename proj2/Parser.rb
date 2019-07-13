# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
#
#  "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Parser Class
#
load "Token.rb"
load "Scanner.rb"
class Parser < Scanner
	@@error_total = 0 # got help here http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/

	def initialize(filename)
    	super(filename)
    	consume()
   	end
   	
	def consume()
      	@lookahead = nextToken()
      	while(@lookahead.type == Token::WS)
        	@lookahead = nextToken()
      	end
   	end
  	
	def match(dtype)
      	if (@lookahead.type != dtype)
		begin # got help here https://stackoverflow.com/questions/14587700/how-to-make-script-continues-to-run-after-raise-statement-in-ruby
         		raise "Expected #{dtype} found #{@lookahead.text}"
		rescue => error
			puts error.message
		end
		@@error_total = @@error_total + 1
      	end
      	consume()
   	end
   	
	# "Might" need to modify this. Errors?
	def program()
	consume() # added this
      	while( @lookahead.type != Token::EOF)
        	puts "Entering STMT Rule"
			statement()  
      	end
	puts "There were " + @@error_total.to_s + " parse errors" #got help here https://www.ruby-forum.com/t/newbie-convert-integer-to-string-in-ruby/91550
   	end

	def statement()
		if (@lookahead.type == Token::PRINT)
			puts "Found PRINT Token: #{@lookahead.text}"
			match(Token::PRINT)
			# puts "Entering EXP Rule"
			exp()
		else
			puts "Entering ASSGN Rule"
			assign()
			puts "Exiting ASSGN Rule"   # added this
		end
		
		puts "Exiting STMT Rule"
	end

	def assign()
		id_rule()
		if (@lookahead.type == Token::ASSGN)
			puts "Found ASSGN Token: #{@lookahead.text}"
		end
		match(Token::ASSGN)
		exp()
	end

	def exp()
		# enter term, then factor rules
		# if (, enter new expression
		# try to find factor
		# if next is * or /, continue, else end factor rule
		# if next is + or -, end term rule
		# if ), end expr rule
		puts "Entering EXPR Rule"
		term()
		puts "Exiting EXPR Rule"
		if (@lookahead.type == Token::RPAREN)
			puts "Found RPAREN Token: #{@lookahead.text}"
			consume()
		end
	end

	def term()
		puts "Entering Term Rule"
		factor()
		puts "Exiting Term Rule"
		# etail here to check if end of expression
		puts "Entering ETAIL Rule"
		etail()
		puts "Exiting ETAIL Rule"
	end

	def id_rule()
		puts "Entering ID Rule"
		if (@lookahead.type == Token::ID)
			puts "Found ID Token: #{@lookahead.text}"
		end
		match(Token::ID)
		puts "Exiting ID Rule"
	end

	def factor()
		puts "Entering Factor Rule"
		if (@lookahead.type == Token::ID)
                        puts "Found ID Token: #{@lookahead.text}"
			consume()
		elsif (@lookahead.type == Token::INT)
			puts "Found INT Token: #{@lookahead.text}"
			consume()
		elsif (@lookahead.type == Token::LPAREN)
			puts "Found LPARENT Token: #{@lookahead.text}"
			consume()
			exp()
		else
			puts "Expected to see (, INT, or ID Token. Instead found #{@lookahead.type}"
			@@error_total = @@error_total + 1
			consume()
		end
		puts "Exiting Factor Rule"

		# put ttail here
		puts "Entering TTAIL Rule"
		ttail()
		puts "Exiting TTAIL Rule"
	end

	# checks if next is * or /, end term if not	
	def ttail()
		if (@lookahead.type == Token::MULTOP)
			puts "Found MULTOP Token: #{@lookahead.text}"
			consume()
			factor()
		elsif (@lookahead.type == Token::DIVOP)
                        puts "Found DIVOP Token: #{@lookahead.text}"
                        consume()
			factor()
		else
			puts "Could not find MULTOP or DIVOP, choosing EPSILON production"
		end
	end
	
	# checks if next term is + or -, end expr if not
	def etail()
		if (@lookahead.type == Token::ADDOP)
                        puts "Found ADDOP Token: #{@lookahead.text}"
                        consume()
                        term()
                elsif (@lookahead.type == Token::SUBOP)
                        puts "Found SUBOP Token: #{@lookahead.text}"
                        consume()
                        term()
                else
                        puts "Could not find ADDOP or SUBOP, choosing EPSILON production"
                end
	end
end
