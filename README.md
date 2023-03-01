# RecurrenceRelation

 - Define the subroutine named DNUM of type FAR that finds the elements of the array defined by the recurrence relation given below. Design the DNUM subroutine so that it accepts input parameters over the stack and returns values over the stack. Design the PRINTINT subroutine that prints the DNUM subroutine's return value to the console in decimals. Write the main procedure, the DNUM subroutine, the PRINTINT subroutine, in assembly language that calls the DNUM subroutine with an input value of 10.

𝐷(𝑛)={ 
                   0             ,𝑛=0
                   1             ,𝑛=1,2
        𝐷(𝐷(𝑛−1))+𝐷(𝑛−1−𝐷(𝑛−2)) ,𝑛≥3 
      }
 
 - Write the DNUM subroutine using dynamic programming in addition to the above. Test by running the DNUM subroutine with an input value of 500
