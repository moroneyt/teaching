### A Pluto.jl notebook ###
# v0.11.14

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

# ╔═╡ ee149f10-f291-11ea-311d-d5d4fcad82f9
using Plots

# ╔═╡ 90bc94a0-f307-11ea-2e72-9fb532d3c94a
using PlutoUI

# ╔═╡ db24a0c0-f1ca-11ea-2e05-0384d81eda7b
html"<img src=https://cms.qut.edu.au/__data/assets/image/0009/872244/QUT_REALWORLD_LOGO_ANCHOR_LEFT_paths_REV.png style=background-color:rgb(0,70,127);/>"

# ╔═╡ e0dc6750-f1ca-11ea-28a4-3fabb03feb5c
md"# MXB161 Lesson 1: Introduction"

# ╔═╡ eae1cbc0-f23b-11ea-0fa4-7dcb4bc3455a
md"Throughout this interactive lecture you will find embedded videos that demonstrate all the new concepts.  Because this is an *interactive* lecture, you will have the opportunity to try out everything you've just seen for yourself, and to explore further in whatever direction your imagination takes you."

# ╔═╡ f8aee240-f1ca-11ea-3ed9-f368ef07f9e9
md"## The Julia programming language"

# ╔═╡ 240ae3d2-f1cb-11ea-0575-112c2692acde
md"""You are viewing this interactive lecture in your web browser.  But this is no ordinary web page!  In fact, you are using what's called a *reactive notebook*.  Behind the scenes, there is an instance of the [Julia programming language](https://julialang.org/) running.  By entering Julia expressions into the *cells* of this notebook, you are able to execute arbitrary Julia code, and the notebook will update automatically in response.

Watch the video below for some demonstrations.  Incidentally, whenever you come across an embedded video in this notebook, please watch the video before proceeding.  The content of the sections following a video are based on the assumption that you've watched the video first.
"""

# ╔═╡ 7b761570-f23b-11ea-1af5-a9d91deee53f
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/77A6eb82gWk frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ 7738e0f0-f23b-11ea-0f81-bfabd6b15e9b
md"Let's explore the example from the video, using this notebook as a simple calculator.  Suppose we want to find the sum of two variables `u` and `v`.  We can enter them as follows, one statement per cell."

# ╔═╡ 70736fd0-f1cb-11ea-0abf-39dc8832c6e0
u = 1

# ╔═╡ 7233e480-f1cb-11ea-1cd1-9f586c93a6f0
v = 2

# ╔═╡ 72f6e660-f1cb-11ea-0dc3-1f8d8b3e83f6
md"Now let's find the sum `u+v`.  We'll call the result `w`."

# ╔═╡ c5c1a9c0-f1cb-11ea-0b88-212604592baa
w = u + v

# ╔═╡ 656df250-f1cf-11ea-39fd-af91bdee9c1a
md"""So far, so good.  Now for the reactive part.  Go back and change the value of `u` and/or `v`.  Hit Shift-Enter to re-evaluate the cell (or hit the little play button in the bottom right), and watch the value of `w` update *automatically*.

That was a rather simple calculation.  Here's a more complicated one."""

# ╔═╡ 53100550-f1cd-11ea-363c-6774c26df07c
z = -3u^2 + 0.5v^2 - u*v/4

# ╔═╡ a999a570-f1cd-11ea-397a-eb66cb34338c
md"""In this expression you can see addition (`+`), subtraction (`-`), multiplication (`*`), division(`/`), power(`^`), negation (as in `-3`), and implied multiplication by a numerical literal (as in placing a literal value such as -3 or 0.5 in front of a variable).  These basic operations will be all we need for now, but if you're interested in the many more mathematical operations that Julia provides, head over to [the manual] (https://docs.julialang.org/en/v1/manual/mathematical-operations/) for a further read.

And, of course, if you go back and change the values of `u`, `v` or `w`, you'll see the result of this calculation for `z` update automatically.  Go ahead and try it now."""

# ╔═╡ 2e89f2d0-f241-11ea-27db-3bda7766abe9
md"#### Parenthesising"

# ╔═╡ 3e352dd0-f241-11ea-1d06-011519ec79ec
md"Mathematical operations have certain orders of precedence, and so when constructing expressions you might need to use parentheses to enforce a particular order of evaluation.  For example, the values of the following three expresssions are different in general."

# ╔═╡ 7bd82e70-f242-11ea-1ae0-9571103cb6c1
u + v * w / 2z

# ╔═╡ 8f775ff0-f242-11ea-365e-5df4c969951e
(u + v) * w / 2z

# ╔═╡ 9506b6f0-f242-11ea-066e-091eda0ad437
(u + v * w / 2)z

# ╔═╡ f0885aa0-f243-11ea-3b7a-1399861d70d0
md"The full list of operation precedence can be found in [the manual](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity), but if you're ever in doubt, you can always add parentheses to your expresssion to be sure it does what you want."

# ╔═╡ 08c621de-f241-11ea-396e-1bc08b353172
md"### Review exercise: quadratic formula"

