# first we put the list of students in an array
# students = [
# 	{name: "Dr. Hannibal Lecter", cohort: :november},
# 	{name: "Darth Vader", cohort: :november},
# 	{name: "Nurse Ratched", cohort: :november},
# 	{name: "Michael Corleone", cohort: :november},
# 	{name: "Alex DeLarge", cohort: :november},
# 	{name: "The Wicked Witch of the West", cohort: :november},
# 	{name: "Terminator", cohort: :november},
# 	{name: "Freddy Krueger", cohort: :november},
# 	{name: "The Joker", cohort: :november},
# 	{name: "Joffrey Baratheon", cohort: :november},
# 	{name: "Norman Bates", cohort: :november}
# ]
# # ABOVE IS THE ORIGINAL ARRAY, NOW WE INPUT STUDENTS
# # WHEN WE RUN THE PROGRAM'


@page_width = 125 #page width parameter added for use with .center method

@months = [
'january', 'february',
'march', 'april', 'may',
'june', 'july', 'august',
'september', 'october',
'november', 'december'
]

def print_header
	puts "The students of Villains Academy".center(@page_width)
	puts "--------------".center(@page_width)
	puts
end

def print(names)
	names.each do |student| # NOW FORMATTED TO LOOK NICE using .center and .ljust / .rjust
		puts "#{names.index(student)+1}: #{student[:name]}".ljust(30)+" |"+
			"#{student[:cohort].capitalize}".center(9)+" cohort"+" | "+
			"Favorite activity:"+" #{student[:hobbies]}".center(13)+" | "+
			"Born in:"+" #{student[:country_of_birth]}".center(15)+" | "+
			"Height:"+"#{student[:height]}".rjust(4)+"cm."+" |"
	end
end

def print_footer(names)
	puts
	puts "Overall, we have #{names.count} great students".center(@page_width)
end

def input_students
	puts "Please enter a student's name."
	# create empty array
	students = []
	name = gets.chomp
	# while the name is not empty, repeat the following:
	while !name.empty? do
		# create a student but do not write it to the array yet, we need to know their cohort
		student = {name: name, cohort: "Unknown", hobbies: :skydiving, country_of_birth: :UK, height: :'189'}
		puts "Now we have #{students.count+1} students"

		# ask for the student's cohort
		puts "What month is #{name}'s cohort."
		cohort = gets.chomp
		
		# this loop will keep aking for a cohort until a month is given
		while !@months.include?(cohort.downcase) do
			puts "That is not a valid month. Try again."
			cohort = gets.chomp
		end

		student[:cohort] = cohort.capitalize
	
		students << student
		puts "Please enter the next student's name"			
		puts "Or, to finish, hit 'return'"
		#get amother name from the user
		name = gets.chomp
	end
	## return the array of students
	students
end

#nothing happens until we call the methods
students = input_students

print_header
print(students)
print_footer(students)
