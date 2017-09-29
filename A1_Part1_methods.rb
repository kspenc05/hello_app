#Purpose: make an array of all possible prime numbers from 0 -> max number
#         given to the function, as well as order of array elements.
#Arguments: the max number, and the order specified, which is ":ascending",
#         or ":descending", if neither function will assume ascending.
#Returns: the array of prime numbers in ascending or descending order, as 
#         determined by the second argument.
#         On failure, returns an empty array
def prime(n, order = ":ascending")
    total_primes = []
    
    i = 1
    until (i = i + 2) > n do
        j = 0
        while((prime = total_primes[j]) != nil && i % prime > 0) do
            j = j + 1
        end
        
        if(prime == nil)
            total_primes.push(i)
        end
    end
    
    #since ":ascending" has an 'a' at the 2nd pos, and ":descending" does not
    return order[1..1] != 'a'? total_primes.sort(){ |x,y| y<=> x} : total_primes
end

#Purpose: Records each word found in the given string and its frequency
#         and stores that word and its frequency into a hash table.
#Arguments: The string to search for words in
#Returns: A hash table with each word found in the string and its frequency. 
#         If there are no words, returns an empty hash table
def word_freq(string)
    words = string.gsub(/[".,:;!?", " "]/, ' ').split
    table = Hash.new
    
    for i in 0..words.size - 1 do
        freq = 1
        for j in 0..words.size - 1 do
            
            #count all matches regardless of case
            if(words[i].casecmp(words[j]) == 0 && i != j)
                freq = freq + 1     
            end
        end
        
        #check if the same word is already in the table before adding it
        #ignoring case
        is_duplicate = 0
        table.each do |key, id|
            if(key.casecmp(words[i]) == 0)
                is_duplicate = 1
            end
        end
        
        #if it is not in the table already, add it in 
        if(is_duplicate == 0)
            table[words[i]] = freq
        end
    end
    return table
end

#Purpose: A simple testing function I wrote to check output.
#Arguments: The name of the test, the expected output, and its received output.
def run_test (test_name, expected, received)
    
    puts "------------------------------------------------------------------"
    puts "Runnning test: " + test_name +
        "\nExpected: " + expected.to_s + " \nReceived: " + received.to_s 
    
    puts "\n"
    puts (expected == received) ? 
        "Passed: " + test_name : "Failed: " + test_name
    puts "-----------------------------------------------------------------\n\n"
end

#Purpose: tests the function prime().
def test_prime
    run_test("Test #1: Nominal case, with the number 50", 
        [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47],
        prime(50))
    
    run_test("Test #2: Number 30, and :ascending is given as optional variable",
        [3, 5, 7, 11, 13, 17, 19, 23, 29],
        prime(30, ":ascending"))
    
    run_test("Test #3: Number 30, and optional variable is set to :descending",
        [29, 23, 19, 17, 13, 11, 7, 5, 3],
        prime(30, ":descending"))
    
    run_test("Test #4: Number 13 is given", [3, 5, 7, 11, 13], prime(13))
    run_test("Test #5 Number 4 is given", [3], prime(4))
    run_test("Test #6: Number zero is given", [], prime(0))
end

#Purpose: tests the function word_freq().
def test_freq
    run_test("Test #1: Multiple Punctuation With the string: " +
        "\"Here\'s the !?;::::f.f;;P?;?!!K!..?...hhg?\"",
        "{\"Here\'s\"=>1, \"the\"=>1, \"f\"=>2, \"P\"=>1, \"K\"=>1, \"hhg\"=>1}",
        word_freq("Here\'s the !?;::::f.f;;P?;?!!K!..?...hhg?").to_s)
    
    run_test("Test #2: Some punctuation With the string: " + 
        "\"There was a guy. He lived a long time! He was cool?\"",
        "{\"There\"=>1, \"was\"=>2, \"a\"=>2, \"guy\"=>1, " +
        "\"He\"=>2, \"lived\"=>1, \"long\"=>1, \"time\"=>1, \"cool\"=>1}",
        
        word_freq("There was a guy. He lived a long time! He was cool?").to_s)

    run_test("Test #3: No punctuation with the string: " +
        "\"There is nothing to change in here\"",
        "{\"There\"=>1, \"is\"=>1, \"nothing\"=>1, \"to\"=>1, " +
        "\"change\"=>1, \"in\"=>1, \"here\"=>1}", 
        
        word_freq("There is nothing to change in here").to_s)
    
    run_test("Test #4: One word with the string: \"Here\"", "{\"Here\"=>1}",
        word_freq("Here").to_s)

    run_test("Test #5: same word many times, different cases with the string: " +
        "\"This THIS this ThIS THis\"", 
        "{\"This\"=>5}", word_freq("This THIS this ThIS THis").to_s)
        
    run_test("Test #6: same word many times, same case with the string: " +
        "\"THIS THIS gross THIS THIS gross\"",
        "{\"THIS\"=>4, \"gross\"=>2}", 
        word_freq("THIS THIS gross THIS THIS gross").to_s)
    
    run_test("Test #7: Empty string: ", "{}", word_freq("").to_s)
    
    run_test("Test #8: No words, just punctuation with string: " +
        "\"????!!!!....,.!?,,,,;;;;::::\"", "{}",
        word_freq("????!!!!....,.!?,,,,;;;;::::").to_s)
end