# ╔═╡ a355c080-f246-11ea-3c5d-dfb3d11d7f78
md"We all remember the quadratic formula $x_{1,2} = \displaystyle\frac{-b \pm \sqrt{b^2-4ac}}{2a}$ from high school.  Let's get this formula entered into our notebook, as a little exercise.  First, we'll define some particular values for `a`, `b` and `c`.  Notice how it's possible to assign values to all three variables on the same line, using commas to separate."

# ╔═╡ d1ca0f80-f24f-11ea-0e15-0768f11a5756
a, b, c = 2, 1, -6  # short-hand for a = 2 <new cell> b = -1 <new cell> c = -6

# ╔═╡ d0f0c680-f24f-11ea-36fc-81a627c40cd4
md"(The output shows a *tuple* of the three values (2, -1, 6), since that's effectively what we entered on the right hand side.  But for sure, the variables `a`, `b`, and `c` have been assigned each value respectively.)  Now enter the expression to evaluate the positive branch of the quadratic formula.  Replace `missing` with the correct expression involving `a`, `b`, and `c`."

# ╔═╡ e14e0280-f246-11ea-2d49-db6d7d6aac55
x₁ = missing

# ╔═╡ d0cf1840-f250-11ea-183f-675774a2c5c8
!ismissing(x₁) && a*x₁^2 + b*x₁ + c == 0 ? md" **Correct!**" : md"**Needs more work!**"

# ╔═╡ 12659a32-f252-11ea-056e-37bcd7087c9a
md"If your formula produces the correct result, the text above will show Correct! instead of Needs more work!  Once you have `x₁` correct, go ahead and calculate the solution `x₂` for the negative branch."

# ╔═╡ a737b4a0-f251-11ea-35f1-1bc9bb225327
x₂ = missing  # replace missing with the correct expression

# ╔═╡ bc9ba090-f251-11ea-2ab8-57c7bef61ded
!ismissing(x₂) && a*x₂^2 + b*x₂ + c == 0 ? md" **Correct!**" : md"**Needs more work!**"

# ╔═╡ dbe23810-f251-11ea-0479-dda6081914f2
md"Once you've had an attempt, watch the following video for an explanation about some of the more subtle points in this example."

# ╔═╡ 6f473882-f252-11ea-3e87-7b11c828fe04
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/gWAXuasxq10 frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ fd316ae0-f1cf-11ea-337c-d57e79f1e60f
md"### Variable names"

# ╔═╡ 8c4bbec0-f1cf-11ea-2e66-f90bc61a66dd
md"So far we have used rather simple one-letter names for our variables.  In Julia, you are free to use much more descriptive names for your variables, provided they start with a letter, underscore(`_`), or a more elaborate Unicode character.  

Watch the following video for a walkthrough of the types of variable names that are allowed in Julia."

# ╔═╡ 0cc414d0-f1d0-11ea-2caf-bf46026cc8a1
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/s_hnXDiKBWE frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ abda7a00-f257-11ea-030e-f31f90d2532a
md"Having watched the video, head on over to the Julia manual's section on [Unicode input](https://docs.julialang.org/en/v1/manual/unicode-input/), to pull out a few of your favourite symbols and create some variable names with them.  Remember, to give yourself some more cells to play with, just hit the plus sign below and to the left of this cell."

# ╔═╡ e9cffce0-f257-11ea-20e9-3581e7349adb
# create a few variables of your own, using some of the more elaborate Unicode symbols

# ╔═╡ 11987770-f258-11ea-168d-cbd96c833212
md"Incidentally, the list of which letters (and other symbols) are available in subscript or superscript form in Unicode is available on the revevant [Wikipedia page](https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts)."

# ╔═╡ b7bb92f0-f32e-11ea-0626-c59b61db7c84
md"## Arrays"

# ╔═╡ c40a0e60-f32e-11ea-0114-37878522f0cd
md"So far we've been working with scalar values: single numbers like 1 or 2.5.  Now we're going to try our hand at *arrays* of numbers.  In Julia, an example of an array is:"

# ╔═╡ 1a99a1f0-f32f-11ea-2570-9d548e4412e0
[1, 2.5, -100]

# ╔═╡ 28fdb6ee-f32f-11ea-364c-599d6a43ebd8
md"We see that we use square brackets to delimit the array, and we separate the entries of the array by commas.  The output indicates that this is an array of `Float64` values.  We'll talk more about data types another day, but for now you can just read `Float64` as \"real numbers\" (as distinct from, say, integers).

Julia provides many inbulit functions for constructing arrays that can be more convenient than hand-typing out all the entries.  For example, we can build an array comprising a range of 1001 equally-spaced values from 0 up to 1 using the `range` function:"

# ╔═╡ 9ae84ff0-f32f-11ea-3787-815dfb6a575e
t = range(0, 1, length=1001)

# ╔═╡ ebab5c70-f32f-11ea-1935-b9538af8c599
md"Julia also makes it easy to apply mathematical functions to arrays.  For example, let's compute a new array `x` whose $i$th entry $x_i$ is related to the $i$th entry of `t` by the formula $x_i =t_i\cos(4\pi t_i)$."

# ╔═╡ 6839ce20-f330-11ea-2b39-cf9bee1e0fbf
x = t .* cos.(8π*t)

