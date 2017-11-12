require 'csv'
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
	name = ask_students_name
	while !name.empty? do
		student = {name: name, cohort: "Unknown"}

		ask_students_cohort(student)

		#added code to output '1 student' when only one and 'x students' when more than one.
		print_student_count

		add_student_to_list(student)
		
		name = ask_students_name
	end
	## return the array of students
	@students
end

def ask_students_name
	if @students.count == 0
		puts "Please enter a student's name."
		puts "Or, to finish, hit 'return'"
	else
		puts "\nPlease enter the next student's name"			
		puts "Or, to finish, hit 'return'"
	end	
	name = STDIN.gets.chomp
	name
end

def ask_students_cohort(student)
	# ask for the student's cohort
	puts "What month is #{student[:name]}'s cohort."
	cohort = STDIN.gets.chomp
	
	# this loop will keep aking for a cohort until a month is given
	while !@months.include?(cohort.downcase) do
		puts "That is not a valid month. Try again."
		cohort = STDIN.gets.chomp
	end	
	student[:cohort] = cohort.capitalize.to_sym
end

def print_student_count
	if @students.count == 0
		puts "Now we have 1 student."
	else
		puts "Now we have #{@students.count+1} students."
	end	
end

def add_student_to_list(student)
	@students << student
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
			save_students_to_file
			puts "Student information saved to 'students.csv' in the current directory"
		when "4"
			load_students_from_file
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
		print_cohort_header(cohort)
		@students.each do |student|
			if student[:cohort] == cohort
				print_one_student(student)
			end
		end
	end
end

#----SAVE--AND--LOAD--METHODS----#
def save_students_to_file
	#open the file for writing
	CSV.open("students.csv", "wb") do |file|
		#iterate over the array of students
		@students.each do |student|
			file << [student[:name], student[:cohort]]
		end
	end
end

def try_load_students
	filename = ARGV.first # first argument from the command line
	if filename.nil? # use 'students.csv' if no value is given
		load_students_from_file('students.csv')
		puts "Loaded #{@students.count} students from 'students.csv'"
	elsif File.exists?(filename) # if it exists
		load_students_from_file(filename)
		puts "Loaded #{@students.count} students from #{filename}"
	else # if it doesn't exist
		puts "Sorry, #{filename} doesn't exist."
		exit # quit the program
	end
end

def load_students_from_file(filename = "students.csv")
	@students = []
	File.open(filename, "r") do |file|
		CSV.foreach(filename) do |line|
			name, cohort = line
			add_student_to_list({name: name, cohort: cohort.to_sym})
		end
	end
	@cohorts = @students.map{|x| x[:cohort]}.uniq
end

#--------OTHER---------#
def print_header
	puts "The students of Villains Academy".center(@page_width)+"\n"+
		 "--------------".center(@page_width)+"\n"
end

def print_cohort_header(cohort)
		puts "#{cohort} cohort".center(@page_width)+"\n"+
		 	 "--------------".center(@page_width)+"\n"
end

def print_one_student(student)
	puts "#{student[:name]}".ljust(30)+" | "+
		"#{student[:cohort].capitalize}".center(9)+" cohort"
end

#prints nicely formatted list of student information
def print_student_list
	@students.each do |student|
		print_one_student(student)
	end
end

#prints how many students we have altogether
def print_footer
	puts "\nOverall, we have #{@students.count} great students".center(@page_width)
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


