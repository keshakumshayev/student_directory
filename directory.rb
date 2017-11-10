#first we put the list of students in an array
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
## ABOVE IS THE ORIGINAL ARRAY NOW WE INPUT STUDENTS
## WHEN WE RUN THE PROGRAM

def print_header
	puts "The students of Villains Academy"
	puts "--------------"
end

def print(names)
	names.each do |student| # back to the .each method
		puts "#{names.index(student)+1}: #{student[:name]} |"+
			" #{student[:cohort]} cohort |"+
			"Hobbies include: #{student[:hobbies]} |"+
			"Born in: #{student[:country_of_birth]} |"+
			"#{student[:height]} tall." 
	end
end

def print_footer(names)
	puts "Overall, we have #{names.count} great students"
end

def input_students
	puts "Please enter the names of the studens"
	puts "To finish, just hit 'return' twice"
	# create empty array
	students = []
	name = gets.chomp
	# while the name is not empty, repeat the following:
	while !name.empty? do
		students << {name: name, cohort: :november, hobbies: :skydiving, country_of_birth: :UK, height: :'189cm'}
		puts "Now we have #{students.count} students"
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
