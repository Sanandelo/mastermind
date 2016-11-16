#Pc generator

class Codemaker
		attr_reader :combination

		def initialize(colors)
		@combination = Array.new(4," ") 
		@colors = colors
		end

		def generate_code
			@combination.map! do |e| 
			e = @colors[rand(1..4)]
			
			end
	end
end


class Codemaker_user
	attr_reader :combination

		def initialize(colors)
		@combination = Array.new(4," ") 
		@colors = colors
		end

		def input_valid?(inp)
				result = false
				inp.each do |val|
				result = @colors.include?(val)
			end
			result
		end

		def get_values
		puts "Print your combination with spaces"
			loop do
				result = gets.chomp
				result.downcase!
				@comb = result.split(" ")
					unless input_valid?(@comb)
						puts "Wrong values. Please input right combination"
					else 
						@combination = @comb
						puts "Thank your for your chose"
						puts " "
						break
					end
			end
	
	end
end


#Player

class Codebraker

		attr_reader :comb

	def initialize(colors)
		@colors = colors
		@comb = Array.new
	end

	def get_value
		puts "Print your combination with spaces"
		loop do
			result = gets.chomp
			result.downcase!
			@comb = result.split(" ")
				unless input_valid?(@comb)
					puts "Wrong values. Please input right combination"
				else 
					puts "Thank your for your chose"
					puts " "
					break
				end
		end
	end
			private
	def input_valid?(inp)
		result = false
		inp.each do |val|
			result = @colors.include?(val)
		end
		result
	end
end

class Codebraker_pc
	attr_reader :comb
	attr_reader :combination

	def initialize(colors)
		@combination = Array.new(4," ") 
		@colors = colors
	end

	def get_value
			combination.map! do |e| 
			e = @colors[rand(1..4)]
			end
			@comb = combination
	end

end

#Class wich show desk
class View

	def initialize(comb_user, pegs)
		@comb_user = comb_user
		@pegs = pegs
	end
	def show
		puts "Your combination: #{@comb_user}. You got #{@pegs[:black]} black pegs. You got #{@pegs[:white]} white pegs"
		puts " "
	end

end

# Main class
class Engine
	def initialize
		@i = 0
		@finish = false
		@pc_combination = []
	end

	def cheker(player_arr,pc_arr)
		result= {black: 0, white: 0}
		arr1 =[]
		arr2 =[]
		pc_arr.each_with_index do |val,ind|
			if player_arr[ind] == pc_arr[ind]
				result[:black] += 1
			else
				arr1 << player_arr[ind]
				arr2 << pc_arr[ind]		
			end
			
		end
		arr1.uniq!
		arr1.each do |val|
			if arr2.include?(val)
				result[:white] += 1
			end
		end
		result
	end


	def start
		colors = ["red","yellow","blue", "pink", "orange","green"]

		puts "Do you want to be 1.codebraker or 2.codemaker? Please put apropriate number"
		choice = gets.chomp
		if choice == "1"
			codemaker = Codemaker.new(colors)
			codemaker.generate_code
			@pc_combination = codemaker.combination
			codebraker = Codebraker.new(colors)
		elsif choice == "2"
			codemaker = Codemaker_user.new(colors)
			codemaker.get_values
			@pc_combination = codemaker.combination
			codebraker = Codebraker_pc.new(colors)
		end
			
			while @i<12 && @finish !=true	
				codebraker.get_value
				answer = codebraker.comb.dup
				pegs = cheker(answer, @pc_combination)
				view = View.new(codebraker.comb,pegs)
				view.show
				if pegs[:black] >=4
					@finish = true
					puts "You win"
					puts " "
				end
				@i += 1
			end
			if @finish == false
				puts "You lose"
				puts " "
			end
	end
end


engine = Engine.new
engine.start