# ╔═╡ 91c1d300-f330-11ea-2bdd-4fe553fd024e
md"Notice how we use the \"dot times\" operator `.*` and the \"dotted cos\" function `cos.` in this formula.  In Julia, to apply an operation that's not natively defined on an array, like `cos`, you just append a dot to the function name.  This is called *broadcasting*, and it's an incredibly powerful concept.  It means that *any function* that is defined for scalars, can be automatically applied to an array of inputs, simply by broadcasting it using a dot.

Now you write the corresponding line to calculate a new array `y` whose $i$th entry $y_i$ is related to the $i$th entry of `t` by the formula $y_i =t_i\sin(4\pi t_i)$.  Remember, to access the symbol $\pi$, type \\pi and hit tab.
"

# ╔═╡ 662db500-f331-11ea-28f8-334db75b901b
y = t .* sin.(8π*t)

# ╔═╡ d7501c00-f331-11ea-2b1c-d7761b1dd9fe
md"The arrays `t`, `x` and `y` are all one-dimensional arrays, also often called *vectors*.  We can build a *two-dimensional* array, also often called a *matrix*, by taking each of these arrays as a column.  The syntax is `[t x y]` where we notice we now separate the entries by a *space* rather than a comma."

# ╔═╡ e6ff0080-f331-11ea-3a32-23b759f192e8
[t x y]

# ╔═╡ 94d6a230-f332-11ea-0bc5-31716dddb814
md"We'll be dealing with arrays of numbers very often in this unit.  For now, let's move on to the next section and look at one thing we can do with them: plotting."

# ╔═╡ b8403710-f290-11ea-0141-278edd2fd9ad
md"## Packages and Plotting"

# ╔═╡ cefa1610-f290-11ea-12db-3352fc2b6655
md"The base Julia functionality provides all the fundamentals of a programming language.  So far we've just scratched the surface by exploring some basic mathematical calculations.  As this unit progresses, we'll learn many more fundamental programming constructs, all of which are provided by Julia.  But for now, we want to branch out and try a little plotting.

Plotting, not being a fundamental component of the language, is not provided by base Julia.  Instead, that responsbility falls onto one or more *packages*.  Packages are collections of Julia code that service a particular application (such as plotting).  Some Julia packages are written and maintained by the Julia language developers, but many more are provided by the community.  This is typical of an open source language such as Julia, and having access to a vibrant package ecosystem is one of the great advantages of the open source model.

Let's now load our first package: Plots.
"

# ╔═╡ 02f9be10-f292-11ea-0a0c-3bc06a079b9c
md"When this notebook was first opened, the `using Plots` command was executed, and the Julia functions in the Plots package were made available.  As you might guess, the functions in this package are all about producing different kinds of plots.

In fact, Plots is an example of a package in Julia that mostly parcels up existing functionality from other libraries into a convenient interface.  Plotting is an application where there are many existing, mature libraries, and there's little point reinventing the wheel.  Instead, the Plots package provides a common Julia interface to a number of existing plotting backends written in other languages.  The backend we will prefer is called Plotly.  We select it using the `plotly` command."

# ╔═╡ 6700c740-f293-11ea-0c9b-0de97d0772a7
plotly()

# ╔═╡ 74780b40-f293-11ea-274c-a3612967a4b7
md"The `using Plots; plotly()` one-two punch will be second nature after the first or second time.  Feel free to experiment with any of the [other plotting backends](https://docs.juliaplots.org/latest/backends/), but for web-based notebooks, the interactivity provided by Plotly makes it our go-to choice.

OK, so let's give it a whirl!  We'll start by plotting our arrays `x` and `y` from the previous section.
"

# ╔═╡ 9a1ba690-f32e-11ea-0305-814a402ba72b
plot(x,y)

# ╔═╡ dd659d7e-f332-11ea-1c80-9310732641e4
md"Ooh, it's a pretty spiral.  The equations we used for calculating `x` and `y` are evidently the equations for a spiral.  You can think of this as the trajectory traced out by some particle in the $xy$-plane over time.

Actually this spiral is a bit misshapen, because `plot` doesn't set the axis ratios to be equal by default.  (You can see the figure is wider than it is tall -- a sensible choice for many figures, particularly given that screens are wider than they are tall -- but not really what we want for our example.  Let's fix that now by setting the axis ratios to be equal.  While we're at it, we will set the axis *limits* to be between -1 and 1, and give our spiral a more descriptive *label*."

# ╔═╡ 7ecb5d42-f333-11ea-0f32-e193573105d6
plot(x,y, ratio=:equal, limits=(-1,1), label="spiral")

# ╔═╡ 6e78beb2-f333-11ea-2a49-4186ff1bb712
md"Much better.

Now, if we like, we could make a three-dimensional plot, by bringing `t` into the picture (literally!)."

# ╔═╡ 0642c6f0-f334-11ea-29fe-cd087d5d3d1a
plot(x,y,t, label="corkscrew")

# ╔═╡ 7204af20-f334-11ea-2848-d9fede271c78
md"We'd better label the axes now so we know which is which.  Also, the line width seems a little too thin now that it's a three-dimensional plot, so let's adjust that too."

# ╔═╡ 8859d8e0-f334-11ea-006d-35cef36b12e5
plot(x,y,t, label="corkscrew", xlabel="x", ylabel="y", zlabel="t", linewidth=3)

