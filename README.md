<h4 align="center">

![alt text](https://github.com/TopazAvraham/IntroductionToCS-University-C-programming/blob/master/Screenshots/50.png?raw=true)
</h4>

<p align = "center">
	<font size="3">
<b>In the Assembly code assignment I implemented 3 files that manipulate Pstrings structs using designated functions.<br>
	Please read all the instructions carefully.</font><br></b>
</p>

<p align="center">
  <a href="##Introduction">Introduction</a> •
  <a href="#Screenshots">Screenshots</a> •
  <a href="#Installation">Installation</a> •
  <a href="#Author">Author</a> •
  <a href="#Support">Support</a> 

</p>

## Introduction
In this project, I created a struct called Pstring which is: <br>
<p align="left">
  <img width="200" height="150" src="https://github.com/TopazAvraham/IntroductionToCS-University-C-programming/blob/master/Screenshots/51.png?raw=true">
</p>

And implemented 3 Assembly files: <br><br>
1. run_main.s - includes implentation for run_main function which is called from main. <br>
2. pstring.s -  includes implentation for the following functions: <br>
       A: char pstrlen(Pstring* pstr)<br>
       B: Pstring* replaceChar(Pstring* pstr, char oldChar, char newChar) <br>
       C: Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j)<br>
       D: Pstring* swapCase(Pstring* pstr)<br>
       E: int pstrijcmp(Pstring* pstr1, Pstring* pstr2, char i, char j)<br>
       
3. func_select.s - includes implementation of function that receives input from the user and calls the desired function from pstring.s <br>
  
</b> <br>

## Implementation
	
The user starts by entering 4 inputs:
1. Length on the first string.
2. The first string.
3. Length on the second string.
4. The second string.

Then, using those inputs, I created 2 Pstrings. Now the user is asked to enter a number based on the function he'd like to do on those Pstrings:<br><br>

<b>Case user entered 31 -</b> using function pstrlen he receives the length of the 2 pstrings. <br><br>

<b>Case user entered 32/33 - </b>The user also input old char and new char, <br>
and then using replaceChar function, I replace in both Pstrings each instance of old char in new char.<br><br>

<b>Case user entered 35 - </b>The user also input 2 ints: i,j indexes, <br>
and then using pstrijcpy function, I copied Pstring1[i:j] = Pstring2[i:j] and printed the 2 Pstrings after copy.<br><br>

<b>Case user entered 36 -</b> In each Pstring, I replaced each big-case letter to a small-case letter and vice-versa. Then, printed the 2 Pstring after swaps. <br><br>

<b>Case user entered 37 - </b>The user also input 2 ints: i,j indexes, <br>
and then using pstrijcpy function, I compare Pstring1[i:j] = Pstring2[i:j] and print which is ASCII value bigger. <br>

*The function returns 1 if pstr1->str[i:j] is ASCII bigger then pstr2->str[i:j] <br>
*The function returns -1 if pstr2->str[i:j] is ASCII bigger then pstr1->str[i:j]<br>
*The function returns 0 if pstr1->str[i:j] is equal to pstr2->str[i:j]<br>
*The function returns -2 if i,j are not in boundaries for pstr1->str and pstr2->str<br><br>





## How To Compile & Run Code
<b>

1. Clone this repo by creating a specific folder in your computer, open terminal in this folder and run this commend:
    ```
    git clone https://github.com/TopazAvraham/Pstrings-Assembly
    ```
    Alternatively, you can just download all the files from this repo to your computer, and save them all in that specific folder

2. Open “terminal” in this specific folder.<br>
3. Run the compilation commend:
	```
    make
    ```
	
4. Run this command to run the program:
	```
    ./a.out
    ```
	
5. Now insert the inputs as explain under "Implementation" Section
	<br>
  
6. Enjoy the results.

</b>	



## Examples
	
5 <br>
hello <br>
5<br>
world<br>
31<br>
first pstring length: 5, second pstring length: 5<br>

--------------------------------------------------------------------
5<br>
hello<br>
3<br>
bye<br>
32<br>
e z<br>
old char: e, new char: z, first string: hzllo, second string: byz<br>

--------------------------------------------------------------------
5<br>
hello<br>
3<br>
bye<br>
33<br>
z a<br>
old char: z, new char: a, first string: hello, second string: bye<br>

--------------------------------------------------------------------
5<br>
hello<br>
5<br>
world<br>
35<br>
1<br>
4<br>
length: 5, string: horld length: 5, string: world<br>

--------------------------------------------------------------------

5<br>
He@lo<br>
5<br>
WORLD<br>
36<br>
length: 5, string: hE@LO length: 5, string: world<br>

--------------------------------------------------------------------

5<br>
hello<br>
5<br>
world<br>
37<br>
1<br>
10<br>
invalid input!<br>
compare result: -2<br>

--------------------------------------------------------------------
5<br>
hello<br>
5<br>
world<br>
99<br>
invalid option!<br>

--------------------------------------------------------------------
<br><br>

## Built With

- Assembly- x86-64 GNU assembler

<br />

## Author

**Topaz Avraham**

- [Profile](https://github.com/TopazAvraham?tab=repositories )
- [Email](mailto:topazavraham9@gmail.com?subject=Hi "Hi!")
- [LinkedIn](https://www.linkedin.com/in/topaz-avraham-68b340208/ "Welcome")

## 🤝 Support

Contributions, issues, and feature requests are welcome!

Give a ⭐️ if you like this project!

