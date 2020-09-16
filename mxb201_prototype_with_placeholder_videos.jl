### A Pluto.jl notebook ###
# v0.11.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ fc40e280-dfca-11ea-2d61-4f9bf0089491
using SymPy, LinearAlgebra

# ╔═╡ 51d2e4a0-def9-11ea-2d08-9b65b288b6d5
using Plots; plotly();

# ╔═╡ 468e6f8e-e040-11ea-36b8-73adb0d967af
using PlutoUI

# ╔═╡ 268d0eb0-deef-11ea-1794-f34d786c7347
include("MXB201.jl")

# ╔═╡ b0a1c500-e20f-11ea-0f41-c113b9e09732
md"![](http://www.thecube.qut.edu.au/img/bg/QUT20.png)"

# ╔═╡ 62c30820-e06c-11ea-0e29-07e6379393f2
md"# MXB201 Lesson X: Orthonormal bases"

# ╔═╡ 99e9afb0-e34c-11ea-2bc0-2321c580f319
md"This is a prototype of using the Pluto system for developing educational resources, loosely based on a lesson from MXB201.  It is to investigate the possiblities, and not intended as an actual lesson.  Videos are all placeholders."

# ╔═╡ b91d76e0-e1a9-11ea-18a2-cb0dbb459373
md"""
### Table of Contents:

  * [The Gram-Schmidt process] (#gs)
  * [Column Vectors](#colvec)
  * [Matrices](#matrix)
  * [Functions](#function)

"""

# ╔═╡ 1a52ea90-e34d-11ea-1640-bd85e47d68ff
md"## Getting set up"

# ╔═╡ 405e0ae0-e072-11ea-2bd4-0ff7d98caa4a
md"Let's include the basics to get us started."

# ╔═╡ f61f0082-e06f-11ea-1226-9beb56fdcc2a
md"We'll need two packages to help us with our Linear Algebra.  `SymPy` is the package we'll use for symbolic manipulation, and `LinearAlgebra` has all the linear algebra operations."

# ╔═╡ 8b728a80-e070-11ea-070d-cd298221c393
md"We will create some symbolic variables that will come in handy."

# ╔═╡ 35241a90-deef-11ea-2be2-dd36b5355dbf
x,ξ = symbols("x ξ", real = true)

# ╔═╡ d64bcf50-e523-11ea-1a43-0f92749af351
md"Before we go further, we should review what we learned last week about inner products.  Watch this short video before continuing."

# ╔═╡ 9721f5b0-e524-11ea-35c2-55630e3a8073
html"""
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/8M6eo3j7jO4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ aece01f0-e1b8-11ea-0a5d-efa8c0a3249a
md"""In this lesson we will be interested in the standard inner products for spaces $\mathbb{R}^n$, $\mathcal{M}_{nn}$ and $C[a,b]$.