# ╔═╡ b298d1b0-f334-11ea-2a59-e79ba7b105ec
md"You can freely rotate the image with your mouse to get a view from a different angle.  There are also the zoom, pan, and other interactive tools available (which is true of all the plots so far)."

# ╔═╡ ca906b60-f335-11ea-15da-fd85fa8efd3d
md"Let's have a quick recap of plotting: watch the video and then we'll continue."

# ╔═╡ e790bc60-f335-11ea-097c-ff3e7762785a
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/hcxFB3F-WM4 frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ 499f3bd0-f335-11ea-27ed-5102f7100d3d
md"To plot multiple curves on the same figure, you can use the ordinary `plot` command for the first, and `plot!` for the subsequent commands.  Here's a double corkscrew."

# ╔═╡ 1e210c40-f335-11ea-3620-6f16c8945211
begin
	plot(x,y,t, label="corkscrew", xlabel="x", ylabel="y", zlabel="t", linewidth=3)
	plot!(-x,-y,t, label="another corkscrew", linewidth=3)
end

# ╔═╡ bc1a06e0-f335-11ea-2299-a3d3f59c70a5
md"Notice how we also wrap the `plot` commands in a `begin` `end` block.  In general, any cell in which we want to evaluate multiple expressions requires a `begin` `end` block."

# ╔═╡ 2f993d10-f34b-11ea-1d92-29450b358368
md"### Scatter plots"

# ╔═╡ 3a26cea0-f34b-11ea-3d03-e558df4d0456
md"So far, we've been making line plots.  But other kinds of plots are useful too.  For this section, we'll be interested in scatter plots -- plots of individual points where it doesn't make sense to connect them up with lines.

So, let's get ourselves some points.  We'll generate an array with two columns of random numbers uniformly distributed between zero and one.  Let's suppose we want `N = 1000` points."

# ╔═╡ 43921932-f2fc-11ea-0ea5-df5d9db903f5
N = 1000  

# ╔═╡ d7a5b740-f34b-11ea-0141-49ffaf6cdfbd
md"And let's call our array of `N×2` random numbers `Pᵤ`"

# ╔═╡ 09a3e000-f2f7-11ea-18d9-53aa46ad6467
Pᵤ = rand(N,2)

# ╔═╡ 02fde840-f34c-11ea-16a8-45e69b8522b5
md"A scatter plot of these points looks like this."

# ╔═╡ e9d22a10-f2f7-11ea-2f76-19cb3867558e
scatter(Pᵤ[:,1], Pᵤ[:,2], lab="Uniform samples", xlab="x", ylab="y")

# ╔═╡ 0cbd2d50-f34c-11ea-1d7c-edcfe5b13b26
md"Notice how all the points are between zero and one in both dimensions.  Here, it's not such a bother that the figure isn't square, so we'll leave it be.

Now it's your turn.  Create an array `Pₙ` of `N` *normally distributed* random numbers, with mean 0 and standard deviation 1.  Remember that `rand` is the function that creates uniformly distributed random numbers, so you'll need to find another (perhaps, similarly named?) function that does normally distributed random numbers.
"

# ╔═╡ 2ff941f0-f34c-11ea-16ed-5506cdec316e


# ╔═╡ 94ba2ed0-f359-11ea-19f8-4ba2704a1642
md"Now that you have your normal random samples, create a scatter plot like before."

# ╔═╡ d6a0b910-f2f8-11ea-3854-51d4c52a5294


# ╔═╡ d2c92d20-f359-11ea-3f8c-d9fe77cf1107
md"Once you've got a figure you're happy with, or, if you're having any trouble, watch the following video for a discussion of some of the finer points around plotting."

# ╔═╡ f7d0da00-f359-11ea-0769-f15ca1b0ff64
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/YuTqunav9nE frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ 2553bef0-f375-11ea-2770-cf7f24aa1035
md"Tidy up your scatter plot to look like the final example shown in the video."

# ╔═╡ 365eff20-f375-11ea-3dd9-4f145360e032


# ╔═╡ 918bfc80-f35d-11ea-34f7-d152e2e98932
md"Now, here's a question: what's the *diameter* of this point set?  That is, what's the largest distance between any two points in the set?  This sounds like a fun problem to tackle in Julia, and who knows, we might learn some more good tricks along the way.

Whenever we're talking distances in the plane, there's a very good chance we're going to need the *distance formula*, which you probably learnt at high school.  If $(x_1, y_1)$ and $(x_2, y_2)$ are two points in the plane, then the distance between them is given by 

$\textrm{distance} = \sqrt{(x_1-x_2)^2 + (y_1-y_2)^2}$

This just Pythagoras' theorem.

So here's a challenge for you: *by eye*, identify which two points in your figure you think are furthest apart.  Then, using the interactive cursor, hover over the points in question and jot down their coordinates.  Use the distance formula to calculate how far they are apart.  That will be your best guess at the diameter of this point set.
"

# ╔═╡ 65c6bc60-f35e-11ea-3d8c-37a39f34071b


