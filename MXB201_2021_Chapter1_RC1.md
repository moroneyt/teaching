# MXB201 Chapter 1: Fundamental concepts in linear algebra


Professor Tim Moroney




Queensland University of Technology




2021


# 1.1 Introduction


If there is one subject that reaches across more of modern mathematical practice than any other, it is surely linear algebra.  Whether it's cranking out solutions to large-scale optimisation problems, high-performance simulations in scientific computing applications, uncovering statistical relationships in enormous data sets, or learning complex rules in a deep neural network, linear algebra is at the heart of it.




You already have a foundational understanding of important linear algebra concepts from your studies in MXB106.  In this unit, we will be greatly expanding our knowledge and widening the scope of problems that are within the reach of linear algebra techniques.




To begin with, in this chapter we will review many of the fundamental concepts in linear algebra, and possibly discover some interesting new facts along the way.  Our approach will be to analyse some progressively more "difficult", but in fact progressively more *interesting*, matrices.




These lecture notes are written in MATLAB Live Scripts.  They can be viewed in two ways:



   -  In MATLAB, by opening the .MLX file.  These are then in a sense, *interactive* lecture notes: you can edit or add to the code provided, experiment with the examples, change things, explore the effects, and so on.  Or, you can take the code as a starting point to develop your own ideas. 
   -  On the web, by loading the .HTML file.  This has the advantage that the videos embed in the document, and it's portable (read and watch on your mobile, or whatever).  In that case you might like to have a copy of MATLAB open on the side to play around with the ideas while you're learning.  It's always best to participate in the process, rather than simply passively consume the content -- you'll learn much better that way! 

# 1.2 Square, nonsingular matrix


We'll start our investigation with the simplest case of all: a square, nonsingular matrix.  Although you should pretend for the moment that you don't know whether it's nonsingular yet: that will be one of the first things we will verify.




In this chapter, we will use MATLAB's *symbolic* arithmetic.  This will enable us to focus on the theoretical issues under consideration.  (In later chapters, we will sometimes use floating point arithmetic.)



```matlab:Code
clear
n = 3;
A = sym([3 2 4 ; 4 1 2 ; 2 0 3]) % note the "sym" for a symbolic matrix
```

A = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;4&space;&&space;1&space;&&space;2\\&space;2&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>
## 1.2.1 Reduction to row echelon form


First, let's revise how we perform row reduction using type 3 row operations by hand.




[Video](https://web.microsoftstream.com/video/572fa237-be35-40b9-8fc3-2a3c04d7800f)


### Exercise


On a piece of paper, perform this same sequence of row operations yourself by hand.  Don't refer to back to the example video unless you really get stuck.▫




Having done the work yourself by hand, you might agree that it would be preferable for the computer to do this tedious work for you as much as possible in the future.  In fact, in the Real World™ *nobody* does row operations by hand.  Why would you, when computers are many, many, many *orders of magnitude *faster and better at it than we are?




So it's important to learn how to do things programatically -- that is, by writing code.  In this unit, we'll work our examples side-by-side on paper, and in MATLAB.  We do them on paper first to get the idea straight in our head.  Then we do them in MATLAB so we never have to do them by hand ever again!




So, let's see how to apply the same sequence of type 3 row operations in MATLAB.



```matlab:Code
R = A; % make a copy, so we don't overwrite the original matrix
R(2,:) = R(2,:) - R(2,1)/R(1,1) * R(1,:) % syntax is reminiscent of how we would write it by hand
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;2&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>

```matlab:Code
R(3,:) = R(3,:) - R(3,1)/R(1,1) * R(1,:)
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;-\frac{4}{3}&space;&&space;\frac{1}{3}&space;\end{array}\right)"/>

```matlab:Code
R(3,:) = R(3,:) - R(3,2)/R(2,2) * R(2,:)
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>
### Exercise


In a (separate) MATLAB editor tab, perform this same sequence of row operations yourself.  Don't refer to back to the example code unless you really get stuck.▫


## 1.2.2 Row rank


Now that we have our echelon form, what information can we learn from it?




[Video](https://web.microsoftstream.com/video/8837ae6d-6afc-490f-b131-a3bb678699f9)




So the row echelon form reveals that this matrix is nonsingular.  Here's the argument summarised:



   -  Type 3 row operations replace a row with a linear combination of itself and another row. 
   -  Hence, the *span* of the row vectors is unchanged by these row operations. 
   -  Hence, the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> is the *same space* as the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> (just expressed in terms of different vectors). 
   -  From the structure of the zeros in the echelon form, it is clear that no row in the eliminated matrix can be expressed linearly in terms of the others. 
   -  Hence all rows of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> are linearly independent. 
   -  Hence the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/>, which is the same as the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> remember, has dimension 3. 
   -  Hence <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> has *rank* of 3 (recall the *rank* is the dimension of the row space). 



Furthermore, we can readily calculate the determinant of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> from this echelon form.  Since we used only type 3 row operations, which don't alter the determinant, the determinant of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> is the determinant of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.



```matlab:Code
prod(diag(R)) % determinant of a triangular matrix is the product of the diagonal elements
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;-15"/>

```matlab:Code
isequal(ans, det(A)) % let's confirm this equals det(A)
```


```text:Output
ans =    1
```



The determinant is nonzero for a nonsingular matrix.


## 1.2.3 Solving a linear system


We could also use this echelon form to solve a linear system of equations <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.




First, let's revise how we perform row reduction with an *augmented *matrix, followed by backward substitution, by hand.




[Video](https://web.microsoftstream.com/video/1ba46a88-8a9e-4a58-8d50-54ce7c6b0a4a)


### Exercise


On a piece of paper, apply this same process to solve the same linear system yourself.  Don't refer to back to the example video unless you really get stuck.▫




Now we'll do it in MATLAB.



```matlab:Code
b = sym([5; 0; 7]) % the right hand side vector
```

b = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;5\\&space;0\\&space;7&space;\end{array}\right)"/>


Typically we would augment the matrix and right hand side first:



<img src="https://latex.codecogs.com/gif.latex?[A~b]"/>



and apply the row operations to reduce the augmented system to



<img src="https://latex.codecogs.com/gif.latex?[R~z]"/>



from which point we could apply backward substitution to easily find <img src="https://latex.codecogs.com/gif.latex?\inline&space;x"/>.




Like so:



```matlab:Code
R_z = [A b] % augment the matrix and right hand side
```

R_z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;3&space;&&space;2&space;&&space;4&space;&&space;5\\&space;4&space;&&space;1&space;&&space;2&space;&&space;0\\&space;2&space;&&space;0&space;&&space;3&space;&&space;7&space;\end{array}\right)"/>

```matlab:Code
R_z(2,:) = R_z(2,:) - R_z(2,1)/R_z(1,1) * R_z(1,:) % same row operations as previously
```

R_z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;3&space;&&space;2&space;&&space;4&space;&&space;5\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}&space;&&space;-\frac{20}{3}\\&space;2&space;&&space;0&space;&&space;3&space;&&space;7&space;\end{array}\right)"/>

```matlab:Code
R_z(3,:) = R_z(3,:) - R_z(3,1)/R_z(1,1) * R_z(1,:) % same row operations as previously
```

R_z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;3&space;&&space;2&space;&&space;4&space;&&space;5\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}&space;&&space;-\frac{20}{3}\\&space;0&space;&&space;-\frac{4}{3}&space;&&space;\frac{1}{3}&space;&&space;\frac{11}{3}&space;\end{array}\right)"/>

```matlab:Code
R_z(3,:) = R_z(3,:) - R_z(3,2)/R_z(2,2) * R_z(2,:) % same row operations as previously
```

R_z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;3&space;&&space;2&space;&&space;4&space;&&space;5\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}&space;&&space;-\frac{20}{3}\\&space;0&space;&&space;0&space;&&space;3&space;&&space;9&space;\end{array}\right)"/>

```matlab:Code
R = R_z(:, 1:n), z = R_z(:, n+1) % pull out the "R" part and the "z" part separately
```

R = 

   $$ \left(\begin{array}{ccc}
3 & 2 & 4\\
0 & -\frac{5}{3} & -\frac{10}{3}\\
0 & 0 & 3
\end{array}\right)$
z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;5\\&space;-\frac{20}{3}\\&space;9&space;\end{array}\right)"/>

```matlab:Code
x = R \ z  % MATLAB solves by substitution when you backslash a triangular matrix
```

x = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-1\\&space;-2\\&space;3&space;\end{array}\right)"/>
### Exercise


In a (separate) MATLAB editor tab, perform this same sequence of row operations yourself, and the substitution step.  Don't refer to back to the example code unless you really get stuck.▫




Notice how you're duplicating your work here!  (I don't mean by doing things by hand first, and then in MATLAB again -- that's good practice.)  I mean that we already applied all these row operations once already to <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>, but now we're applying them all over again to the augmented matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;[A|b]"/>.  If only we had a convenient mechanism for *recording* the row operations we used in the first place, so that we could essentially *replay* those same operations applied to just <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.  How might we go about recording the sequence of row operations we used in a convenient form?