| Vector Space  | Standard inner product | 
| :------------ |:-----------------------| 
| $u,v \in \mathbb{R}^n$      | $\langle u,v\rangle \ \, = u \cdot v = u^\textrm{T} v$ | 
| $A,B \in \mathcal{M}_{nn}$      | $\langle A,B\rangle = \textrm{vec}(A) \cdot \textrm{vec}(B) = \textrm{tr}(A^\textrm{T} B)$     |   
| $f,g \in C[a,b]$ | $\langle f,g\rangle \ \, = \int_a^b f(\xi)\, g(\xi)\, \textrm{d}\xi$     |    
"""

# ╔═╡ 255d5a70-e072-11ea-06be-5d9d936b10c9
md"Hence we will define methods for the inner product function `ip` for each of: column vectors, matrices and functions."

# ╔═╡ 661d47f0-e072-11ea-0b16-f5fc5449813c
md"An inner product induces a norm via $\|v\| = \sqrt{\langle v,v \rangle}$, so we'll define the function `ipnorm` as well."

# ╔═╡ 40f16410-e34d-11ea-36b5-791219cb8f67
html"<a name=\"gs\"></a>"

# ╔═╡ 3242b182-e34d-11ea-1fc5-ff8ed80a1d4f
md" ## The Gram-Schmidt process"

# ╔═╡ b47c6bd0-e33b-11ea-006b-937efc57db37
md"The [Gram-Schmidt process](https://en.wikipedia.org/wiki/Gram%E2%80%93Schmidt_process) can be used to  can be used to orthonormalise any basis. In words, it iterates over each vector in the basis, subtracting off its projections onto the vectors that came before, and finally normalising.  Watch the video to learn how it works, then we'll continue."

# ╔═╡ 97f409f2-e33b-11ea-2c40-fb7b7e48b94c
html"""<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/zHbfZWZJTGc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>"""

# ╔═╡ 97eb5f60-e072-11ea-327e-131249e68cb8
md"We'll define a generic method for the `gram_schmidt` function that accepts an array of vectors of any kind.  For convenience, we'll also define a method which accepts column vectors as columns of a matrix."

# ╔═╡ 2516de30-e278-11ea-2227-292a67bf3319
html"<a name=\"colvec\"></a>"

# ╔═╡ 10326df0-e074-11ea-217c-cf86d7259b26
md"## Column Vectors"

# ╔═╡ 57ffbc60-e073-11ea-1064-dfdd142d0704
md"We'll give the algorithm a try on a column vectors first.  Let's repeat the example we did in the video.  We define our three vectors $\textrm{v}_1$, $\textrm{v}_2$, $\textrm{v}_3$."

# ╔═╡ bca52070-e33d-11ea-1600-7194233ff35c
v₁ = Sym[1,-1,1]; v₂ = Sym[0,0,1]; v₃ = Sym[1,1,2];

# ╔═╡ dfb93ab0-e33d-11ea-3e3b-f7c9b77149ee
𝒱 = [v₁, v₂, v₃]

# ╔═╡ 37939dc0-e33e-11ea-0a42-a5c6d4ed2ce4
md"Now we apply the Gram-Schmidt process to this set of vectors, to produce an orthonormal basis $\textrm{u}_1$, $\textrm{u}_2$, $\textrm{u}_3$."

# ╔═╡ c8c67bf0-e33e-11ea-3326-4f9beb426494
md"We can confirm that this is an orthonormal basis by verifying that $\langle \textrm{u}_i, \textrm{u}_j \rangle = \delta_{ij}$."

# ╔═╡ 098d8ace-e33e-11ea-3982-339de4e26896
md"An alternative way we could have found this orthonormal basis is to augment the vectors $\textrm{v}_1$, $\textrm{v}_2$, $\textrm{v}_3$ as columns of a matrix $A$."

# ╔═╡ bbe4a572-def1-11ea-2170-6bf128a2c8f6
A = [v₁ v₂ v₃]

# ╔═╡ 7785cde0-e073-11ea-3013-ab2e09e4a6e9
md"The Gram-Schmidt process applied to this matrix produces the following matrix $Q$."

# ╔═╡ 8e162be0-e073-11ea-1b04-6bdb8bcf811b
md"We can confirm it has worked by taking the pair-wise inner products of all columns.  That is, we find $Q^\textrm{T}Q$."

# ╔═╡ a23e02f0-e1b3-11ea-0a6b-9d53cd8aaaca
md"In fact, the matrices $A$ and $Q$ are related by the so-called QR decomposition $A = QR$, where $R$ is an upper triangular matrix."

# ╔═╡ 939486e0-e1bb-11ea-0b44-ab3dda7be737
md"We can confirm that $A = QR$ for this example."

# ╔═╡ d53d3ee0-e349-11ea-0cfc-cd544a20906b
md"So keeping our column vectors in a matrix is more than just a programming convenience.  We have actually discovered a new matrix decomposition -- a most interesting finding!  Let's explore this decomposition in more detail in the video below."

# ╔═╡ b8bad072-e349-11ea-2619-d98de92a8785
html"""
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/FAnNBw7d0vg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ 3519d620-e278-11ea-1f72-bd087fb53e81
html"<a name=\"matrix\"></a>"

# ╔═╡ 47fc0bb0-e074-11ea-0e80-5ff7e0420b32
md" ## Matrices"

# ╔═╡ 503e74c0-e074-11ea-39c2-07e5f3daf975
md"We will find an orthonormal basis for the space of $n \times n$ symmetric matrices $\mathcal{S}_n \subset \mathcal{M}_{nn}$.  For this lesson we will take"

# ╔═╡ b92f89b0-e074-11ea-31f7-9954628bb2a0
n = 3

# ╔═╡ e42f3a6e-e074-11ea-3a96-cf1afb508b7d
md"We define a generic matrix $M \in \mathcal{M}_{nn}$."

# ╔═╡ 1bd98c50-def4-11ea-3f90-f3649a2fd2f7
M = symbols.(("a_$i$j" for i = 1:n, j = 1:n), real = true)

# ╔═╡ 053cfd60-e075-11ea-3677-77aad6c2ceca
md"Now we impose symmetry: $M = M^\textrm{T}$.  This implies there must be relationships between the entries $a_{ij}$."

