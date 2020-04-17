# ProjectEuler - Problem 37 (Truncatable primes)
## Text
> The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
>
> Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
>
> NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

## Solution
To find truncatable primes we can start from a single digit and continuously append to the the left new digits until the number we get is not a prime (e.g. `3 -> 13 -> 313` -> `3313`, `3313` is not prime, we stop to `313`).
This way we find a sequence of numbers that are left-truncatable primes, meaning that removing left digits one by one, we always get prime numbers.
When we found a left-truncatable prime we must check that it is also a right-truncatable prime (removing digits from right to left we always get prime numbers).

We can notice that the right-most digit must be a `3` or a `7` since it must surely be a prime number and it cannot be `2` or `5` since, appending a digit to the left, we will get a number divisible by `2` or `5` respectively.
Since the numbers must also be right-truncatable primes, the digits composing it cannot be `0`, `4`, `6` or `8` in fact, removing digits to the right, we will end up to an even number.
Moreover the values `2` and `5` can only be found as the left-most digit for the same reason stated above: removing right-most digits we will get a number of at least two digits divisible by `2` or `5`.

In conclusion every truncatable prime must be of the form `a_1 a_2 ... a_n` where `a_n in {3, 7}`, `a_1 in {1, 2, 3, 5, 7, 9}` and `a_i in {1, 3, 7, 9} for 1 < i < n`.

The solution uses the previous contraints to recursively find all truncatable primes. An interesting fact is tha with this method we don't have to use the information of the problem about the number of truncatable primes (11) since we can bound the search so that the algorithm will surely reach to an end.

## Usage
Simply run `truncatableprimes.jl` as a Julia script:
```
>> julia truncatableprimes.jl
```