## 1.2.4 Elementary matrices


To record the sequence of row operations applied, we can use *elementary matrices*: these are identity matrices that have had the relevant row operation performed on them.




[Video](https://web.microsoftstream.com/video/e5eee5f2-455e-4639-b481-3eb57878e04a)




Let's set up what we need in MATLAB.



```matlab:Code
I = sym(eye(n)) % identity matrix will come in handy
```

I = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
R = A % we will apply row operations progressively to this matrix R
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;4&space;&&space;1&space;&&space;2\\&space;2&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>


The first row operation we want to perform on <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> is \texttt{R(2,:) = R(2,:) - R(2,1)/R(1,1) * R(1,:)}




Instead of applying that operation directly to <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/>, we instead apply it to <img src="https://latex.codecogs.com/gif.latex?\inline&space;I"/> to produce a matrix we'll call <img src="https://latex.codecogs.com/gif.latex?\inline&space;E_1"/>.



```matlab:Code
E1 = I;
E1(2,:) = E1(2,:) - R(2,1)/R(1,1) * E1(1,:) % apply the row operation to I to get E1
```

E1 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;-\frac{4}{3}&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>


This *elementary matrix* <img src="https://latex.codecogs.com/gif.latex?\inline&space;E_1"/> encodes the row operation we intend to apply to <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/>.  We can apply the row operation to <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> by pre-multiplying  by <img src="https://latex.codecogs.com/gif.latex?\inline&space;E_1"/>.  [Anton 1.5]



```matlab:Code
R = E1 * R
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;2&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>


We can repeat this process for the remaining two row operations.



```matlab:Code
% R(3,:) = R(3,:) - R(3,1)/R(1,1) * R(1,:)
E2 = I; E2(3,:) = E2(3,:) - R(3,1)/R(1,1) * E2(1,:)
```

E2 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;-\frac{2}{3}&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
R = E2 * R
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;-\frac{4}{3}&space;&&space;\frac{1}{3}&space;\end{array}\right)"/>

```matlab:Code
% R(3,:) = R(3,:) - R(3,2)/R(2,2) * R(2,:)
E3 = I; E3(3,:) = E3(3,:) - R(3,2)/R(2,2) * E3(2,:)
```

E3 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;-\frac{4}{5}&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
R = E3 * R
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>


Now that we have the row operations recorded in the form of elementary matrices, we can easily replay them again at any time.  Here's the full sequence replayed again:



```matlab:Code
E3 * E2 * E1 * A
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, R)  % yep, that's equal to our row echelon form
```


```text:Output
ans =    1
```



Clearly we can parcel this sequence of elementary matrices all up into a single matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/>.  We'll call <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> the *elimination matrix*.



```matlab:Code
E = E3 * E2 * E1
```

E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;-\frac{4}{3}&space;&&space;1&space;&&space;0\\&space;\frac{2}{5}&space;&&space;-\frac{4}{5}&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
isequal(R, E*A)  % the elimination matrix E applied to A produces R
```


```text:Output
ans =    1
```



Note that <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> is *not *an elementary matrix; that term is reserved for a single row operation applied to the identity, not a sequence of two or more.




Using this elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/>, we can easily solve a linear system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>



```matlab:Code
z = E * b  % apply elimination matrix to b (i.e. apply the row operations to b)
```

z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;5\\&space;-\frac{20}{3}\\&space;9&space;\end{array}\right)"/>

```matlab:Code
x = R \ z  % solve by back substitution
```

x = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-1\\&space;-2\\&space;3&space;\end{array}\right)"/>

```matlab:Code
isequal(A*x, b)  % yep, A*x equals b
```


```text:Output
ans =    1
```



Observe that the vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;z"/> we obtained is the same as we had earlier when we applied row operations to the augmented matrix.  But notice how easy it is now to change our mind and solve for a *different* <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>: we could just replay the operations to the new <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.  Or even solve for a new right hand side <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> that wasn't available when we performed the elimination on <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Saving the row operations in an elimination matrix gives you more options.


### Exercise


In a (separate) MATLAB editor tab, build this same sequence of elementary matrices yourself, compute the elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/>, and use it to solve <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  Don't refer to back to the example code unless you really get stuck.▫


## **1.2.5 Relation to LU decomposition**


**ASIDE**




If you have studied computational linear algebra, you might be wondering how this idea relates to the LU decomposition of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Glad you asked!




The LU decomposition returns a unit lower triangular matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;L"/> and an upper triangular matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;U"/> such that <img src="https://latex.codecogs.com/gif.latex?\inline&space;A=LU"/>.



```matlab:Code
[L,U] = lu(A)
```

L = 

   $$ \left(\begin{array}{ccc}
1 & 0 & 0\\
\frac{4}{3} & 1 & 0\\
\frac{2}{3} & \frac{4}{5} & 1
\end{array}\right)$
U = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>

```matlab:Code
isequal(A, L*U)
```


```text:Output
ans =    1
```



  In fact, <img src="https://latex.codecogs.com/gif.latex?\inline&space;U"/> is simply our row echelon form <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/>.



```matlab:Code
isequal(U, R)
```


```text:Output
ans =    1
```



Since we know that simultaneously <img src="https://latex.codecogs.com/gif.latex?\inline&space;R=EA"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;A=LU"/>, it must be that <img src="https://latex.codecogs.com/gif.latex?\inline&space;L=E^{-1}"/>.



```matlab:Code
inv(E)
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;\frac{4}{3}&space;&&space;1&space;&&space;0\\&space;\frac{2}{3}&space;&&space;\frac{4}{5}&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, L)
```


```text:Output
ans =    1
```



So the LU decomposition is based on the same idea of recording the row operations in a matrix, just from a slightly different point of view.




**END ASIDE**




Before we move on, it's worth thinking about how best to actually build this elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> in the computer.  You did it the "hard way" yourself earlier, but here's a nifty idea: suppose we augment our matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> with the *identity* <img src="https://latex.codecogs.com/gif.latex?\inline&space;I"/> at the outset.



```matlab:Code
R_E = [A I]
```

R_E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccccc}&space;3&space;&&space;2&space;&&space;4&space;&&space;1&space;&&space;0&space;&&space;0\\&space;4&space;&&space;1&space;&&space;2&space;&&space;0&space;&&space;1&space;&&space;0\\&space;2&space;&&space;0&space;&&space;3&space;&&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>


Once more for fun, we go through the same sequence of row operations we've applied many times before:



```matlab:Code
R_E(2,:) = R_E(2,:) - R_E(2,1)/R_E(1,1) * R_E(1,:);
R_E(3,:) = R_E(3,:) - R_E(3,1)/R_E(1,1) * R_E(1,:);
R_E(3,:) = R_E(3,:) - R_E(3,2)/R_E(2,2) * R_E(2,:)  % only display the final step this time
```

R_E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccccc}&space;3&space;&&space;2&space;&&space;4&space;&&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}&space;&&space;-\frac{4}{3}&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;3&space;&&space;\frac{2}{5}&space;&&space;-\frac{4}{5}&space;&&space;1&space;\end{array}\right)"/>


But notice: by augmenting the identity and applying the same row operations to it, we have actually recorded the full elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> as we went along.  It's just sitting there in the rightmost columns.



```matlab:Code
R_E(:, n+1:end)
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;-\frac{4}{3}&space;&&space;1&space;&&space;0\\&space;\frac{2}{5}&space;&&space;-\frac{4}{5}&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, E) % the right half is E
```


```text:Output
ans =    1
```



Meanwhile the row echelon form is still there on the left as usual.



```matlab:Code
R_E(:, 1:n)
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;3&space;&&space;2&space;&&space;4\\&space;0&space;&&space;-\frac{5}{3}&space;&&space;-\frac{10}{3}\\&space;0&space;&&space;0&space;&&space;3&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, R) % the left half is R
```


```text:Output
ans =    1
```



Very nice.  So we don't have to go through the side process of forming individual elementary matrices <img src="https://latex.codecogs.com/gif.latex?\inline&space;E_1"/>, <img src="https://latex.codecogs.com/gif.latex?\inline&space;E_2"/> and so on.  We can just augment <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> with <img src="https://latex.codecogs.com/gif.latex?\inline&space;I"/>, apply our sequence of row operations directly, and read off *both* the row echelon form <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> and the elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> at the end.


### Exercise


In a (separate) MATLAB editor tab, use the process described above to compute the row echelon form <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> and the elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/>, and use it to solve <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  Don't refer to back to the example code unless you really get stuck.▫


## 1.2.6 Reduction to reduced row echelon form (RREF)