# ╔═╡ 448f8940-def6-11ea-194c-0b0874478811
relationships = solve(vec(M - M'))

# ╔═╡ 5086fa00-e075-11ea-07b7-c370bbabd003
md"We now make these relationships explicit in the matrix $M$, to give our generic symmetric matrix $S$."

# ╔═╡ 4f53e240-def6-11ea-387d-2fb28689f5ae
S = subs.(M, (relationships,))

# ╔═╡ 7a675810-e075-11ea-1269-cf74a34331f0
md"What dimension is the vector space comprising all matrices of the form $S$?  The answer lies in how many free variables $S$ has."

# ╔═╡ 874fb390-def6-11ea-2b34-4f7d0c0447a9
freevars = unique(vcat(free_symbols.(S)...))

# ╔═╡ 3575ea70-def7-11ea-2040-31e0ce47f2d7
dimS = length(freevars)

# ╔═╡ c9069a30-e075-11ea-3737-35eadb921ff2
md"Sequentially setting each free variable to 1, and the remaining free variables to 0, we can construct the standard basis for this space."

# ╔═╡ e805bd00-def7-11ea-1a4d-21dbb701474a
𝑺 = [subs.(S, (freevars[i].=>eye(Sym,dimS)[i,j] for i = 1:dimS)...) for j = 1:dimS]

# ╔═╡ f5db8020-e075-11ea-11d1-73b8788feed0
md"Now we can use the Gram-Schmidt process to orthonormalise."

# ╔═╡ 13a7aca0-e076-11ea-0d79-e7711e15a35a
md"Again let's check our working by finding all pairwise inner products."

# ╔═╡ c5f6ccb0-e076-11ea-0536-17c5ee317b14
md"Here's a question: what is the \"nearest\" symmetric matrix to an arbitrary matrix $M \in \mathcal{M}_{nn}$?  The answer is given by the projection of $M$ onto $\mathcal{S}_n$.  Let's find what that is.  First we'll find the coordinate vector $c$ of the projection: $c_j = \langle \hat{S}_j, M \rangle$."

# ╔═╡ f9cf3da0-e077-11ea-09dc-e3eabd467304
md"Now we can assemble the projection itself: $M_s = \textrm{Proj}_{\mathcal{S}_{n}}(M) = \displaystyle\sum_{j=1}^{\dim(\mathcal{S})}\, c_j\, \hat{S}_j$"

# ╔═╡ 94edc810-e078-11ea-36a6-fdf19be19145
md"Perhaps unsurprisingly, this is just the so-called \"symmetric part\" of a matrix: $M_s = 
(M + M^\textrm{T})/2$."

# ╔═╡ cdda3740-e1b2-11ea-1569-9dda9b62ac6e
md"If you haven't done so already, go back and change $n$ to be larger, and all the intermediate calculations will update.  You will see that the result is true in general.  Challenge question: can you prove it?"

# ╔═╡ 5a75d860-e2d7-11ea-0807-1da2c2c2df53
md"""#### Exercises

1. Find an orthonormal basis for the space $\mathcal{K}_n$ of _skew-symmetric_ matrices, satisfying $M = -M^\textrm{T}$.
2. Show that $\mathcal{S}_n$ and $\mathcal{K}_n$ are _orthogonal complements_.
3. What is the projection of an arbitrary $n \times n$ matrix onto $\mathcal{K}_n$?
"""

# ╔═╡ 5ece39c0-e34a-11ea-05b4-41c505a95062
md"Try these exercises yourself, but if you're having difficulty you can watch the video below for some hints."

# ╔═╡ 6f60d210-e34b-11ea-1cfd-5d8b60d2c491
html"""
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/uKPmyG18N7I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ 6876f200-e278-11ea-1253-f5d4ab68824a
html"<a name=\"function\"></a>"

# ╔═╡ 0a48a8a0-e079-11ea-1899-cb22891a6bec
md" ## Functions"

# ╔═╡ 1a16fc00-e079-11ea-3bff-5f977490e13c
md"A classic application of Gram-Schmidt orthonormalisation for function spaces is in finding the least squares polynomial approximation to a given function.  For example, let's project the function $f(x)$ defined by"

# ╔═╡ f1739bd0-def9-11ea-2935-8b05c72c7a8e
f = exp(x)

# ╔═╡ fd5d45e0-e1b5-11ea-3090-3fa6b780dba3
md"onto the space $\mathcal{P}_N[a,b]$.  We will take the interval $(a,b)$ to be"

# ╔═╡ 050d32f0-e1b6-11ea-0244-476ce7dc7e3b
(a,b) = (-1,1)

# ╔═╡ 006a8680-def0-11ea-2f01-11bc03dc69ca
begin
	ip(u::Vector, v::Vector) = u ⋅ v
	ip(A::Matrix, B::Matrix) = vec(A) ⋅ vec(B)
	ip(f::Sym, g::Sym) = integrate(f(ξ)*g(ξ), (ξ,a,b))
end

# ╔═╡ 215c35ee-def0-11ea-29a8-ad027acf228b
ipnorm(v) = √ip(v,v)

# ╔═╡ 8b591590-def0-11ea-367d-d7e179a18ac8
begin
	function gram_schmidt(B)
		ONB = similar(B) # uninitialised array the same type as B
		ONB[1] = B[1] / ipnorm(B[1]) # first vector just needs normalising
		for i = 2:length(B)
			# subtract projections, then normalise
			ONB[i]  = B[i] - sum(ip(B[i], ONB[j]) * ONB[j] for j = 1:i-1)
			ONB[i] /= ipnorm(ONB[i])
		end
		return ONB
	end

	# We'll add a method for taking the basis vectors as the columns of a matrix
	function gram_schmidt(A::Matrix)
		# forward to the generic method
		hcat(gram_schmidt([A[:,j] for j = 1:size(A,2)])...)
	end
end	

# ╔═╡ f7aad660-e33d-11ea-26f0-dfcd9458d0bd
𝒰 = gram_schmidt(𝒱)

# ╔═╡ a96f1b90-e33e-11ea-06e2-af17c0ce199a
[ip(𝒰[i], 𝒰[j]) for i = 1:3,  j = 1:3]

# ╔═╡ bee00b1e-def1-11ea-27c3-e37601db9a5e
Q = gram_schmidt(A)

# ╔═╡ 9bb458d0-e073-11ea-1481-1d79fc895bcb
Q'Q

# ╔═╡ 9a415570-e1b3-11ea-2beb-85d2e537c70a
R = Q'A

# ╔═╡ c248fbe0-e1b3-11ea-0638-97c0b32e61c9
A == Q*R

# ╔═╡ 5e0f5420-def8-11ea-155e-85a16dce418f
𝑺ₒₙ = gram_schmidt(𝑺)

# ╔═╡ 1fc442a0-e076-11ea-3ade-4da1b7930d82
[ip(𝑺ₒₙ[i], 𝑺ₒₙ[j]) for i = 1:dimS, j = 1:dimS]

# ╔═╡ dd5c97ae-def8-11ea-130e-f33e93308e63
c = [ip(𝑺ₒₙ[j], M) for j = 1:dimS]

# ╔═╡ 16320020-def9-11ea-0619-95f00f27b1fd
Mₛ = simplify.(sum(c[j] * 𝑺ₒₙ[j] for j = 1:dimS))

# ╔═╡ c5a16ed0-e078-11ea-194a-ff3f6277ec0c
Mₛ == (M+M')/2

# ╔═╡ 6561bbf0-e079-11ea-3d3c-d3c14223eaab
md"We'll need an orthonormal basis for $\mathcal{P}_N[a,b]$.  We can get one by orthonormalising the basis of monomials $x^p$ for $p = 0\ldots N$.  Use the slider to choose the value of $N$ you want."

# ╔═╡ b2916880-e079-11ea-008e-ff10311bda02
@bind N Slider(2:9; default=3)

# ╔═╡ 0c6d2790-e07f-11ea-195b-a329dd163f76
md" $N$ = $N"

# ╔═╡ 5d229e20-e040-11ea-0ea7-abfbaae6f1c0
𝓟 = x.^(0:N)

# ╔═╡ 88137570-e07a-11ea-0b8f-7ffca9055f24
md"Now apply the Gram-Schmidt process as usual."

# ╔═╡ a52812be-e06f-11ea-2fb7-ab3c711814c3
𝓟ₒₙ = gram_schmidt(𝓟)

# ╔═╡ 222a1730-e1b7-11ea-24a5-3bab3e1fc3b0
md"The orthonormal polynomials we've just constructed are the famous [Legendre polynomials](https://en.wikipedia.org/wiki/Legendre_polynomials)."

# ╔═╡ c2f0b672-e2d8-11ea-0237-7dae000c34aa
plot(𝓟ₒₙ, -1, 1, xlab = "𝑥", title="Legendre polynomials",
	label="P".*string.((0:N)'))

# ╔═╡ 945a64e0-e2ed-11ea-3ac0-bb8cd6c9b448
md"We can confirm they are indeed orthonormal over $[-1,1]$."

# ╔═╡ 9fd45240-e2ed-11ea-24bd-9783df8c385c
ip.(𝓟ₒₙ', 𝓟ₒₙ) == eye(Sym, N+1)

# ╔═╡ a502d680-e07a-11ea-0218-bb8139f7763b
md"Now find the coordinates of the projection of $f$ onto this basis."

# ╔═╡ 0e4a92e0-defa-11ea-1153-7161a1571afa
𝑐 = ip.(f, 𝓟ₒₙ)

# ╔═╡ d7af18f0-e07a-11ea-080c-a7cc070c16eb
md"With this coordinates we can build the projection itself."

# ╔═╡ 1fe8c4c0-e02d-11ea-011d-1748624063ef
𝑃f = sum(𝑐[i] * 𝓟ₒₙ[i] for i = 1:N+1)

# ╔═╡ 197070e0-e07b-11ea-1e94-87e8fcbfe6e1
md"We can plot $f$ and its projection $\mathcal{P}f$ on the same figure to compare."

# ╔═╡ 834cae20-e044-11ea-292d-99162a87ca93
plot([f,𝑃f], a, b; label=["𝑓" "𝑃𝑓"], xlabel="𝑥",
	title="Legendre projection of f(x) = $f with N=$N")

# ╔═╡ f0314640-e1b6-11ea-3d91-b3837ee652dd
md"If you like, go back and adjust the slider to increase $N$ and improve the accuracy.  Or to make it a harder problem, change the function $f$ to something more interesting!  **n.b.** You _might_ be tempted to change the interval to something wider than $[-1,1]$ to make it more challenging, but resist that urge for now, because the next section on trigonometric polynomials assumes that the interval is $[-1,1]$."

# ╔═╡ 4c930430-e1cd-11ea-3189-0b10e5f6aa61
md" ### Trigonometric polynomials"

# ╔═╡ 5e5622b0-e1cd-11ea-0040-9d6580583765
md"""A [trigonometric polynomial](https://en.wikipedia.org/wiki/Trigonometric_polynomial) is a linear combination of the trigonometric functions $\cos(k\pi x)$ and $\sin(k\pi x)$

$T_N(x) = \sum_{k=0}^N a_k \cos(k\pi x) + \sum_{k=1}^N b_k \sin(k \pi x).$

Other sources often use simply $\cos(kx)$ and $\sin(kx)$ but we will prefer our definition so that this function is periodic on the interval $[-1,1]$ (rather than $[-\pi,\pi]$).

A natural question is what is the orthogonal projection of an arbitrary periodic function on $[-1,1]$ onto the span of these trigonometric functions?  In other words, what is the best trigonometric polynomial approximation to an arbitrary periodic function?

Let's start small, we'll take
"""

# ╔═╡ d4f67430-e1d0-11ea-32be-1b630e0b5b16
𝑁 = 3

# ╔═╡ bcbf55ee-e1ce-11ea-0f4e-d5f3831b4cac
md"We will build our basis $\mathcal{T}$ of trigonometric functions, with the plan to orthonormalise using the Gram-Schmidt process."

# ╔═╡ 84a535f0-e1c8-11ea-109e-116b91fa310d
𝒯 = [cos.((0:𝑁)*(π*x)); sin.((1:𝑁)*(π*x))]

# ╔═╡ dc6b3ef0-e1ce-11ea-1e55-7f669c122e9c
md"But we are in for a surprise!  This basis is _already_ orthogonal on $[-1,1]$.  In fact, it's very nearly an ortho_normal_ basis, as we can readily confirm by finding the pairwise inner products:"

# ╔═╡ 69223950-e1cc-11ea-0cfb-a1fbaa4258b8
ip.(𝒯', 𝒯)

# ╔═╡ 28d29270-e1cf-11ea-27bd-5550b53955cc
md"Only the constant term needs scaling in order to complete our orthonormal basis."

# ╔═╡ 41ead3d0-e1cf-11ea-160f-ef73c7a53ccc
𝒯[1] = 1/√Sym(2); 𝒯

# ╔═╡ 95af2780-e1d1-11ea-1320-7b07b566db1a
md"This is now an orthonormal basis on $[-1,1]$, as we can readily confirm."

# ╔═╡ 79c78460-e1cf-11ea-3da9-4382ba235a4c
ip.(𝒯', 𝒯) == eye(Sym, 2*𝑁+1)

# ╔═╡ 96e52160-e1cf-11ea-2047-1711a70f7e24
md"With our orthonormal basis in hand, we can merrily project whatever function we wish onto this space.  Let's take it simple, and project the function $g(x)$ defined by"

# ╔═╡ 041d3630-e1cd-11ea-36d1-152488d6a560
g = x

# ╔═╡ eb234ae0-e1cf-11ea-023e-6fa79f001f77
md"We find the coefficients $C_j = \langle g, \mathcal{T}_j \rangle$."

# ╔═╡ c9ab0650-e1cf-11ea-1a8e-bd10481c85e2
𝐶 = ip.(g, 𝒯)

# ╔═╡ dee215e0-e1cf-11ea-08a2-c9c9b37e9089
md"And now the projection $\mathcal{P}g$."

# ╔═╡ 07a82a50-e1d0-11ea-0d33-3129c17f140b
𝑃g = 𝐶' * 𝒯

# ╔═╡ 312077c0-e1d0-11ea-1cb1-ed63dfbade65
md"How do the two functions compare?"

# ╔═╡ 3564ff40-e1d0-11ea-1b14-8fd79d4daf9c
plot([g,𝑃g], -1,1; label=["𝑔" "𝑃𝑔"], xlabel="𝑥",
	title="Trigonometric projection of g(x) = $g with N = $𝑁")

# ╔═╡ b91ab090-e1d1-11ea-26ab-c732289e9fee
md"But wait, $g(x)$ _isn't_ a periodic function. So what exactly have we built here?  Let's extend our axis limits a little further."

# ╔═╡ d100da92-e1d1-11ea-0448-e3029fcc0999
plot(𝑃g, -2,2; label = "𝑃𝑔", xlabel="𝑥",
	title="Trigonometric projection of g(x) = $g with N = $𝑁")

# ╔═╡ d5628700-e1d1-11ea-23cb-75461ca5ebc6
md"""We have in fact constructed a trigonometric polynomial approximating the _periodic extension_ of $g(x)$.  Interestingly, this periodic extension is not actually a continuous function, yet our trigonometric polynomial is doing a pretty decent job of handling the discontinuities at $\pm 1$.

Let's build a little function to do this projection efficiently, so that we can explore the effect of increasing $N$.
"""

# ╔═╡ 3717f480-e1d2-11ea-3d28-fd9bb0655e43
function trig_poly(g, 𝑁)
	𝒯 = [cos.((0:𝑁)*(π*x)); sin.((1:𝑁)*(π*x))]
	𝒯[1] /= √2
	𝐶 = ip.(g, 𝒯)
	𝑃g = 𝐶' * 𝒯
end

# ╔═╡ 805ad680-e1d2-11ea-21ea-eb346ac094fe
md"Quick check that it produces the same result we had before:"

# ╔═╡ 62604700-e1d2-11ea-1ceb-b9c41829fd57
trig_poly(g, 𝑁) == 𝑃g

# ╔═╡ 7e84de00-e1d2-11ea-1da2-3995db8a1565
md"Now we can play with the upper limit (let's call it $N_\textrm{up}$) and see what effect it has on the figure."

# ╔═╡ 668d9d00-e1d2-11ea-151a-89fa882ccccd
@bind 𝑁ᵤₚ Slider(2:50)

# ╔═╡ b4074ae0-e1d2-11ea-26bf-abb7515e269d
md" $N_\textrm{up}$ = $𝑁ᵤₚ"

# ╔═╡ c707cb60-e1d2-11ea-17f8-cf5a22da41ae
plot(trig_poly(g, 𝑁ᵤₚ), -2,2; label = "𝑃𝑔", xlabel="𝑥",
	title="Trigonometric projection of g(x) = $g with N = $𝑁ᵤₚ")

# ╔═╡ 1d7d6e50-e1d3-11ea-1903-f1a33677c13f
md"If you experiment with larger values of $N_\textrm{up}$ you'll see that the projection always overshoots at the discontinuity (pay attention to the y-axis limits -- they go beyond $[-1,1]$).  This is known as the [Gibbs phenomenon](https://en.wikipedia.org/wiki/Gibbs_phenomenon)."

# ╔═╡ 070b5880-e359-11ea-3fb2-0b1231d37f49
md"""#### Exercises

1. Devise a number of interesting "test functions" with the goal of projecting them onto polynomial and trigonometric polynomial spaces of various dimensions.  Include at least one example of a:
* discontinuous function
* function without a continuous derivative
* smooth function
* periodic function
Write a Julia function to carry out both projections for a given mathematical function $f(x)$ and plot the resulting projections on the same axis.  Record your observations of the behaviour of the projections of these functions as you increase the number of elements in the bases.
"""

# ╔═╡ ee8a64a0-e2d5-11ea-2eb2-01dbd7ad1031
md" ### Approximation theory and Fourier analysis"

# ╔═╡ ffd67e60-e2d5-11ea-18a1-799473ea8f58
md"""
You may be wondering, what function do these projections _converge_ to in the limit as $N \to \infty$?  Do they converge at all?  Does they only converge sometimes?  Does this depend on the function?  Is the limit always the same as the function?  If not, why not, and when?  All very good questions of course!  And in fact, many of them turn out to have non-trival answers.  The study of questions such as these is the subject of [Approximation theory](https://en.wikipedia.org/wiki/Approximation_theory) (in the case of polynomial projections) and [Fourier analysis](https://en.wikipedia.org/wiki/Fourier_analysis) (in the case of trigonometric projections).  Answers to these questions are, however, beyond the scope of this unit, because they first require a rigorous understanding of what \"converge\" actually means in the context of functions -- an _analytic_ concept that would take us beyond the realm of linear _algebra_.

Still, to get a taste of where this line of thinking can lead in the case of trigonometric projections, as well as the historical motivation that led to its discovery, you could do worse than watching this highly entertaining video on the topic of [Fourier series](https://en.wikipedia.org/wiki/Fourier_series).
"""

# ╔═╡ fca08e64-e2d2-11ea-2a0e-49833672880a
html"""
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/r6sGWTCMz2k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ Cell order:
# ╟─b0a1c500-e20f-11ea-0f41-c113b9e09732
# ╟─62c30820-e06c-11ea-0e29-07e6379393f2
# ╟─99e9afb0-e34c-11ea-2bc0-2321c580f319
# ╟─b91d76e0-e1a9-11ea-18a2-cb0dbb459373
# ╟─1a52ea90-e34d-11ea-1640-bd85e47d68ff
# ╟─405e0ae0-e072-11ea-2bd4-0ff7d98caa4a
# ╠═268d0eb0-deef-11ea-1794-f34d786c7347
# ╟─f61f0082-e06f-11ea-1226-9beb56fdcc2a
# ╠═fc40e280-dfca-11ea-2d61-4f9bf0089491
# ╟─8b728a80-e070-11ea-070d-cd298221c393
# ╠═35241a90-deef-11ea-2be2-dd36b5355dbf
# ╟─d64bcf50-e523-11ea-1a43-0f92749af351
# ╟─9721f5b0-e524-11ea-35c2-55630e3a8073
# ╟─aece01f0-e1b8-11ea-0a5d-efa8c0a3249a
# ╟─255d5a70-e072-11ea-06be-5d9d936b10c9
# ╠═006a8680-def0-11ea-2f01-11bc03dc69ca
# ╟─661d47f0-e072-11ea-0b16-f5fc5449813c
# ╠═215c35ee-def0-11ea-29a8-ad027acf228b
# ╟─40f16410-e34d-11ea-36b5-791219cb8f67
# ╟─3242b182-e34d-11ea-1fc5-ff8ed80a1d4f
# ╟─b47c6bd0-e33b-11ea-006b-937efc57db37
# ╟─97f409f2-e33b-11ea-2c40-fb7b7e48b94c
# ╟─97eb5f60-e072-11ea-327e-131249e68cb8
# ╠═8b591590-def0-11ea-367d-d7e179a18ac8
# ╟─2516de30-e278-11ea-2227-292a67bf3319
# ╟─10326df0-e074-11ea-217c-cf86d7259b26
# ╟─57ffbc60-e073-11ea-1064-dfdd142d0704
# ╠═bca52070-e33d-11ea-1600-7194233ff35c
# ╠═dfb93ab0-e33d-11ea-3e3b-f7c9b77149ee
# ╟─37939dc0-e33e-11ea-0a42-a5c6d4ed2ce4
# ╠═f7aad660-e33d-11ea-26f0-dfcd9458d0bd
# ╟─c8c67bf0-e33e-11ea-3326-4f9beb426494
# ╠═a96f1b90-e33e-11ea-06e2-af17c0ce199a
# ╟─098d8ace-e33e-11ea-3982-339de4e26896
# ╠═bbe4a572-def1-11ea-2170-6bf128a2c8f6
# ╟─7785cde0-e073-11ea-3013-ab2e09e4a6e9
# ╠═bee00b1e-def1-11ea-27c3-e37601db9a5e
# ╟─8e162be0-e073-11ea-1b04-6bdb8bcf811b
# ╠═9bb458d0-e073-11ea-1481-1d79fc895bcb
# ╟─a23e02f0-e1b3-11ea-0a6b-9d53cd8aaaca
# ╠═9a415570-e1b3-11ea-2beb-85d2e537c70a
# ╟─939486e0-e1bb-11ea-0b44-ab3dda7be737
# ╠═c248fbe0-e1b3-11ea-0638-97c0b32e61c9
# ╟─d53d3ee0-e349-11ea-0cfc-cd544a20906b
# ╟─b8bad072-e349-11ea-2619-d98de92a8785
# ╟─3519d620-e278-11ea-1f72-bd087fb53e81
# ╟─47fc0bb0-e074-11ea-0e80-5ff7e0420b32
# ╟─503e74c0-e074-11ea-39c2-07e5f3daf975
# ╠═b92f89b0-e074-11ea-31f7-9954628bb2a0
# ╟─e42f3a6e-e074-11ea-3a96-cf1afb508b7d
# ╠═1bd98c50-def4-11ea-3f90-f3649a2fd2f7
# ╟─053cfd60-e075-11ea-3677-77aad6c2ceca
# ╠═448f8940-def6-11ea-194c-0b0874478811
# ╟─5086fa00-e075-11ea-07b7-c370bbabd003
# ╠═4f53e240-def6-11ea-387d-2fb28689f5ae
# ╟─7a675810-e075-11ea-1269-cf74a34331f0
# ╠═874fb390-def6-11ea-2b34-4f7d0c0447a9
# ╠═3575ea70-def7-11ea-2040-31e0ce47f2d7
# ╟─c9069a30-e075-11ea-3737-35eadb921ff2
# ╠═e805bd00-def7-11ea-1a4d-21dbb701474a
# ╟─f5db8020-e075-11ea-11d1-73b8788feed0
# ╠═5e0f5420-def8-11ea-155e-85a16dce418f
# ╟─13a7aca0-e076-11ea-0d79-e7711e15a35a
# ╠═1fc442a0-e076-11ea-3ade-4da1b7930d82
# ╟─c5f6ccb0-e076-11ea-0536-17c5ee317b14
# ╠═dd5c97ae-def8-11ea-130e-f33e93308e63
# ╟─f9cf3da0-e077-11ea-09dc-e3eabd467304
# ╠═16320020-def9-11ea-0619-95f00f27b1fd
# ╟─94edc810-e078-11ea-36a6-fdf19be19145
# ╠═c5a16ed0-e078-11ea-194a-ff3f6277ec0c
# ╟─cdda3740-e1b2-11ea-1569-9dda9b62ac6e
# ╟─5a75d860-e2d7-11ea-0807-1da2c2c2df53
# ╟─5ece39c0-e34a-11ea-05b4-41c505a95062
# ╟─6f60d210-e34b-11ea-1cfd-5d8b60d2c491
# ╟─6876f200-e278-11ea-1253-f5d4ab68824a
# ╟─0a48a8a0-e079-11ea-1899-cb22891a6bec
# ╟─1a16fc00-e079-11ea-3bff-5f977490e13c
# ╠═f1739bd0-def9-11ea-2935-8b05c72c7a8e
# ╟─fd5d45e0-e1b5-11ea-3090-3fa6b780dba3
# ╠═050d32f0-e1b6-11ea-0244-476ce7dc7e3b
# ╟─6561bbf0-e079-11ea-3d3c-d3c14223eaab
# ╟─b2916880-e079-11ea-008e-ff10311bda02
# ╟─0c6d2790-e07f-11ea-195b-a329dd163f76
# ╠═5d229e20-e040-11ea-0ea7-abfbaae6f1c0
# ╟─88137570-e07a-11ea-0b8f-7ffca9055f24
# ╠═a52812be-e06f-11ea-2fb7-ab3c711814c3
# ╟─222a1730-e1b7-11ea-24a5-3bab3e1fc3b0
# ╠═51d2e4a0-def9-11ea-2d08-9b65b288b6d5
# ╠═c2f0b672-e2d8-11ea-0237-7dae000c34aa
# ╟─945a64e0-e2ed-11ea-3ac0-bb8cd6c9b448
# ╠═9fd45240-e2ed-11ea-24bd-9783df8c385c
# ╟─a502d680-e07a-11ea-0218-bb8139f7763b
# ╠═0e4a92e0-defa-11ea-1153-7161a1571afa
# ╟─d7af18f0-e07a-11ea-080c-a7cc070c16eb
# ╠═1fe8c4c0-e02d-11ea-011d-1748624063ef
# ╟─197070e0-e07b-11ea-1e94-87e8fcbfe6e1
# ╠═834cae20-e044-11ea-292d-99162a87ca93
# ╟─f0314640-e1b6-11ea-3d91-b3837ee652dd
# ╟─4c930430-e1cd-11ea-3189-0b10e5f6aa61
# ╟─5e5622b0-e1cd-11ea-0040-9d6580583765
# ╠═d4f67430-e1d0-11ea-32be-1b630e0b5b16
# ╟─bcbf55ee-e1ce-11ea-0f4e-d5f3831b4cac
# ╠═84a535f0-e1c8-11ea-109e-116b91fa310d
# ╟─dc6b3ef0-e1ce-11ea-1e55-7f669c122e9c
# ╠═69223950-e1cc-11ea-0cfb-a1fbaa4258b8
# ╟─28d29270-e1cf-11ea-27bd-5550b53955cc
# ╠═41ead3d0-e1cf-11ea-160f-ef73c7a53ccc
# ╟─95af2780-e1d1-11ea-1320-7b07b566db1a
# ╠═79c78460-e1cf-11ea-3da9-4382ba235a4c
# ╟─96e52160-e1cf-11ea-2047-1711a70f7e24
# ╠═041d3630-e1cd-11ea-36d1-152488d6a560
# ╟─eb234ae0-e1cf-11ea-023e-6fa79f001f77
# ╠═c9ab0650-e1cf-11ea-1a8e-bd10481c85e2
# ╟─dee215e0-e1cf-11ea-08a2-c9c9b37e9089
# ╠═07a82a50-e1d0-11ea-0d33-3129c17f140b
# ╟─312077c0-e1d0-11ea-1cb1-ed63dfbade65
# ╠═3564ff40-e1d0-11ea-1b14-8fd79d4daf9c
# ╟─b91ab090-e1d1-11ea-26ab-c732289e9fee
# ╠═d100da92-e1d1-11ea-0448-e3029fcc0999
# ╟─d5628700-e1d1-11ea-23cb-75461ca5ebc6
# ╠═3717f480-e1d2-11ea-3d28-fd9bb0655e43
# ╟─805ad680-e1d2-11ea-21ea-eb346ac094fe
# ╠═62604700-e1d2-11ea-1ceb-b9c41829fd57
# ╟─7e84de00-e1d2-11ea-1da2-3995db8a1565
# ╟─668d9d00-e1d2-11ea-151a-89fa882ccccd
# ╟─b4074ae0-e1d2-11ea-26bf-abb7515e269d
# ╠═c707cb60-e1d2-11ea-17f8-cf5a22da41ae
# ╟─1d7d6e50-e1d3-11ea-1903-f1a33677c13f
# ╟─070b5880-e359-11ea-3fb2-0b1231d37f49
# ╟─ee8a64a0-e2d5-11ea-2eb2-01dbd7ad1031
# ╟─ffd67e60-e2d5-11ea-18a1-799473ea8f58
# ╟─fca08e64-e2d2-11ea-2a0e-49833672880a
# ╟─468e6f8e-e040-11ea-36b8-73adb0d967af
