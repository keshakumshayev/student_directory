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

def print_student(student)
	puts "#{student[:id]}. #{student[:name]}".ljust(30)+" | "+
		"#{student[:cohort].capitalize}".center(9)+" cohort"+" | "+
		"Favorite activity:"+" #{student[:hobbies]}".center(13)+" | "+
		"Born in:"+" #{student[:country_of_birth]}".center(15)+" | "+
		"Height:"+"#{student[:height]}".rjust(4)+"cm."+" |"
end

def print(students)
	students.each do |student| # NOW FORMATTED TO LOOK NICE using .center and .ljust / .rjust
		print_student(student)
	end
end

def print_footer(students)
	puts
	puts "Overall, we have #{students.count} great students".center(@page_width)
end

###    Changed .chomp to .strip   ###

def input_students
	puts "Please enter a student's name."
	puts "Or, to finish, hit 'return'"
	# create empty array
	students = []
	name = gets.strip
	# while the name is not empty, repeat the following:
	while !name.empty? do
		# create a student but do not write it to the array yet, we need to know their cohort
		# now i have also added an id so students print with id regardless of their index in the students array
		student = {id: students.count+1, name: name, cohort: "Unknown", hobbies: :skydiving, country_of_birth: :UK, height: :'189'}

		# ask for the student's cohort
		puts "What month is #{name}'s cohort."
		cohort = gets.strip
		
		# this loop will keep aking for a cohort until a month is given
		while !@months.include?(cohort.downcase) do
			puts "That is not a valid month. Try again."
			cohort = gets.strip
		end

		student[:cohort] = cohort.capitalize

		#added code to output '1 student' when only one and 'x students' when more than one.
		if students.count == 0
			puts "Now we have 1 student."
		else
			puts "Now we have #{students.count+1} students."
		end
		students << student
		puts
		puts "Please enter the next student's name"			
		puts "Or, to finish, hit 'return'"
		#get amother name from the user
		name = gets.strip
	end
	## return the array of students
	students
end

def interactive_menu
	students = []
	loop do
		#print menu and ask for choice
		puts "1. Input the students"
		puts "2. Show the students"
		puts "3. Show the students listed by cohort"
		puts "9. Exit"
		#read input and save to a variable
		selection = gets.chomp
		#do corresponding action
		case selection
			when "1"
				students = input_students
			when "2"
				print_header
				print(students)
				print_footer(students)
			when "3"
				cohorts.each do |cohort|
					puts "#{cohort} cohort".center(@page_width)
					students.each do |student|
						if student[:cohort] == cohort
							print_student(student)
						end
					end
				end
			when "9"
				exit #terminates the program
			else
				puts "I don't know what you meant, try again"
		end
	end
end
#nothing happens until we call the methods
#first we input the students and their respective cohorts
students = input_students
#then we create a list of all unique cohorts
cohorts = students.map{|x| x[:cohort]}.uniq

if students.count > 0
	print_header

	#the following code prints out the students separated by cohort.
	cohorts.each do |cohort|
		puts "#{cohort} cohort".center(@page_width)
		students.each do |student|
			if student[:cohort] == cohort
				print_student(student)
			end
		end
	end
	print_footer(students)
else
	puts "No students are enrolled at Villains Academy"
end