Row echelon form is sufficient to calculate determinants and solve linear systems, and so row echelon form is all you would ever need if that was your *only* goal.  Since our goal is also to advance our *theoretical understanding* we will continue with our elimination process from here, all the way to *reduced* row echelon form.  This means, scaling the pivots to be ones, and zeroing *above* the pivots as well.  The algorithm should be familiar already from your earlier studies, but if not, refer to the text book for details. [Anton 1.1]




[Video](https://web.microsoftstream.com/video/7d084993-5c78-47a5-97ef-6f29afb0ba91)




We will *not* ask you to go through the pain of doing this whole example yourself by hand.  Although feel free all the same, if you really want to.




Let's jump straight in to finding the RREF in MATLAB by applying the remaining row operations required.  Remember that in MATLAB we're applying the row operations to the augmented matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;[A|I]"/>, so that we get both the reduced row echelon form <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> *and *the elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> at the end.



```matlab:Code
% Scale the rows to have unit pivots
R_E(1,:) = R_E(1,:) / R_E(1,1);
R_E(2,:) = R_E(2,:) / R_E(2,2);
R_E(3,:) = R_E(3,:) / R_E(3,3) % only show the final result
```

R_E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccccc}&space;1&space;&&space;\frac{2}{3}&space;&&space;\frac{4}{3}&space;&&space;\frac{1}{3}&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;2&space;&&space;\frac{4}{5}&space;&&space;-\frac{3}{5}&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;&&space;\frac{2}{15}&space;&&space;-\frac{4}{15}&space;&&space;\frac{1}{3}&space;\end{array}\right)"/>

```matlab:Code
% Introduce zeros above the pivots
R_E(2,:) = R_E(2,:) - R_E(2,3) * R_E(3,:);
R_E(1,:) = R_E(1,:) - R_E(1,3) * R_E(3,:);
R_E(1,:) = R_E(1,:) - R_E(1,2) * R_E(2,:) % only show the final result
```

R_E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccccc}&space;1&space;&&space;0&space;&&space;0&space;&&space;-\frac{1}{5}&space;&&space;\frac{2}{5}&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0&space;&&space;\frac{8}{15}&space;&&space;-\frac{1}{15}&space;&&space;-\frac{2}{3}\\&space;0&space;&&space;0&space;&&space;1&space;&&space;\frac{2}{15}&space;&&space;-\frac{4}{15}&space;&&space;\frac{1}{3}&space;\end{array}\right)"/>


Because our matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is nonsingular, its reduced row echelon form is simply the identity matrix.



```matlab:Code
isequal(R_E(:, 1:n), I)
```


```text:Output
ans =    1
```



So what, then, is sitting in the rightmost columns?  Well, as always, it's the cumulative effect of all our row operations.  It's the matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/>, such that when applied to <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>, reduces <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> to the identity matrix (since the identity matrix *is* the reduced row echelon form of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>).



```matlab:Code
E_rref = R_E(:, n+1:end)
```

E_rref = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;-\frac{1}{5}&space;&&space;\frac{2}{5}&space;&&space;0\\&space;\frac{8}{15}&space;&&space;-\frac{1}{15}&space;&&space;-\frac{2}{3}\\&space;\frac{2}{15}&space;&&space;-\frac{4}{15}&space;&&space;\frac{1}{3}&space;\end{array}\right)"/>

```matlab:Code
E_rref * A  % confirm that it reduces A to the identity
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>


Which is to say, <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/> is now just the *inverse* of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>: <img src="https://latex.codecogs.com/gif.latex?\inline&space;E=A^{-1}"/>.



```matlab:Code
isequal(E_rref, inv(A))
```


```text:Output
ans =    1
```



This is in fact the *Gauss-Jordan* method for finding the inverse of a matrix.  But now you can see why it works: the inverse matrix *is* the sequence of row operations that reduces <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> to the identity.


### Exercise


In a (separate) MATLAB editor tab, use the process described above to compute the inverse matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^{-1}"/> by Gauss-Jordan elimination.  Don't refer to back to the example code unless you really get stuck.▫


## 1.2.7 The MATLAB functions rref and rref2


As already alluded to, for solving practical problems, finding the reduced row echelon form is usually too much work to be worth it.  But for theoretical understanding, it has a decided advantage: it is *unique*.  Any matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> has exactly one reduced row echelon form.  Hence, the particular sequence of row operations used to calculate it is unimportant: everyone will agree on the final result.




MATLAB handily provides a function for finding the RREF, called unsurprisingly, `rref`.



```matlab:Code
R = rref(A)
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>


From now on in this chapter, we'll only deal with RREFs, so our notation <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> will always refer to the *reduced *row echelon form.  For our current matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>, its RREF is just the identity, but that won't be the case for every matrix.




Annoyingly, MATLAB's `rref` *doesn't *return the elimination matrix, so there's no way of replaying the row operations again later (say, to a right hand side vector).  To remedy this, your lecturer has written an improved function called `rref2` that also returns the elimination matrix.  We already know how to do this ourselves: just augment the matrix with the identity at the beginning, and then pull apart the two halves at the end.  (You might like to check the code of `rref2.m` to confirm that's exactly how it works.)



```matlab:Code
[R,E] = rref2(A)  % using our own function rref2, we also get the elimination matrix
```

R = 

   $$ \left(\begin{array}{ccc}
1 & 0 & 0\\
0 & 1 & 0\\
0 & 0 & 1
\end{array}\right)$
E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;-\frac{1}{5}&space;&&space;\frac{2}{5}&space;&&space;0\\&space;\frac{8}{15}&space;&&space;-\frac{1}{15}&space;&&space;-\frac{2}{3}\\&space;\frac{2}{15}&space;&&space;-\frac{4}{15}&space;&&space;\frac{1}{3}&space;\end{array}\right)"/>

```matlab:Code
isequal(E, inv(A)) % A is invertible, so the elimination matrix is its inverse
```


```text:Output
ans =    1
```



Having gone to the trouble of computing a full RREF, it's trivial to then solve <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> for this example.  The solution can be read off directly from the reduced right hand side vector.



```matlab:Code
E * [A b]  % RREF, so the solution to Ax = b will be the rightmost column
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;0&space;&&space;-1\\&space;0&space;&&space;1&space;&&space;0&space;&&space;-2\\&space;0&space;&&space;0&space;&&space;1&space;&&space;3&space;\end{array}\right)"/>

```matlab:Code
x = E * b  % or better yet, here's just that column
```

x = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-1\\&space;-2\\&space;3&space;\end{array}\right)"/>
### Exercise


In a (separate) MATLAB editor tab, use the `rref2` function to solve <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  Don't refer to back to the example code unless you really get stuck.▫


## 1.2.8 Consistency of a linear system


We know from our earlier analysis that this matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is nonsingular.  Hence, for *any* right hand side vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> the linear system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> will be consistent and have a unique solution.  It's worthwhile considering how best to characterise this fact in a way that will generalise to more interesting cases.  The most useful way turns out to be using the rank of the matrices <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>.




[Video](https://web.microsoftstream.com/video/9f88d112-e1ec-47e8-bdc5-03d4b575f46e)




If we have our elimination matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;E"/>, we can calculate these two ranks by counting the number of nonzero rows in the reduced row echelon forms:



```matlab:Code
E*A
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
E*[A b]
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;0&space;&&space;-1\\&space;0&space;&&space;1&space;&&space;0&space;&&space;-2\\&space;0&space;&&space;0&space;&&space;1&space;&&space;3&space;\end{array}\right)"/>


In both cases, there are 3 nonzero rows and hence the ranks of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/> are both 3.  You actually could have read *both* ranks off just the second matrix (i.e. just the augmented matrix) by mentally covering up the right hand side column at first.




We could also have just asked MATLAB directly:



```matlab:Code
rank(A), rank([A b])
```


```text:Output
ans = 3
ans = 3
```



but of course this isn't magic: the `rank` function has to do the same elimination as us to get the answer.




Anyway, however you arrive at the answer, the first key fact is that rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>) which means the system is *consistent*.



   -  rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  <img src="https://latex.codecogs.com/gif.latex?\inline&space;\iff"/>  system is **consistent** 



To ascertain whether the solution is *unique* or not, you need to ask whether this common rank is equal to the number of unknowns <img src="https://latex.codecogs.com/gif.latex?\inline&space;n"/>:



```matlab:Code
isequal(rank(A), n)
```


```text:Output
ans =    1
```



In this case, yes it is.  So the system has a *unique *solution.



   -  rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  = <img src="https://latex.codecogs.com/gif.latex?\inline&space;n"/> <img src="https://latex.codecogs.com/gif.latex?\inline&space;\iff"/>  system is **consistent **with a **unique** solution 



If this seemed like an unnecessarily elaborate way to determine the number of solutions to this system, don't worry.  It's true that this square, consistent system was the simplest possible case which could have been handled more easily.  The goal is to develop a perfectly general approach that will give us the right conclusion for *any* linear system.  It will pay off later!


## 1.2.9 Column interpretation


