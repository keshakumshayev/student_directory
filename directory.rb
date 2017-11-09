#first we put the list of students in an array
students = [
	{name: "Dr. Hannibal Lecter", cohort: :november},
	{name: "Darth Vader", cohort: :november},
	{name: "Nurse Ratched", cohort: :november},
	{name: "Michael Corleone", cohort: :november},
	{name: "Alex DeLarge", cohort: :november},
	{name: "The Wicked Witch of the West", cohort: :november},
	{name: "Terminator", cohort: :november},
	{name: "Freddy Krueger", cohort: :november},
	{name: "The Joker", cohort: :november},
	{name: "Joffrey Baratheon", cohort: :november},
	{name: "Norman Bates", cohort: :november}
]

def print_header
	puts "The students of Villains Academy"
	puts "--------------"
end

def print(names)
	name_count = 0
	while names[name_count] != nil # While there is an entry for the student in our array, print their info.
		puts "#{names.index(names[name_count])+1}: #{names[name_count][:name]} (#{names[name_count][:cohort]} cohort)" 
		name_count += 1
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
		students << {name: name, cohort: :november}
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