# ╔═╡ 756489e0-f35e-11ea-0bb2-472287f02d68
md"Once you've calculated your *by eye* answer, or if you're having trouble, watch the following video for a much more detailed look at how we might automate this procedure to be sure we're getting it right."

# ╔═╡ a3329cde-f35e-11ea-2741-1793cf5a6881
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/SBerDGsgCfU frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ 212bcfe0-f364-11ea-37e4-6f42a721f6d2
md"Define the `distance` function as described in the video.  Confirm that it gives sensible answers for a couple of pairs of points in your set.  Once you've got it working, join us for the next video where we really put this function to work."

# ╔═╡ 544d0490-f2fe-11ea-0520-35b714bd3586


# ╔═╡ 08dafd30-f364-11ea-289d-35ca939dabb1
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/jJXp5oUNfYM frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ 32803190-f365-11ea-196e-971dabee2e99
md"Define the distance matrix `D` as described in the video.  Confirm that its values look sensible, particularly that the diagonal values are zero, and that it's visibly *symmetric*; i.e. `D[i,j]` is equal to `D[j,i]`.  Once that's done, join us in the next video where we'll find the maximum distance among all these entries."

# ╔═╡ 8c2facc0-f2f7-11ea-1886-2562e8f75bbf


# ╔═╡ aeaf6c3e-f365-11ea-0306-a52c06e21efa
html"
<iframe width=560 height=315 src=https://www.youtube.com/embed/NifvlrJJY68 frameborder=0 allow=accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture allowfullscreen></iframe>
"

# ╔═╡ f1559e90-f368-11ea-2ccc-9d2064f2be52
md"Create a figure like you saw in the video: a scatter plot of your random normal point set, with the two outermost points joined by a straight line, and the diameter indicated on the label.  Try to do as much as you can without referring directly to the code in the video."

# ╔═╡ 3a887b00-f369-11ea-050b-89692d9cc7f1


# ╔═╡ 708bd7b0-f369-11ea-143c-e71567159e7c
md"# Lesson exercises"

# ╔═╡ 8f68ff00-f369-11ea-3f67-b106dc62d066
md"All of these exercises have sample solutions, although the code is hidden by default.  Do your very best not to peek at the solutions before you've had a genuine attempt at solving the question yourself.  You might have your own line of thinking which is equally valid, but which leads to an alternative solution to the one presented.  That's fine!  There is often more than one way to solve a problem (the larger or more complex the problem, the closer this is to certain).  So just peeking at someone else's solution will rob you of the chance to build your own intuitions and develop the programming style that suits you best."

# ╔═╡ 7a0cb430-f369-11ea-28b1-07b65d352144
md"## Array comprehensions"

# ╔═╡ 67b0bba0-f36a-11ea-119c-8f98d6f8d8d4
md"Write an array comprehension to generate an array `A` whose `(i,j)`th entry is `abs(i-j)` for `i = 1:10, j = 1:10`"

# ╔═╡ 678dd4e0-f36b-11ea-344b-9337b279b47e


# ╔═╡ eceb0690-f36a-11ea-1612-6ff60f6d85e4
Aₛₒₗᵤₜᵢₒₙ = [abs(i-j) for i = 1:10, j = 1:10]

# ╔═╡ 1283cfe0-f36b-11ea-2962-ab94fed27042
md"Write an array comprehension to generate an array `B` whose `(i,j)`th entry is the two-digit number `ij`.  That is, the entries of this array have the digits of their own Cartesian index, e.g. the value 57 occurs in row 5, column 7."

# ╔═╡ 630d55d2-f36b-11ea-0ffd-55ae57915b4e


# ╔═╡ 34eb5672-f36b-11ea-2503-575fbf939901
Bₛₒₗᵤₜᵢₒₙ = [10i+j for i = 1:9, j = 1:9]

# ╔═╡ 1e2f7770-f372-11ea-0118-abf7715c0e16
md"## Spirals"

# ╔═╡ 253b8360-f372-11ea-2c22-15472a3b6e9b
md"Plot a double spiral using the arrays `x` and `y` you created earlier."

# ╔═╡ 60488c4e-f372-11ea-01f0-1f9fbcb5e960


# ╔═╡ 6129c490-f372-11ea-10c4-6b36f61efa23
begin
	plot(x,y, ratio=:equal, limits=(-1,1), label="spiral")
	plot!(-x,-y, label="another spiral")
end

# ╔═╡ 9d7faff0-f36c-11ea-2cc3-69debfaa419b
md"## Helices"

# ╔═╡ a4c59090-f36c-11ea-3935-0dd3c65cea1f
md"Plot a three-dimensional helix, by modifying the formulas you used for your three-dimensional corkscrew.  Hint: you want the \"radius\" to be constant now, instead of spiralling outwards.  Don't modify your arrays `x` and `y` (this is a reactive notebook remember, so modifying those arrays would result in all the plots involving `x` and `y` being redrawn).  Instead, just put the approprate formulas directly into your call to the `plot` function."

# ╔═╡ 15103530-f36d-11ea-1f08-25fb11885080


# ╔═╡ 14872f10-f36d-11ea-1da4-07caf1bad4e9
plot(cos.(8π*t),sin.(8π*t),t, label="helix", xlabel="x", ylabel="y", zlabel="t", linewidth=3)