So far we've been thinking mostly in terms of *rows*.  The matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> represents a system of equations, where each equation corresponds to a row.  We perform row operations.  We examine the number of nonzero rows in the result.  We calculate the row rank.  Rows, rows, rows.




Actually, quite often in linear algebra, the *column* interpretation can be more revealing.  To view the same problem <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> in terms of columns, we imagine the following question.  Suppose we have three vectors <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_1&space;,v_2&space;,v_3"/>.  We want to know, what *linear combination* of these vectors will produce a given vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>?  In other words, what *coefficients* <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_1&space;,x_2&space;,x_3"/> should we choose, so that <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_1&space;v_1&space;+x_2&space;v_2&space;+x_3&space;v_3&space;=b"/>?




The answer to this question is found by augmenting the vectors as *columns* of a matrix and solving <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  To see this, remember that we can *partition* matrices any way we please, and perform multiplications, provided everything conforms [Anton 1.3].  So we can think of the matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> as a "row vector" of columns:  <img src="https://latex.codecogs.com/gif.latex?\inline&space;A=[v_1&space;~v_2&space;~v_3&space;]"/>.  Multiplying this "row vector" by the column vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;x"/> we get: <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=[v_1&space;~v_2&space;~v_3&space;]<img&space;src="https://latex.codecogs.com/gif.latex?\left\lbrack&space;\begin{array}{c}&space;x_1&space;\\&space;x_2&space;\\&space;x_3&space;&space;\end{array}\right\rbrack"/>=x_1&space;v_1&space;+x_2&space;v_2&space;+x_3&space;v_3"/> which we want to equal <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.  So indeed, solving <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> amounts to determining what particular linear combination of the columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> will generate <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.  We can confirm this interpretation holds for our example.



```matlab:Code
x = A \ b
```

x = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-1\\&space;-2\\&space;3&space;\end{array}\right)"/>

```matlab:Code
x(1)*A(:,1) + x(2)*A(:,2) + x(3)*A(:,3)  % form the linear combination of A's columns
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;5\\&space;0\\&space;7&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, b)  % yes, this is equal to b as required
```


```text:Output
ans =    1
```



We know that this matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is nonsingular, meaning that <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> has a solution for any <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.  Hence, it must be the case that we can form any vector we like by taking a suitable linear combination of the columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  In other words, the columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> *span* all of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R^3"/>.  That is, the *column rank* of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is 3.  This agrees with our earlier observation that the *row rank* of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> was also 3.  And indeed, it is a general result that for any matrix, its row and column ranks are equal.



   -  For any matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>, the row rank of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> equals the column rank of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and we denote this common value by rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>). 

# 1.3 Square, singular matrix


Now, what if our square matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is singular?  In this case, as we will shortly verify, we cannot possibly have a unique solution to the system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  We *can* however, still have solutions: but if so, there will be infinitely many of them.  Alternatively, there may be no solutions at all: it depends on the right hand side <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.




Let's set up our new example, a square matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> which will turn out to be singular.



```matlab:Code
clear
n = 3;
A = sym([1 -2 -1 ; -3 0 -3 ; 1 1 2])
```

A = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;-2&space;&&space;-1\\&space;-3&space;&&space;0&space;&&space;-3\\&space;1&space;&&space;1&space;&&space;2&space;\end{array}\right)"/>


And we'll consider two possible right hand side vectors, <img src="https://latex.codecogs.com/gif.latex?\inline&space;b_1"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;b_2"/>.



```matlab:Code
b1 = sym([2; -3; 4])  % right hand side 1
```

b1 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;2\\&space;-3\\&space;4&space;\end{array}\right)"/>

```matlab:Code
b2 = sym([8; 6; -7])  % right hand side 2
```

b2 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;8\\&space;6\\&space;-7&space;\end{array}\right)"/>


We'll begin by reducing <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> to reduced row echelon form.  Since there is nothing really new here regarding the row operations, let's just get MATLAB to do the work for us in one hit.



```matlab:Code
R = rref2(A)
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;1\\&space;0&space;&&space;1&space;&&space;1\\&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>


Aha!  We see here a crucial difference between the RREF matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> for this example, compared to the previous example: the RREF matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/> now has a full row of zeros at the bottom.  If present, rows of zeros always appear at the bottom of the RREF.  Notice also that there are still some nonzero values present above the diagonal in the final column.  Don't make the mistake of thinking that these should have somehow been "zeroed out" (after all, *how* would you achieve that? -- the diagonal entry for that column is zero).




Remember, the RREF is unique.  If you want the practice, do the row operations for this example by hand - you *must* arrive at the same result.


### Exercise


(Optional)  On a piece of paper, perform Gauss-Jordan elimination on the matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and confirm you obtain the reduced row echelon form exhibited above.▫


## 1.3.1 Row space


The presence of the row of zeros in the RREF immediately alerts us to the fact that this matrix is singular.  More specifically, it has a row rank of 2, and hence, simply, a rank of 2.  Since 2 is less than 3, we have a singular matrix on our hands.  Just to confirm:



```matlab:Code
rank(A) % singular matrix: will be less than n
```


```text:Output
ans = 2
```


```matlab:Code
det(A)  % singular matrix: will be equal to zero
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;0"/>


The row rank, remember, is the dimension of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>'s row space.  Hence, it must be that there are only *two* linearly independent rows of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Since we've already established that row operations *do not alter the row space*, it is a simple task to read off a *basis* for the row space from the RREF: it's simply the nonzero rows of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/>.




[Video](https://web.microsoftstream.com/video/dffc65ea-513b-4077-86a1-a344f8149d97)




**Important notes on conventions:**



   \item{ We will usually consider the vector space <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/> as consisting of *column *vectors*.  *But, when we talk about a basis for the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>, since it's literally called "row" space, it is tempting to write its basis using row vector notation.  This is also the convention used in Anton's textbook.  For now, we will do the same.  Later on however, it will be a nuisance when we want to compare the row space with some other space, since most often the basis for the other space will be expressed in terms of column vectors.  So be prepared to switch convention to using column vectors when the time comes. }
   1.  Remember that a basis is not** **a matrix.  A basis is a *set* of vectors: a linearly independent spanning set, to be precise.  MATLAB however, does not have a convenient data type to represent a set of objects.  So, for the sake of programming convenience, we will choose to represent our basis as a matrix of columns (usually), or a matrix of rows (for the present case of a row space). 



With all this in mind, our basis for the row space will be represented simply as:



```matlab:Code
RS_basis = R(1:2, :) % the nonzero rows of R
```

RS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;1\\&space;0&space;&&space;1&space;&&space;1&space;\end{array}\right)"/>
## 1.3.2 Consistency


Since this matrix has less than full rank, it is impossible that the linear system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> could have a unique solution.  Remember the condition for *uniqueness* was



   -  rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  = <img src="https://latex.codecogs.com/gif.latex?\inline&space;n"/> <img src="https://latex.codecogs.com/gif.latex?\inline&space;\iff"/>  system is **consistent **with a **unique** solution 



Since rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>)  < n in this example, that rules out this possibility.  Instead, we have the options of *no solution*, or *infinitely many solutions*.  The deciding fact will be whether rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>).  Remember the condition for *consistency* was



   -  rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  <img src="https://latex.codecogs.com/gif.latex?\inline&space;\iff"/>  system is **consistent** 



The converse of this is 



   -  rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) <img src="https://latex.codecogs.com/gif.latex?\inline&space;\not="/> rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  <img src="https://latex.codecogs.com/gif.latex?\inline&space;\iff"/>  system is **inconsistent** 



So, it now all hinges on the rank of <img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>.  For some vectors <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> this augmented matrix will have the same rank as <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> (i.e. 2).  For others, the augmented matrix will have rank 3, and the system will be inconsistent.




Here are examples of each case:



```matlab:Code
R_z1 = rref([A b1])
```

R_z1 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;1&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>


We have rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = 2 but rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>) = 3.  The system is inconsistent: there is no <img src="https://latex.codecogs.com/gif.latex?\inline&space;x"/> such that <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.



```matlab:Code
R_z2 = rref([A b2])
```

R_z2 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;-2\\&space;0&space;&&space;1&space;&&space;1&space;&&space;-5\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>


We have rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>) = 2 <img src="https://latex.codecogs.com/gif.latex?\inline&space;<n"/>.  The system has *infinitely many solutions*.


## 1.3.3 Infinitely many solutions


To find these infinitely many solutions for the second right hand side, we first need to identify the *basic variables* and *free variables* from the RREF (note that Anton calls these "leading variables" and "parameters" respectively).  A basic variable is one whose *column* in the RREF has the leading 1 for some *row*.  For this matrix, that's <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_1"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_2"/> (i.e. columns 1 and 2).  The free variables are whichever are not basic variables; for this matrix that's <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_3"/>.  The linear system poses no restrictions on the values of the free variables: they can take any values at all.  Only the basic variables are constrained by the equations associated with the nonzero rows.




