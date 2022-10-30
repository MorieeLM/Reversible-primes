#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

// function prototypes

int isPrime(long number);

// A Palindrome is a word, phrase or sequence that the same
// backwards as forwards e.g 131
int palindrome(long number);
long reverse_number(long integer);
int isPerfect(long num);
long double Sqrt(long double );

int main()
{
    // variable declaration and initialization

    int count = 0;
    long integer = 1; // variable to an integer
    long reversd;

    long squareRNum = 0;
    long reverse_square = 0;

    // while loop to count the number of reversible primes to be displayed

    while(count < 10)
    {

        reversd = reverse_number(integer); // reversd holds a reversed integer

        if(isPerfect(integer) == 1 && isPerfect(reversd) == 1) // if statement to check whether the integer and its reverse are perfect numbers
        {
            squareRNum = Sqrt(integer); // take the square root of the integer
            reverse_square = Sqrt(reversd); // take the square root of the reversed integer

            if(isPrime(squareRNum) == 1 && isPrime(reverse_square)==1) // if statement to check whether the integer and its reverse are prime numbers
            {
                if(palindrome(integer) == 0) // if the integer is not a palidrome
                {
                    printf("%d ",integer); // print the integer
                    printf("\n");
                    count++; //increment count
                } // end if

            } // end if
        } // end if
        integer++;
    } // end while


    return 0;
}

int isPrime(long number) // function returns 1 if the number is a prime number and 0 if not
{
	int prime;
	if(number == 0 || number == 1) // 0 and 1 are not prime numbers
	{
		prime = 0;
	}

    // for loop to check whether a number is prime
	for(long index = 2; index <= number/2; index++)
	{
		if(number % index == 0) // condition to check if number is divisible by index,
            //in which case it will not be a prime number
		{
			prime = 0;
		}
		else
            prime = 1;
	}

	if(prime == 1)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

// A Palindrome is a word, phrase or sequence that the same
// backwards as forwards e.g 131
int palindrome(long value) // function returns 1 if the number is a palindrome and 0 if not
{
    // variable declaration and initialization
    long reversed = 0, remainder, original;
    original = value;

     // while loop to check if a number is a palidrome
    while(value != 0)
    {
        remainder = value % 10;
        reversed = reversed * 10 + remainder;
        value /= 10;
    }
    if(original == reversed)
        return 1;
    else
        return 0;
}

long reverse_number(long integer) // function reverses a number
{
    long reversed = 0, remainder;
    // while loop to  reverse a number
    while(integer != 0)
    {
        remainder = integer % 10;
        reversed = reversed * 10 + remainder;
        integer /= 10;
    }
    return reversed;
}

int isPerfect(long num) // function returns 1 if the number is perfect and 0 if not
{
    int output = 0;
    // for to check if a number is a perfect number
    for(long index = 1; index * index <= num; index++ )
    {
        if((num % index == 0) && (num / index == index))
        {
            output = 1;
        }
        else
        {
            output = 0;
        }
    }
    return output;
}

long double Sqrt(long double num ) // function calculates and returns the square root of a number
{
	long double sqrt = num / 2;
    long double temp = 0;

    while (sqrt != temp)
    {
        temp = sqrt;

        sqrt = ( num / temp + temp) / 2;
     }

     return sqrt;
}