# ╔═╡ 61670df0-f36d-11ea-0367-7b795ea9c1f0
md"Now make it a *double* helix."

# ╔═╡ 6df0e4b0-f36d-11ea-31b8-c9c2b82155be


# ╔═╡ 6d71f0b0-f36d-11ea-3e0a-9f7e6fb8ff43
begin
	plot(cos.(8π*t),sin.(8π*t),t, label="helix", xlabel="x", ylabel="y", zlabel="t", linewidth=3)
	plot!(-cos.(8π*t),-sin.(8π*t),t, label="another helix", linewidth=3)
end

# ╔═╡ 953f7450-f36d-11ea-0be0-f92bf973684d
md"## Rose curves"

# ╔═╡ 9b1f5c50-f36d-11ea-2b72-6f22f1116606
md"The equations

$x = \cos(k\pi \theta) \cos(\pi \theta)$

$y = \cos(k\pi \theta) \sin(\pi \theta)$

where $k$ is a positive rational number, produce what are known as *rose curves*.  If we let $k = n/d$ for integer $n$ and $d$, then one can make a pretty little collection of roses like the following (from Wikipedia)."

# ╔═╡ 7fefde40-f36e-11ea-0cc0-e7aa8de8acca
html"<img src=https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Rose-rhodonea-curve-7x9-chart-improved.svg/300px-Rose-rhodonea-curve-7x9-chart-improved.svg.png>"

# ╔═╡ e6b53990-f36e-11ea-0d53-4fdf6c25e88e
md"In this interactive notebook, we can define sliders that allow you to conveniently toggle the values of `n` and `d` to see the effect on an individual rose curve.

n = $(@bind n Slider(1:7, show_value=true)), 
d = $(@bind d Slider(1:9, show_value=true))

Moving the sliders will update the sample solution rose curve shown below.  So, go ahead and play with the sliders to see their effect on the figure.  But don't peek at the code for the solution!  Your job is to write the code to produce that same figure.  To get the interactivity, all you need to do is ensure you use the values of `n` and `d` in your expression.  When you've written the code for your figure, check that it responds to changes in the sliders.  You'll need to experiment with a suitable range for the variable `θ`.  Clearly from the image above, for some values of `n` and `d`, the curve is quite elaborate, so you don't want it cutting out too early (which will happen if your upper value of `θ` is too small).
"

# ╔═╡ 2f591840-f376-11ea-08c3-67dd654df2c0


# ╔═╡ cdfbe110-f36e-11ea-1358-9fe369104362
begin
	θ = range(0, 18π, length=N)
	plot(cos.(n/d*θ).*cos.(θ), cos.(n/d*θ).*sin.(θ),
		ratio=:equal, lims=(-1.1,1.1), colour=:black, lab="rose curve")
end

# ╔═╡ d3ae3e80-f370-11ea-2b81-ef823dfbfdfc
md"**Challenge question**

Create your own little \"rose collection\" resembling the figure taken from Wikipedia above.  You will need to read about plot *layouts*, and be warned, the documentation online on this functionality isn't always so easy to follow.  Depending on the appraoch you take, you might well also need some new Julia syntax that we haven't covered in this lesson.  So only attempt this question if you want a challenge.
"

# ╔═╡ 9ce46810-f371-11ea-0d67-0557cb8c9a71


# ╔═╡ 1cf73b00-f371-11ea-0caf-2da214995af2
# I make no guarantees that this is the optimal way to approach this problem!
begin
	plts = [plot(cos.(n/d*θ).*cos.(θ), cos.(n/d*θ).*sin.(θ),
		ratio=:equal, lims=(-1.1,1.1), lab=false, grid=false,
		axis=false, colour=:black)	for d=1:9 for n=1:7]
	plot(plts..., layout=Plots.GridLayout(9,7))
end

# ╔═╡ edfe51ae-f372-11ea-3ad4-df0f4cc174b4
md"## Histograms

**Challenge question**

Create a *normed histogram* of all the pairwise distances between distinct points in your set `Pₙ`.  Hint: this will be `histogram(something, normed=true)`.  And the `something` will have to somehow exclude distances between a point and itself.  There are many ways to approach this problem, so let your imagination guide you and only peek at the solution if you're really stuck.  Having said that, it will almost certainly require new syntax that we haven't covered in this lesson, so it's a challenge question."

# ╔═╡ b810a312-f376-11ea-309e-351693645981


# ╔═╡ 3f96e830-f327-11ea-2e51-2f577b6be462
begin
	# all the code to create the distance matrix from scratch is here
	Pₙ′ = randn(N,2)
	distance′(p₁, p₂) = √sum((p₁-p₂).^2)
	D′ = [distance′(Pₙ′[i,:], Pₙ′[j,:]) for i = 1:N, j = 1:N]
	histogram(filter(!iszero, D′), normed=true, lab="probability density")
end

# ╔═╡ 8ff8d760-f373-11ea-3932-7f64aa370e2a
md"A challenge question for your statistics lecturer is what is the probability distribution governing the distance between two points in the plane drawn from a standard normal distribution.  Your MXB161 lecturer does not claim to have the answer to this one!  But whatever it is, it has the shape given above.  You can see that most of the probability density is contained between 0 and 4 units of distance, which seems  quite sensible."