[Video](https://web.microsoftstream.com/video/7abfe666-0c4f-4496-be8a-2b6578592bc1)


### Exercise


On a piece of paper, perform the same procedure as in the video to find the infinitely many solutions to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  Don't refer to back to the example video unless you really get stuck.▫




So, one *particular solution *of the infinite family of solutions is easy to obtain in MATLAB: we simply set the free variable to zero and so the values of the basic variables can then be read off the rightmost column of the augmented RREF as usual.



```matlab:Code
r = 2;                   % rank of A
bv = [1,2];              % identify the basic variables are x1,x2 from the RREF by inspection
x_p = sym(zeros(n,1));   % start with all zeros for the solution
x_p(bv) = R_z2(1:r, n+1) % read off the basic variables from the rightmost column of RREF
```

x_p = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-2\\&space;-5\\&space;0&space;\end{array}\right)"/>
### Exercise


In a (separate) MATLAB editor tab, recreate the four lines of code above for finding the particular solution.  Examine it line-by-line, pull it apart and make sure you understand how it works.  Refer back to how we did this same example by hand, and convince yourself that this code is doing the same thing.▫




This particular solution is in fact the solution that MATLAB returns when you "backslash" the original system.



```matlab:Code
A \ b2
```


```text:Output
Warning: Solution is not unique because the system is rank-deficient.
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-2\\&space;-5\\&space;0&space;\end{array}\right)"/>


As you can see though, you also get a warning alerting you to the fact that the solution is not unique.  So, how do we obtain all the other solutions?  When we did this example by hand, it was fairly natural to just do the algebra and it all fell out in one go.  In MATLAB, the best way forward will be to utilise another fundamental matrix space: the *null space*.




Incidentally, we identified "by inspection" the basic variables above, `bv = [1,2]`.  The `rref2` function can, on request, also return the indices of the basic variables for us.



```matlab:Code
[R,E,bv] = rref2(A) % notice we're requesting three outputs from rref2 here
```

R = 

   $$ \left(\begin{array}{ccc}
1 & 0 & 1\\
0 & 1 & 1\\
0 & 0 & 0
\end{array}\right)$
E = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;0&space;&&space;-\frac{1}{3}&space;&&space;0\\&space;0&space;&&space;\frac{1}{3}&space;&&space;1\\&space;1&space;&&space;1&space;&&space;2&space;\end{array}\right)"/>

```text:Output
bv = 1x2    
     1     2

```



Again, this isn't magic; the code in `rref2` to identify the basic variables is just carrying out the same inspection process we did.




Anyway, on to the null space!


## 1.3.4 Null space


The null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is defined as the set of all solutions to the *homogeneous* linear system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=0"/>.  For a nonsingular matrix, the only solution of <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=0"/> is the *trivial solution* <img src="https://latex.codecogs.com/gif.latex?\inline&space;x=0"/>.  But for our present example, since <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is singular, there will be *nontrivial solutions* to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=0"/>, and these solutions form the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A."/>




How can we find the null space of our matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>?  By hand, we would form the RREF for the homogeneous system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=0"/>.



```matlab:Code
rref([A zeros(n,1)])
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;1&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>


Note the important fact that the homogeneous system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=0"/> is **always** consistent: the rank of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> will *always *equal the rank of <img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~0]"/>.




[Video](https://web.microsoftstream.com/video/21c3eadb-6911-4a38-b1af-b18557f3d653)


### Exercise


On a piece of paper, perform the same procedure as in the video to find the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Don't refer to back to the example video unless you really get stuck.▫




Notice that you're really just solving a simpler version of <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> now with <img src="https://latex.codecogs.com/gif.latex?\inline&space;b=0"/>.  So why worry about the null space at all, why not just solve <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> and be done with it, if that's what we really care about?  A few reasons:



   -  Thinking about the null space aids understanding exactly "where" the infinitely many solutions to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> come from. 
   -  It's much more amenable to computer-based solution. 



On the second point, as you might expect, MATLAB has a function to return a basis for the null space directly:



```matlab:Code
NS_basis = null(A)
```

NS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-1\\&space;-1\\&space;1&space;\end{array}\right)"/>


Using that, we can find the *general solution* to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> by combining our earlier *particular solution* <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_p"/> with a general null space vector.



```matlab:Code
t = sym('t', 'real');
x_g = x_p + NS_basis*t
```

x_g = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;-t-2\\&space;-t-5\\&space;t&space;\end{array}\right)"/>


Regardless of the value of <img src="https://latex.codecogs.com/gif.latex?\inline&space;t"/>, this is a solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.



```matlab:Code
A*x_g
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;8\\&space;6\\&space;-7&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, b2) % yes, the linear system is satisfied
```


```text:Output
ans =    1
```

## 1.3.6 Column space


Let's recap.  We were able to find an infinite family of solutions to the system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b_2"/>.  But earlier, we found that the system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b_1"/> had no solutions.



```matlab:Code
rref([A b1])  % inconsistent
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;1&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
rref([A b2])  % consistent
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;-2\\&space;0&space;&&space;1&space;&&space;1&space;&&space;-5\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>


What was it about the right hand side vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;b_2"/> that allowed the system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b_2"/> to be consistent, whereas the system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b_1"/> was inconsistent?  The answer is found by returning to the column interpretation of solving <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>.  We are trying to find a linear combination of the columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> that will generate <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/>.  Hence, for the linear system to be consistent, <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> *must lie in the space spanned by the columns of *<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>: the *column space.*




[Video](https://web.microsoftstream.com/video/6dac32fe-ca9f-44a5-a723-581e12cab267)


### Exercise


On a piece of paper, perform the same procedure as in the video to find the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> two different ways:



   -  By identifying the general form of <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> for which <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> is consistent. 
   -  By finding the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/>. 



Confirm you get the same result either way.  Don't refer to back to the example video unless you really get stuck.▫




Let's now in MATLAB, find the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> the first way.  That is, we will find the general form of <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> such that <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> is consistent.  We'll build a nice general right hand side vector:



```matlab:Code
b = sym('b', [n,1], 'real')
```

b = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;b_1&space;\\&space;b_2&space;\\&space;b_3&space;&space;\end{array}\right)"/>


and reduce the system to RREF using our elimination matrix we saved earlier.



```matlab:Code
R_z = E * [A b]
```

R_z = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;-\frac{b_2&space;}{3}\\&space;0&space;&&space;1&space;&&space;1&space;&&space;\frac{b_2&space;}{3}+b_3&space;\\&space;0&space;&&space;0&space;&&space;0&space;&&space;b_1&space;+b_2&space;+2\,b_3&space;&space;\end{array}\right)"/>


We can see that for the system to be consistent in general, we will require the last entry in the rightmost column to be zero, so that rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>).



```matlab:Code
b_cond = isolate(R_z(n,n+1) == 0, b(n))
```

b_cond = 

   <img src="https://latex.codecogs.com/gif.latex?&space;b_3&space;=-\frac{b_1&space;}{2}-\frac{b_2&space;}{2}"/>


Hence the general form of <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> that leads to a consistent system is



```matlab:Code
b_consistent = subs(b, lhs(b_cond), rhs(b_cond))
```

b_consistent = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;b_1&space;\\&space;b_2&space;\\&space;-\frac{b_1&space;}{2}-\frac{b_2&space;}{2}&space;\end{array}\right)"/>


All vectors in the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> have this form.  So we can find a basis for this space by considering how to represent this general form as a linear combination of two vectors.



```matlab:Code
CS_basis(:, 1) = subs(b_consistent, b(1:2), [1;0]);
CS_basis(:, 2) = subs(b_consistent, b(1:2), [0;1])
```

CS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;1&space;&&space;0\\&space;0&space;&&space;1\\&space;-\frac{1}{2}&space;&&space;-\frac{1}{2}&space;\end{array}\right)"/>


Sure enough, MATLAB has a function to compute the column space directly from <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>:



```matlab:Code
colspace(A)
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;1&space;&&space;0\\&space;0&space;&&space;1\\&space;-\frac{1}{2}&space;&&space;-\frac{1}{2}&space;\end{array}\right)"/>


It agrees with our result.



```matlab:Code
isequal(ans, CS_basis)
```


```text:Output
ans =    1
```

## 1.3.7 The four fundamental subspaces


So far, we have computed bases for the null space, the row space and the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.



```matlab:Code
NS_basis, RS_basis, CS_basis
```

NS_basis = 

   $$ \left(\begin{array}{c}
-1\\
-1\\
1
\end{array}\right)$
RS_basis = 

   $$ \left(\begin{array}{ccc}
1 & 0 & 1\\
0 & 1 & 1
\end{array}\right)$
CS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;1&space;&&space;0\\&space;0&space;&&space;1\\&space;-\frac{1}{2}&space;&&space;-\frac{1}{2}&space;\end{array}\right)"/>


As we have seen, MATLAB has inbuilt functions to return the null space and column space bases, and they agree with our results.



