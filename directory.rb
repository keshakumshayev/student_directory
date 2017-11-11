
@page_width = 45 #page width parameter added for use with .center method
@students = []
@cohorts = []
@months = [
'january', 'february',
'march', 'april', 'may',
'june', 'july', 'august',
'september', 'october',
'november', 'december'
]
#INPUT STUDENT INFO
def input_students
	puts "Please enter a student's name."
	puts "Or, to finish, hit 'return'"
	# create empty array
	name = STDIN.gets.chomp
	# while the name is not empty, repeat the following:
	while !name.empty? do
		# create a student but do not write it to the array yet, we need to know their cohort
		# now i have also added an id so students print with id regardless of their index in the students array
		student = {name: name, cohort: "Unknown"}

		# ask for the student's cohort
		puts "What month is #{name}'s cohort."
		cohort = STDIN.gets.chomp
		
		# this loop will keep aking for a cohort until a month is given
		while !@months.include?(cohort.downcase) do
			puts "That is not a valid month. Try again."
			cohort = STDIN.gets.chomp
		end

		student[:cohort] = cohort.capitalize

		#added code to output '1 student' when only one and 'x students' when more than one.
		if @students.count == 0
			puts "Now we have 1 student."
		else
			puts "Now we have #{@students.count+1} students."
		end
		@students << student
		puts "\nPlease enter the next student's name"			
		puts "Or, to finish, hit 'return'"
		#get amother name from the user
		name = STDIN.gets.chomp
	end
	## return the array of students
	@students
end
#MENU
def interactive_menu
	loop do
		print_menu
		process(STDIN.gets.chomp)
	end
end
#PROCESS MENU INPUT
def process(selection)
	#do corresponding action
	case selection
		when "1"
			@students = input_students
			@cohorts = @students.map{|x| x[:cohort]}.uniq
		when "2"
			if @students.count > 0
				show_students
			else
				puts "No students are enrolled at Villains Academy"
			end
		when "3"
			save_students
			puts "Student information saved to 'students.csv' in the current directory"
		when "4"
			load_students
			puts "Student information loaded from 'students.csv' in the current directory"
		when "8"
			if @students.count > 0
				show_students_by_cohort
			else
				puts "No students are enrolled at Villains Academy"
			end
		when "9"
			exit #terminates the program
		else
			puts "I don't know what you meant, try again"
	end
end
#MENU METHODS
def print_menu
	puts "1. Input the students"
	puts "2. Show the students"  
	puts "3. Save the list to students.csv"
	puts "4. Load the list from students.csv"
	puts "8. Show the students listed by cohort"
	puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def show_students_by_cohort
	@cohorts.each do |cohort|
		puts "#{cohort} cohort".center(@page_width)
		@students.each do |student|
			if student[:cohort] == cohort
				print_student(student)
			end
		end
	end
end

#----SAVE--AND--LOAD--METHODS----#
def save_students
	#open the file for writing
	file = File.open("students.csv", "w")
	#iterate over the array of students
	@students.each do |student|
		student_data = [student[:name], student[:cohort]]
		csv_line = student_data.join(',')
		file.puts csv_line
	end
	file.close
end

def try_load_students
	filename = ARGV.first # first argument from the command line
	return if filename.nil? # get out of the method if it isn't given
	if File.exists?(filename) # if it exists
		load_students(filename)
		puts "Loaded #{@students.count} students from #{filename}"
	else # if it doesn't exist
		puts "Sorry, #{filename} doesn't exist."
		exit # quit the program
	end
end

def load_students(filename = "students.csv")
	file = File.open(filename, "r")
	file.readlines.each do |line|
		name, cohort = line.chomp.split(',')
		@students << {name: name, cohort: cohort.to_sym}
	end
	file.close
end

#--------------------------#
def print_header
	puts "The students of Villains Academy".center(@page_width)
	puts "--------------".center(@page_width)
	puts
end

def print_student(student)
	puts "#{student[:name]}".ljust(30)+" | "+
		"#{student[:cohort].capitalize}".center(9)+" cohort"
end

#prints nicely formatted list of student information
def print_student_list
	@students.each do |student|
		print_student(student)
	end
end

#prints how many students we have altogether
def print_footer
	puts
	puts "Overall, we have #{@students.count} great students".center(@page_width)
end


try_load_students

interactive_menu

#----------------------------------------------------------------
#
# INCLUDES HOBBIES, COUNTRY, AND HEIGHT, FROM A PREVIOUS EXERCISE
# 
# def print_student_old(student)
# 	puts "#{student[:id]}. #{student[:name]}".ljust(30)+" | "+
# 		"#{student[:cohort].capitalize}".center(9)+" cohort"+" | "+
# 		"Favorite activity:"+" #{student[:hobbies]}".center(13)+" | "+
# 		"Born in:"+" #{student[:country_of_birth]}".center(15)+" | "+
# 		"Height:"+"#{student[:height]}".rjust(4)+"cm."+" |"
# end