# ╔═╡ Cell order:
# ╟─db24a0c0-f1ca-11ea-2e05-0384d81eda7b
# ╟─e0dc6750-f1ca-11ea-28a4-3fabb03feb5c
# ╟─eae1cbc0-f23b-11ea-0fa4-7dcb4bc3455a
# ╟─f8aee240-f1ca-11ea-3ed9-f368ef07f9e9
# ╟─240ae3d2-f1cb-11ea-0575-112c2692acde
# ╟─7b761570-f23b-11ea-1af5-a9d91deee53f
# ╟─7738e0f0-f23b-11ea-0f81-bfabd6b15e9b
# ╠═70736fd0-f1cb-11ea-0abf-39dc8832c6e0
# ╠═7233e480-f1cb-11ea-1cd1-9f586c93a6f0
# ╟─72f6e660-f1cb-11ea-0dc3-1f8d8b3e83f6
# ╠═c5c1a9c0-f1cb-11ea-0b88-212604592baa
# ╟─656df250-f1cf-11ea-39fd-af91bdee9c1a
# ╠═53100550-f1cd-11ea-363c-6774c26df07c
# ╟─a999a570-f1cd-11ea-397a-eb66cb34338c
# ╟─2e89f2d0-f241-11ea-27db-3bda7766abe9
# ╟─3e352dd0-f241-11ea-1d06-011519ec79ec
# ╠═7bd82e70-f242-11ea-1ae0-9571103cb6c1
# ╠═8f775ff0-f242-11ea-365e-5df4c969951e
# ╠═9506b6f0-f242-11ea-066e-091eda0ad437
# ╟─f0885aa0-f243-11ea-3b7a-1399861d70d0
# ╟─08c621de-f241-11ea-396e-1bc08b353172
# ╟─a355c080-f246-11ea-3c5d-dfb3d11d7f78
# ╠═d1ca0f80-f24f-11ea-0e15-0768f11a5756
# ╟─d0f0c680-f24f-11ea-36fc-81a627c40cd4
# ╠═e14e0280-f246-11ea-2d49-db6d7d6aac55
# ╟─d0cf1840-f250-11ea-183f-675774a2c5c8
# ╟─12659a32-f252-11ea-056e-37bcd7087c9a
# ╟─a737b4a0-f251-11ea-35f1-1bc9bb225327
# ╟─bc9ba090-f251-11ea-2ab8-57c7bef61ded
# ╟─dbe23810-f251-11ea-0479-dda6081914f2
# ╟─6f473882-f252-11ea-3e87-7b11c828fe04
# ╟─fd316ae0-f1cf-11ea-337c-d57e79f1e60f
# ╟─8c4bbec0-f1cf-11ea-2e66-f90bc61a66dd
# ╟─0cc414d0-f1d0-11ea-2caf-bf46026cc8a1
# ╟─abda7a00-f257-11ea-030e-f31f90d2532a
# ╠═e9cffce0-f257-11ea-20e9-3581e7349adb
# ╟─11987770-f258-11ea-168d-cbd96c833212
# ╟─b7bb92f0-f32e-11ea-0626-c59b61db7c84
# ╟─c40a0e60-f32e-11ea-0114-37878522f0cd
# ╠═1a99a1f0-f32f-11ea-2570-9d548e4412e0
# ╟─28fdb6ee-f32f-11ea-364c-599d6a43ebd8
# ╠═9ae84ff0-f32f-11ea-3787-815dfb6a575e
# ╟─ebab5c70-f32f-11ea-1935-b9538af8c599
# ╠═6839ce20-f330-11ea-2b39-cf9bee1e0fbf
# ╟─91c1d300-f330-11ea-2bdd-4fe553fd024e
# ╠═662db500-f331-11ea-28f8-334db75b901b
# ╟─d7501c00-f331-11ea-2b1c-d7761b1dd9fe
# ╠═e6ff0080-f331-11ea-3a32-23b759f192e8
# ╟─94d6a230-f332-11ea-0bc5-31716dddb814
# ╟─b8403710-f290-11ea-0141-278edd2fd9ad
# ╟─cefa1610-f290-11ea-12db-3352fc2b6655
# ╠═ee149f10-f291-11ea-311d-d5d4fcad82f9
# ╟─02f9be10-f292-11ea-0a0c-3bc06a079b9c
# ╠═6700c740-f293-11ea-0c9b-0de97d0772a7
# ╟─74780b40-f293-11ea-274c-a3612967a4b7
# ╠═9a1ba690-f32e-11ea-0305-814a402ba72b
# ╟─dd659d7e-f332-11ea-1c80-9310732641e4
# ╠═7ecb5d42-f333-11ea-0f32-e193573105d6
# ╟─6e78beb2-f333-11ea-2a49-4186ff1bb712
# ╠═0642c6f0-f334-11ea-29fe-cd087d5d3d1a
# ╟─7204af20-f334-11ea-2848-d9fede271c78
# ╠═8859d8e0-f334-11ea-006d-35cef36b12e5
# ╟─b298d1b0-f334-11ea-2a59-e79ba7b105ec
# ╟─ca906b60-f335-11ea-15da-fd85fa8efd3d
# ╟─e790bc60-f335-11ea-097c-ff3e7762785a
# ╟─499f3bd0-f335-11ea-27ed-5102f7100d3d
# ╠═1e210c40-f335-11ea-3620-6f16c8945211
# ╟─bc1a06e0-f335-11ea-2299-a3d3f59c70a5
# ╟─2f993d10-f34b-11ea-1d92-29450b358368
# ╟─3a26cea0-f34b-11ea-3d03-e558df4d0456
# ╠═43921932-f2fc-11ea-0ea5-df5d9db903f5
# ╟─d7a5b740-f34b-11ea-0141-49ffaf6cdfbd
# ╠═09a3e000-f2f7-11ea-18d9-53aa46ad6467
# ╟─02fde840-f34c-11ea-16a8-45e69b8522b5
# ╠═e9d22a10-f2f7-11ea-2f76-19cb3867558e
# ╟─0cbd2d50-f34c-11ea-1d7c-edcfe5b13b26
# ╠═2ff941f0-f34c-11ea-16ed-5506cdec316e
# ╟─94ba2ed0-f359-11ea-19f8-4ba2704a1642
# ╠═d6a0b910-f2f8-11ea-3854-51d4c52a5294
# ╟─d2c92d20-f359-11ea-3f8c-d9fe77cf1107
# ╟─f7d0da00-f359-11ea-0769-f15ca1b0ff64
# ╟─2553bef0-f375-11ea-2770-cf7f24aa1035
# ╠═365eff20-f375-11ea-3dd9-4f145360e032
# ╟─918bfc80-f35d-11ea-34f7-d152e2e98932
# ╠═65c6bc60-f35e-11ea-3d8c-37a39f34071b
# ╟─756489e0-f35e-11ea-0bb2-472287f02d68
# ╟─a3329cde-f35e-11ea-2741-1793cf5a6881
# ╟─212bcfe0-f364-11ea-37e4-6f42a721f6d2
# ╠═544d0490-f2fe-11ea-0520-35b714bd3586
# ╟─08dafd30-f364-11ea-289d-35ca939dabb1
# ╟─32803190-f365-11ea-196e-971dabee2e99
# ╠═8c2facc0-f2f7-11ea-1886-2562e8f75bbf
# ╟─aeaf6c3e-f365-11ea-0306-a52c06e21efa
# ╟─f1559e90-f368-11ea-2ccc-9d2064f2be52
# ╠═3a887b00-f369-11ea-050b-89692d9cc7f1
# ╟─708bd7b0-f369-11ea-143c-e71567159e7c
# ╟─8f68ff00-f369-11ea-3f67-b106dc62d066
# ╟─7a0cb430-f369-11ea-28b1-07b65d352144
# ╟─67b0bba0-f36a-11ea-119c-8f98d6f8d8d4
# ╠═678dd4e0-f36b-11ea-344b-9337b279b47e
# ╟─eceb0690-f36a-11ea-1612-6ff60f6d85e4
# ╟─1283cfe0-f36b-11ea-2962-ab94fed27042
# ╠═630d55d2-f36b-11ea-0ffd-55ae57915b4e
# ╟─34eb5672-f36b-11ea-2503-575fbf939901
# ╟─1e2f7770-f372-11ea-0118-abf7715c0e16
# ╟─253b8360-f372-11ea-2c22-15472a3b6e9b
# ╠═60488c4e-f372-11ea-01f0-1f9fbcb5e960
# ╟─6129c490-f372-11ea-10c4-6b36f61efa23
# ╟─9d7faff0-f36c-11ea-2cc3-69debfaa419b
# ╟─a4c59090-f36c-11ea-3935-0dd3c65cea1f
# ╠═15103530-f36d-11ea-1f08-25fb11885080
# ╟─14872f10-f36d-11ea-1da4-07caf1bad4e9
# ╟─61670df0-f36d-11ea-0367-7b795ea9c1f0
# ╠═6df0e4b0-f36d-11ea-31b8-c9c2b82155be
# ╟─6d71f0b0-f36d-11ea-3e0a-9f7e6fb8ff43
# ╟─953f7450-f36d-11ea-0be0-f92bf973684d
# ╟─9b1f5c50-f36d-11ea-2b72-6f22f1116606
# ╟─7fefde40-f36e-11ea-0cc0-e7aa8de8acca
# ╟─90bc94a0-f307-11ea-2e72-9fb532d3c94a
# ╟─e6b53990-f36e-11ea-0d53-4fdf6c25e88e
# ╠═2f591840-f376-11ea-08c3-67dd654df2c0
# ╟─cdfbe110-f36e-11ea-1358-9fe369104362
# ╟─d3ae3e80-f370-11ea-2b81-ef823dfbfdfc
# ╠═9ce46810-f371-11ea-0d67-0557cb8c9a71
# ╟─1cf73b00-f371-11ea-0caf-2da214995af2
# ╟─edfe51ae-f372-11ea-3ad4-df0f4cc174b4
# ╠═b810a312-f376-11ea-309e-351693645981
# ╟─3f96e830-f327-11ea-2e51-2f577b6be462
# ╟─8ff8d760-f373-11ea-3932-7f64aa370e2a