```matlab:Code
isequal(null(A), NS_basis)
```


```text:Output
ans =    1
```


```matlab:Code
isequal(colspace(A), CS_basis)
```


```text:Output
ans =    1
```



But what about the row space?  Can we compute that directly using MATLAB?  Well, since the rows of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> are just the columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/>, it is a simple matter to compute the row space in MATLAB by transposing the matrix and finding the column space instead.



```matlab:Code
colspace(A')
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;1&space;&&space;0\\&space;0&space;&&space;1\\&space;1&space;&&space;1&space;\end{array}\right)"/>


This too, agrees with our earlier result, **provided** we now switch our convention and represent our row space basis using *column* vectors, as we foreshadowed earlier.



```matlab:Code
RS_basis = RS_basis'
```

RS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;1&space;&&space;0\\&space;0&space;&&space;1\\&space;1&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
isequal(colspace(A'), RS_basis)
```


```text:Output
ans =    1
```



There is in fact, one more important space associated with a matrix: *the null space of its transpose, *also known as the *left* *null space*.  Again, this is easily found by transposing.



```matlab:Code
LNS_basis = null(A')
```

LNS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;\frac{1}{2}\\&space;\frac{1}{2}\\&space;1&space;\end{array}\right)"/>


So here we have bases for the *four fundamental subspaces *of a matrix: its row space, column space, null space, and left null space.




[Video](https://web.microsoftstream.com/video/54867e9d-8af8-4d3b-b813-4ad13d85a484)




In MATLAB we can now verify an important theorem in linear algebra [Anton Thm 4.8.7]:



   -  The row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> are orthogonal complements. 
   -  The column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/> are orthogonal complements. 



*Orthogonal complements* here means that the spaces are orthogonal, *and* the bases for the two spaces, when assembled together, form a complete basis for <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/>.  




We can check both properties easily for the row space and null space.  First, they are orthogonal:



```matlab:Code
RS_basis' * NS_basis      % find pair-wise dot products between all basis vectors
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;0\\&space;0&space;\end{array}\right)"/>


And second, the augmented matrix has full rank, confirming it spans all of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R^3"/>.



```matlab:Code
rank([RS_basis NS_basis]) % check that the basis vectors together span all of R^3
```


```text:Output
ans = 3
```



Similarly for the column space and left null space:



```matlab:Code
CS_basis' * LNS_basis      % find pair-wise dot products between all basis vectors
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;0\\&space;0&space;\end{array}\right)"/>

```matlab:Code
rank([CS_basis LNS_basis]) % check that the basis vectors together span all of R^3
```


```text:Output
ans = 3
```



This is not yet the complete story on the four fundamental subspaces.  For a more complete description, we will need to look at *rectangular* matrices: those with different numbers of rows than columns.  That's where we're headed next.




Incidentally, the reason we didn't mention the four fundamental subspaces in Section 1.2, is that we had a square, nonsingular matrix then.  So its row and column spaces were simply <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/>, and its two null spaces were empty.  Boring!


# 1.4 Rectangular matrix


Rectangular matrices have a different number of rows (say, <img src="https://latex.codecogs.com/gif.latex?\inline&space;m"/>) than columns (say, <img src="https://latex.codecogs.com/gif.latex?\inline&space;n"/>).  As we will see, this has implications for the four fundamental subspaces: some will be subspaces of <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^m"/> while others will be subspaces of <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/>.




Here's a matrix with more rows than columns.



```matlab:Code
clear
m = 8;
n = 5;
A = sym([1    -1     0     1     0
         1     0     1    -3    -4
         2     2     4     0    -2
         1     0     1     2     1
         3     3     6     0    -3
         0     2     2     2     2
         0     1     1     4     4
         3    -2     1     2    -1])
```

A = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccccc}&space;1&space;&&space;-1&space;&&space;0&space;&&space;1&space;&&space;0\\&space;1&space;&&space;0&space;&&space;1&space;&&space;-3&space;&&space;-4\\&space;2&space;&&space;2&space;&&space;4&space;&&space;0&space;&&space;-2\\&space;1&space;&&space;0&space;&&space;1&space;&&space;2&space;&&space;1\\&space;3&space;&&space;3&space;&&space;6&space;&&space;0&space;&&space;-3\\&space;0&space;&&space;2&space;&&space;2&space;&&space;2&space;&&space;2\\&space;0&space;&&space;1&space;&&space;1&space;&&space;4&space;&&space;4\\&space;3&space;&&space;-2&space;&&space;1&space;&&space;2&space;&&space;-1&space;\end{array}\right)"/>


We certainly do not plan to undertake all the calculations for such a matrix by hand.  So let's get MATLAB to calculate the RREF for us, before we turn to a bit of pen and paper analysis.



```matlab:Code
rref(A)
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;0&space;&&space;-1\\&space;0&space;&&space;1&space;&&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;1&space;&&space;1\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>


[Video](https://web.microsoftstream.com/video/7f22bc1b-0332-4cc2-8b0a-6abf618a209a)


### Exercise


On a piece of paper, perform the same procedure as in the video to find bases for the row space and null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Confirm the *"rank nullity theorem"* holds*: *<img src="https://latex.codecogs.com/gif.latex?\inline&space;\textrm{rank}(A)+\textrm{nullity}(A)=n"/>.  Don't refer to back to the example video unless you really get stuck.▫




As for MATLAB, well we need only the `colspace` and `null` commands to get the bases for the four fundamental subspaces.



```matlab:Code
CS_basis = colspace(A) % column space
```

CS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1\\&space;\frac{5}{7}&space;&&space;-\frac{3}{7}&space;&&space;\frac{5}{14}\\&space;0&space;&&space;0&space;&&space;\frac{3}{2}\\&space;-\frac{4}{7}&space;&&space;-\frac{6}{7}&space;&&space;\frac{5}{7}\\&space;\frac{1}{7}&space;&&space;-\frac{9}{7}&space;&&space;\frac{4}{7}\\&space;\frac{17}{7}&space;&&space;\frac{1}{7}&space;&&space;\frac{3}{14}&space;\end{array}\right)"/>

```matlab:Code
NS_basis = null(A) % null space
```

NS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;-1&space;&&space;1\\&space;-1&space;&&space;0\\&space;1&space;&&space;0\\&space;0&space;&&space;-1\\&space;0&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
RS_basis = colspace(A') % row space
```

RS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;1&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1\\&space;-1&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>

```matlab:Code
LNS_basis = null(A') % left null space
```

LNS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccccc}&space;-\frac{5}{7}&space;&&space;0&space;&&space;\frac{4}{7}&space;&&space;-\frac{1}{7}&space;&&space;-\frac{17}{7}\\&space;\frac{3}{7}&space;&&space;0&space;&&space;\frac{6}{7}&space;&&space;\frac{9}{7}&space;&&space;-\frac{1}{7}\\&space;-\frac{5}{14}&space;&&space;-\frac{3}{2}&space;&&space;-\frac{5}{7}&space;&&space;-\frac{4}{7}&space;&&space;-\frac{3}{14}\\&space;1&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;1&space;\end{array}\right)"/>
## 1.4.1 Rank-nullity theorem


Now we take stock of what we have.  The row space and column space basis matrices have the same number of columns: 3.



```matlab:Code
size(RS_basis), size(CS_basis)
```


```text:Output
ans = 1x2    
     5     3

ans = 1x2    
     8     3

```



This number is, by definition, the rank of the matrix.



```matlab:Code
rankA = size(RS_basis, 2) % could have used CS_basis here instead
```


```text:Output
rankA = 3
```


```matlab:Code
isequal(rank(A), rankA)
```


```text:Output
ans =    1
```



But notice, the row space is a 3-dimensional subspace of <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^5"/> (<img src="https://latex.codecogs.com/gif.latex?\inline&space;n=5"/>), while the column space is a 3-dimensional subspace of <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^8"/> (<img src="https://latex.codecogs.com/gif.latex?\inline&space;m=8"/>).




Meanwhile, the null space basis matrix has two columns.  The *nullity* of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is, by definition, 2.



```matlab:Code
size(NS_basis)
```


```text:Output
ans = 1x2    
     5     2

```


```matlab:Code
nullityA = size(NS_basis, 2)
```


```text:Output
nullityA = 2
```



The nullity of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/> on the other hand is 5.



```matlab:Code
size(LNS_basis)
```


```text:Output
ans = 1x2    
     8     5

```


```matlab:Code
nullityAT = size(LNS_basis, 2)
```


```text:Output
nullityAT = 5
```



So the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is a 2-dimensional subspace of <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^5"/>, while the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/> is a 5-dimensional subspace of <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^8"/>.




This example illustrates the full generality of possible dimensions.  We have



```matlab:Code
rankA, nullityA, nullityAT
```


```text:Output
rankA = 3
nullityA = 2
nullityAT = 5
```



which are all different.  In particular, we observe the relations, which are true in general [Anton Thm 4.8.2]:



