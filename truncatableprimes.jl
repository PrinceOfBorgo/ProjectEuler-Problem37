using Primes

# Appends digit a to the left of n, d must be the length of n.
function appendleft(n, a, d)
	return n + a * 10^d
end

# Returns the number obtained from n removing its right-most digit.
function removeright(n)
	return n ÷ 10
end

# Returns true if n and all the numbers obtained from n removing its right-most
# digits one by one are prime numbers, false otherwise.
function istruncright(n)
	n != 0 || return true
	isprime(n) || return false
	return istruncright(removeright(n))
end

# Pushes new truncatable primes to res vector extending n to the left. d must be
# the length of n.
function extend!(res, n, d)
	# Appending 2 or 5 to the left of n may give a truncatable prime (e.g 23 or
	# 53) by the way we cannot find other truncatable primes appending other
	# digits after 2 or 5 since, removing from right, we will get numbers of
	# at least 2 digits ending with 2 or 5 and so they will not be prime.
	for a in [2, 5]
		n1 = appendleft(n, a, d)
		if istruncright(n1)
			push!(res, n1)
		end
	end
	# Appending 1, 3, 7 or 9 to the left of n may give a truncatable prime.
	failed = false
	for a in [1, 3, 7, 9]
		n1 = appendleft(n, a, d)
		if isprime(n1)	# If new number is prime continue appending to left.
			extend!(res, n1, d+1)
		else	# Else set failed to true.
			failed = true
		end
	end
	# If failed is true this means that we found at least one value of a such
	# that the number got appending a to the left of n is not prime and so we
	# must check if n is a truncatable prime.
	if failed && d > 1 && istruncright(n)
		push!(res,n)
	end
end

# Initialize a new vector of integers to store truncatable primes.
let res = Vector{Int}()
	# Call extend! starting by 3 and 7. These are the only two values that can
	# be in the right-most position since they must be prime numbers and cannot
	# be 2 or 5 (appending a value to the left we get non-prime numbers).
	extend!(res, 3, 1)
	extend!(res, 7, 1)

	println(res)
	println()
	println("Count: ", length(res))
	println()
	println("Sum: ", sum(res))
end