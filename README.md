# Markov Chains and Linear Regression

This repository holds my project for the Numerical Methods course at POLITEHNICA Bucharest (spring 2025). It is written in GNU Octave (the syntax is close to MATLAB, but it uses Octave-specific constructs such as `endfor` and `+=`) and has two independent parts. They look unrelated at first: one is about a robot lost in a labyrinth, the other about predicting house prices. Underneath, though, both come down to the same thing, namely writing a problem as a linear system and choosing a sensible numerical method to solve it.

## Part 1: escaping a labyrinth with Markov chains

### The problem

A robot is dropped into a rectangular labyrinth and moves at random: at every step it picks one of the open directions with equal probability. Leaving the labyrinth through the north or south edge counts as a win, leaving through the east or west edge counts as a loss. The question is, for every cell, how likely the robot is to eventually win if it starts there, and then how to use those probabilities to find a good way out.

### From walls to a transition matrix

Each cell of the input is a number between 0 and 15 whose four bits say which of its sides (north, south, east, west) are walled. `parse_labyrinth` reads the grid and `get_adjacency_matrix` turns it into a graph. Cells are numbered row by row, and two extra nodes are added for the WIN and LOSE states. An open side leads either to the neighbouring cell or, on the border, to one of the two exit nodes.

`get_link_matrix` then normalises every row of the adjacency matrix by the number of open neighbours. The result is the transition matrix of a Markov chain: entry `(i, j)` is the probability of moving from cell `i` to cell `j` in one step. WIN and LOSE point only to themselves, which makes them absorbing states. Once the robot gets there, it stays.

### Win probabilities as a linear system

Let `p(i)` be the probability of reaching WIN from cell `i`. Conditioning on the first step gives

```
p(i) = Σ_j P(i, j) · p(j) + P(i, WIN)
```

which in matrix form is `p = G·p + c`. Here `G` is the part of the transition matrix restricted to the labyrinth cells, and `c` is the column of one-step probabilities of jumping straight to WIN. `get_Jacobi_parameters` extracts `G` and `c`, and `perform_iterative` solves the system with the Jacobi method: start from an initial guess and repeat `x ← G·x + c` until two consecutive iterates are closer than a given tolerance.

The iteration converges here for a structural reason. As long as every cell has some route out of the labyrinth, `G` describes a process that keeps losing probability mass to the exits, and its spectral radius is below 1. In other words, iterating is the same as simulating the random walk for longer and longer, and the answer settles down.

All matrices are stored as `sparse`. A labyrinth with `n` cells produces an `(n+2) × (n+2)` matrix in which each row has at most four non-zero entries, so dense storage would waste almost all of its memory on zeros.

### Finding a path

With the probabilities known, `heuristic_greedy` looks for a way out. It is a depth-first search that always moves to the unvisited neighbour with the highest win probability, backtracks when it hits a dead end, and stops as soon as it reaches a cell next to the WIN exit. It is a heuristic, not a shortest-path algorithm, but it uses exactly the information the Markov chain provides: it prefers the cells from which winning is most likely. `decode_path` finally converts the cell indices back into `(row, column)` coordinates.

## Part 2: linear regression on housing data

### Getting the data into a matrix

The second part predicts house prices from features such as area, number of bedrooms, parking spots, and a series of yes/no attributes (air conditioning, guest room, basement and so on). The data comes in two formats: a space-separated file with the dimensions on its first line (`parse_data_set_file`), and a CSV with a header row (`parse_csv_file`, tested on the classic `Housing.csv` dataset). In both cases the first column is the target price and the rest are features, read into a cell array because numbers and words are mixed.

`prepare_for_regression` turns that cell array into a purely numeric feature matrix. Yes/no answers become 1 and 0. The furnishing status has three values, so it is split into two binary columns (one-hot encoding with "furnished" as the reference category), which avoids pretending that the three categories are ordered.

### Cost functions

Three cost functions measure how far a parameter vector `θ` is from fitting the data:

- the ordinary least-squares cost, `J(θ) = (1/2m) Σ (h_θ(x_i) − y_i)²`;
- **Ridge** (L2) regression, which adds `λ Σ θ_j²` and pulls all coefficients towards zero, making the model less sensitive to noise and to strongly correlated features;
- **Lasso** (L1) regression, which adds `λ Σ |θ_j|` and tends to push some coefficients to exactly zero, so it also acts as a form of feature selection.

In both regularised versions the intercept term is left out of the penalty, since it only shifts the predictions and does not cause overfitting.

### Two ways to find θ

The parameters can be found iteratively or by solving a linear system directly, and the project does both.

`gradient_descent` is the iterative route. At each step it computes the prediction error on every example and moves each coefficient a small distance against the gradient of the cost. It is simple and scales to large datasets, but its behaviour depends heavily on the learning rate. On unscaled features like these, where the area is in the thousands and most other columns are 0 or 1, the learning rate has to be tiny for the process not to diverge.

`normal_equation` takes the direct route. Setting the gradient to zero gives the normal equations `XᵀX·θ = Xᵀy`. Instead of computing the inverse of `XᵀX`, which is expensive and numerically fragile, the system is solved with the **conjugate gradient method**. This works because `XᵀX` is symmetric and positive (semi)definite. Each iteration picks a search direction that is conjugate to all the previous ones, so in exact arithmetic the method reaches the solution in at most `n` steps for `n` unknowns, and in practice it can be stopped much earlier, once the residual drops below the tolerance.

## Running the code

The `src/` folder contains the solution, split into `markov-is-coming/` and `linear-regression/`. The `checker/` folder holds a copy of the sources next to the course's automated tests and reference outputs.

The tests can be run in Docker:

```
./local.sh checker
```

This builds the image and runs every test. The first build takes a while, around ten minutes. To build and run in two separate steps, use `./local.sh docker build` and then `./local.sh checker`. Alternatively, with Octave installed locally, go to `checker/` and run `./checker.sh`.

All tests in both parts pass. The last run is saved in `checker/checker.out`.

## What I took from it

Beyond the individual algorithms, the project made one idea concrete for me. Very different questions ("where will a random walk end up?", "which line best fits these points?") turn into linear systems, and the real work is in choosing how to solve them. For the labyrinth, a simple fixed-point iteration is enough, because the structure of the problem guarantees convergence. For regression, the matrix is symmetric and positive definite, and the conjugate gradient method exploits that instead of inverting anything. Working with sparse matrices and choosing tolerances and learning rates also showed how much the numerical side matters once the mathematics is settled.