```matlab:Code
rankA + nullityA == n
```


```text:Output
ans =    1
```


```matlab:Code
rankA + nullityAT == m
```


```text:Output
ans =    1
```



We can now update our theorem from [Anton Thm 4.8.7] to include explicit mention of the spaces involved.



   \item{ The row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> are orthogonal complements in <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/>. }
   \item{ The column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/> are orthogonal complements in <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^m"/>. }



We can verify these facts for this example just as before.



```matlab:Code
RS_basis' * NS_basis      % find pair-wise dot products between all basis vectors
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{cc}&space;0&space;&&space;0\\&space;0&space;&&space;0\\&space;0&space;&&space;0&space;\end{array}\right)"/>

```matlab:Code
rank([RS_basis NS_basis]) % check that the basis vectors together span all of R^n
```


```text:Output
ans = 5
```


```matlab:Code
CS_basis' * LNS_basis  % find pair-wise dot products between all basis vectors
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccccc}&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>

```matlab:Code
rank([CS_basis LNS_basis]) % check that the basis vectors together span all of R^m
```


```text:Output
ans = 8
```



From this analysis, we can deduce much about a hypothetical linear system involving this matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  For example, we know that the system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> will *never* have a unique solution, because <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> has a non-empty null space.  Further, we know exactly the conditions under which it will be consistent (and hence have infinitely many solutions): <img src="https://latex.codecogs.com/gif.latex?\inline&space;b"/> must be expressible as a linear combination of the basis vectors for the column space.




For example, the linear system involving the vector



```matlab:Code
b = CS_basis * [3;1;4] % just take some arbitrary linear combination
```

b = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;3\\&space;1\\&space;4\\&space;\frac{22}{7}\\&space;6\\&space;\frac{2}{7}\\&space;\frac{10}{7}\\&space;\frac{58}{7}&space;\end{array}\right)"/>


will be consistent.


## 1.4.2 General solution


[Video](https://web.microsoftstream.com/video/7f8eb895-3909-4366-ab24-9e7622e45e2d)




The *general solution* to the system with this right hand side is expressible as the sum of a *particular solution* to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> plus a *general* null space vector.



```matlab:Code
x_p = A \ b  % particular solution to Ax = b
```


```text:Output
Warning: Solution is not unique because the system is rank-deficient.
```

x_p = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;\frac{16}{7}\\&space;-\frac{2}{7}\\&space;0\\&space;\frac{3}{7}\\&space;0&space;\end{array}\right)"/>

```matlab:Code
t = sym('t', [nullityA, 1], 'real')
```

t = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;t_1&space;\\&space;t_2&space;&space;\end{array}\right)"/>

```matlab:Code
x_n = NS_basis * t  % general solution to Ax = 0
```

x_n = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;t_2&space;-t_1&space;\\&space;-t_1&space;\\&space;t_1&space;\\&space;-t_2&space;\\&space;t_2&space;&space;\end{array}\right)"/>

```matlab:Code
x_g = x_p + x_n  % general solution to Ax = b
```

x_g = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;t_2&space;-t_1&space;+\frac{16}{7}\\&space;-t_1&space;-\frac{2}{7}\\&space;t_1&space;\\&space;\frac{3}{7}-t_2&space;\\&space;t_2&space;&space;\end{array}\right)"/>

```matlab:Code
isequal(A*x_g, b)
```


```text:Output
ans =    1
```

## 1.4.3 Minimum norm solution


With all these possible solutions to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>, you may be wondering if any of them is distinguished as somehow "special".  Well, we already saw one "special" solution of sorts, which was the particular solution <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_p"/> obtained by setting the values of all the free variables to zero.



```matlab:Code
subs(x_g, t, [0;0])
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;\frac{16}{7}\\&space;-\frac{2}{7}\\&space;0\\&space;\frac{3}{7}\\&space;0&space;\end{array}\right)"/>

```matlab:Code
isequal(ans, x_p)
```


```text:Output
ans =    1
```



So this solution is "special" in the sense that several of its entries are zero (those that correspond to the free variables).  But it is certainly not the *only* solution that has two of its entries equal to zero.


### Exercise


On a piece of paper, write down another solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> that has two of its entries equal to zero.▫




There is, however, a uniquely special solution, which is the vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;x"/> with the *minimum norm* among all possible solutions.  We can identify it from our general solution using standard calculus techniques to find which coefficients <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_1"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_2"/> minimise the norm (or more easily, the squared norm).



```matlab:Code
norm_sq = simplify(norm(x_g)^2) % we'll minimise the squared norm since it's easier
```

norm_sq = 

   <img src="https://latex.codecogs.com/gif.latex?&space;3\,{t_1&space;}^2&space;-2\,t_1&space;\,t_2&space;-4\,t_1&space;+3\,{t_2&space;}^2&space;+\frac{26\,t_2&space;}{7}+\frac{269}{49}"/>


Here's a contour plot of <img src="https://latex.codecogs.com/gif.latex?\inline&space;||x||^2"/>, for different choices of the free parameters <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_1"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_2"/>.



```matlab:Code
figure, fcontour(norm_sq), xlabel('t_1'), ylabel('t_2'), title('Contour plot of ||x||^2')
```


![figure_0.eps](MXB201_2021_Chapter1_RC1_images/figure_0.eps)



The squared norm is a quadratic function of the <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_i"/>, meaning it has a unique stationary point, which is found by setting its gradient to zero.



```matlab:Code
eq_sp = gradient(norm_sq) == 0
```

eq_sp = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;6\,t_1&space;-2\,t_2&space;-4=0\\&space;6\,t_2&space;-2\,t_1&space;+\frac{26}{7}=0&space;\end{array}\right)"/>

```matlab:Code
[t1, t2] = solve(eq_sp)
```

t1 = 

   $$ \frac{29}{56}$
t2 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;-\frac{25}{56}"/>

```matlab:Code
hold on, plot(t1, t2, 'rx') % x marks the spot!
```


![figure_1.eps](MXB201_2021_Chapter1_RC1_images/figure_1.eps)



Substituting these values of <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_1"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;t_2"/> into our general solution, we obtain the minimum norm solution.



```matlab:Code
x_min_nrm = subs(x_g, t, [t1;t2])
```

x_min_nrm = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;\frac{37}{28}\\&space;-\frac{45}{56}\\&space;\frac{29}{56}\\&space;\frac{7}{8}\\&space;-\frac{25}{56}&space;\end{array}\right)"/>


We can confirm this solution does have a smaller norm than our particular solution from earlier:



```matlab:Code
double(norm(x_p)), double(norm(x_min_nrm))
```


```text:Output
ans = 2.3430
ans = 1.9039
```



and indeed, by construction, it has a smaller norm than any other possible solution.




Where though, does this minimum norm solution come from?  There is a very nice argument that shows it is in fact the unique solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> that lies in the *row space* of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  




[Video](https://web.microsoftstream.com/video/a9573071-8bd2-4172-a0ce-c4f125123bf9)




Remember that *any* vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;x\in&space;{\mathbb{R}}^n"/> can be written as <img src="https://latex.codecogs.com/gif.latex?\inline&space;x=x_r&space;+x_n"/> with <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_r&space;\in&space;\textrm{rowspace}(A)"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_n&space;\in&space;\textrm{nullspace}(A)"/>, since the row space and null space are orthogonal complements in <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/>.  But taking the squared norm of this vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;x"/>, we see that <img src="https://latex.codecogs.com/gif.latex?\inline&space;\|x{\|}^2&space;=x\cdot&space;x=(x_r&space;+x_n&space;)\cdot&space;(x_r&space;+x_n&space;)=\|x_r&space;{\|}^2&space;+\|x_n&space;{\|}^2"/>  since <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_r&space;\cdot&space;x_n&space;=0"/>.  But when solving <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> we are free to choose any vector in the null space we like, so the minimum norm solution comes from taking the null space component <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_n"/> to be zero, leaving only <img src="https://latex.codecogs.com/gif.latex?\inline&space;x=x_r"/>.  That is, the minimum norm solution is precisely the solution lying in the row space.




Hence, once we develop some more tools in our linear algebra arsenal in later chapters, there will be no need to wield calculus to solve problems like these.  The question of mimimum norm solutions is entirely within the realm of linear algebra.  Let's just check that indeed the solution we found using calculus lies in the row space.  The easiest way is probably just to show that it's *orthogonal* to the *null space*.



```matlab:Code
NS_basis' * x_min_nrm  % expect to get zero for x_min_nrm in rowspace(A)
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;0\\&space;0&space;\end{array}\right)"/>


In applications, sometimes solutions with as many zero elements as possible are desirable (like our <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_p"/>), sometimes solutions with minimum norm are desirable (i.e. <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_r"/>).  Either are likely to be more desirable than a solution like



```matlab:Code
subs(x_g, t, 1e20*[1;1])
```

ans = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{c}&space;\frac{16}{7}\\&space;-\frac{700000000000000000002}{7}\\&space;100000000000000000000\\&space;-\frac{699999999999999999997}{7}\\&space;100000000000000000000&space;\end{array}\right)"/>


but as far as the linear system is concerned, all are legitimate solutions.


### Exercise


In the video above, we drew a diagram which assumed there was a *unique *solution <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_r"/> in the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  But could there be more than one?  In this exercise you will prove that the answer is no.




Let <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> be a consistent linear system.  Prove that the solution to this system which is in the row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is unique.




Hint: try a proof by contradiction.  Start by assuming there were *two *distinct solutions in the row space, and see what that implies.▫


## 1.4.4 Column space revisited


Back to our rectangular matrix for one last look.



```matlab:Code
A
```

A = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccccc}&space;1&space;&&space;-1&space;&&space;0&space;&&space;1&space;&&space;0\\&space;1&space;&&space;0&space;&&space;1&space;&&space;-3&space;&&space;-4\\&space;2&space;&&space;2&space;&&space;4&space;&&space;0&space;&&space;-2\\&space;1&space;&&space;0&space;&&space;1&space;&&space;2&space;&&space;1\\&space;3&space;&&space;3&space;&&space;6&space;&&space;0&space;&&space;-3\\&space;0&space;&&space;2&space;&&space;2&space;&&space;2&space;&&space;2\\&space;0&space;&&space;1&space;&&space;1&space;&&space;4&space;&&space;4\\&space;3&space;&&space;-2&space;&&space;1&space;&&space;2&space;&&space;-1&space;\end{array}\right)"/>

```matlab:Code
rank(A)
```


```text:Output
ans = 3
```



It's noticeable that <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is not of full rank.  "Full rank" in this case would mean a rank of 5: the number of columns.




Since the rank of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> is only 3, it must be that there are only three linearly independent columns.  The other two columns must therefore be expressible as linear combinations of these three.  This raises two questions:



   1.  How can we identify which columns form a linearly independent set? 
   1.  How can we express the remaining columns in terms of these? 



[Video](https://web.microsoftstream.com/video/304650bb-1076-4167-ab93-d49a5a47dd87)




Both questions are readily answered by looking at the RREF.



```matlab:Code
R = rref(A)
```

R = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccccc}&space;1&space;&&space;0&space;&&space;1&space;&&space;0&space;&&space;-1\\&space;0&space;&&space;1&space;&&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;1&space;&&space;1\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0\\&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;&&space;0&space;\end{array}\right)"/>


In fact, the answer to the first question is just a matter of identifying the *basic columns*: those columns with the leading 1 for some row.  These are evidently columns 1, 2 and 4.  Sure enough, if you look back to our earlier solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/>, the basic variables were indeed <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_1"/>, <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_2"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_4"/>.




So columns 3 and 5 of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> must be expressible as linear combinations of columns 1, 2 and 4.  Can we determine the coefficients in those linear combinations?  Yes.  Look at the top two entries in column 3 of <img src="https://latex.codecogs.com/gif.latex?\inline&space;R"/>: 1 and 1.  This is telling you that column 3 = <img src="https://latex.codecogs.com/gif.latex?\inline&space;1\times"/> column 1 + <img src="https://latex.codecogs.com/gif.latex?\inline&space;1\times"/> column 2



```matlab:Code
isequal(A(:,3), A(:,1) + A(:,2))
```


```text:Output
ans =    1
```



Similarly, the entries -1, 0, 1 in column 5 tell you that column 5 = <img src="https://latex.codecogs.com/gif.latex?\inline&space;-1\times"/> column 1 + <img src="https://latex.codecogs.com/gif.latex?\inline&space;0\times"/> column 2 + <img src="https://latex.codecogs.com/gif.latex?\inline&space;1\times"/> column 4.



```matlab:Code
isequal(A(:,5), -A(:,1) + A(:,4))
```


```text:Output
ans =    1
```



Do you see why?  Remember what we discussed in the video above: if you were given three vectors <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_1"/>, <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_2"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_3"/> and asked the question "what linear combination of vectors <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_1"/> and <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_2"/> give me <img src="https://latex.codecogs.com/gif.latex?\inline&space;v_3"/>?", what linear system would you form and solve to find the answer?




Since there are only three linearly independent columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>, it must be that their span *is *the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  So evidently, we could have found a basis for the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> in a completely different way than we did earlier: simply identify the basic columns from the RREF, then grab those columns out of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Compare:



```matlab:Code
CS_basis % what we had before
```

CS_basis = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;0&space;&&space;0\\&space;0&space;&&space;1&space;&&space;0\\&space;0&space;&&space;0&space;&&space;1\\&space;\frac{5}{7}&space;&&space;-\frac{3}{7}&space;&&space;\frac{5}{14}\\&space;0&space;&&space;0&space;&&space;\frac{3}{2}\\&space;-\frac{4}{7}&space;&&space;-\frac{6}{7}&space;&&space;\frac{5}{7}\\&space;\frac{1}{7}&space;&&space;-\frac{9}{7}&space;&&space;\frac{4}{7}\\&space;\frac{17}{7}&space;&&space;\frac{1}{7}&space;&&space;\frac{3}{14}&space;\end{array}\right)"/>

```matlab:Code
CS_basis_2 = A(:, [1,2,4]) % using the basic columns of A
```

CS_basis_2 = 

   <img src="https://latex.codecogs.com/gif.latex?&space;\left(\begin{array}{ccc}&space;1&space;&&space;-1&space;&&space;1\\&space;1&space;&&space;0&space;&&space;-3\\&space;2&space;&&space;2&space;&&space;0\\&space;1&space;&&space;0&space;&&space;2\\&space;3&space;&&space;3&space;&&space;0\\&space;0&space;&&space;2&space;&&space;2\\&space;0&space;&&space;1&space;&&space;4\\&space;3&space;&&space;-2&space;&&space;2&space;\end{array}\right)"/>


These two bases look nothing alike, but they *must* both span the same space: the column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.  Here's a quick way to confirm this fact:



```matlab:Code
rank([CS_basis CS_basis_2])  % find the rank of the two basis matrices augmented
```


```text:Output
ans = 3
```



The rank of the augmented matrices is still just 3: no new information is provided by `CS_basis_2` that wasn't already represented by `CS_basis`.  They're just different representations of the same space.  Both bases have their own advantages.  The first, `CS_basis`, has the nice one/zero structure in the top rows, which makes it perfectly clear that the three vectors are linearly independent.  The second, `CS_basis_2`, consists entirely of columns of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.


### Exercise


Describe how you would build a basis for the *row space* of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> that consisted entirely of rows of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>.




Try it out on the matrix above, either by hand(!) and/or using MATLAB.




Confirm your new basis spans the same space as the basis for the row space we found earlier.▫


# **1.5 Summary**

   \item{ Associated with every matrix <img src="https://latex.codecogs.com/gif.latex?\inline&space;A\in&space;{\mathbb{R}}^{m\times&space;n}"/> are four fundamental subspaces: the row space, the column space, the null space and the left null space. }
   -  The four fundamental subspaces are related as follows: 
   \item{     The row space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> are orthogonal complements in <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^n"/>. }
   \item{     The column space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/> and the null space of <img src="https://latex.codecogs.com/gif.latex?\inline&space;A^T"/> are orthogonal complements in <img src="https://latex.codecogs.com/gif.latex?\inline&space;{\mathbb{R}}^m"/>. }
   -  The rank, nullity and "left nullity" satisfy the following equations: 
   \item{     <img src="https://latex.codecogs.com/gif.latex?\inline&space;\displaystyle&space;\textrm{rank}(A)+\textrm{nullity}(A)=n"/> }
   \item{     <img src="https://latex.codecogs.com/gif.latex?\inline&space;\displaystyle&space;\textrm{rank}(A)+\textrm{nullity}(A^T&space;)=m"/> }
   -  A linear system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> can have zero, one or infinitely many solutions. 
   -      If rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  = <img src="https://latex.codecogs.com/gif.latex?\inline&space;n"/> the  system is consistent with a unique solution. 
   -      If rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) = rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  < <img src="https://latex.codecogs.com/gif.latex?\inline&space;n"/> the system is consistent with infinitely many solutions. 
   -      If rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;A"/>) <img src="https://latex.codecogs.com/gif.latex?\inline&space;\not="/> rank(<img src="https://latex.codecogs.com/gif.latex?\inline&space;[A~b]"/>)  the system is inconsistent. 
   -  The general solution of a linear system <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> is the sum of a particular solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> and the general solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=0"/>. 
   \item{     The minimum norm solution to <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax=b"/> is the unique vector <img src="https://latex.codecogs.com/gif.latex?\inline&space;x_r&space;\in&space;\textrm{rowspace}(A)"/> satisfying <img src="https://latex.codecogs.com/gif.latex?\inline&space;Ax_r&space;=b"/>. }

