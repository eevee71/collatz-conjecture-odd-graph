# Generating the Minimal Directed Graph of Odd Numbers for the Collatz Conjecture

This project constructs and visualizes a **directed graph of the odd-only Collatz conjecture** for all odd numbers from `1` to `n`.

Each node represents an odd integer, and each directed edge points to the next odd number obtained by iterating the Collatz function.  
The graph is rendered using **Gloss**.

---

## Features

- Builds the minimal directed subgraph containing all odd numbers from `1` to `n`
- Nodes are positioned based on their distance from `1` (X-axis) and symmetrically centered (Y-axis).
- Includes a test suite to ensure graph integrity.

---

## Requirements

- **Haskell Stack**
- **Gloss** library
- On Windows: `freeglut.dll` available in the system PATH or project directory

---

## Running the Project

To build and run, provide a **natural number** `n` as an argument:

```bash
stack run -- <n>
```

## Running Tests

To verify graph correctness:

```bash
stack test --ta <n>
```

The test checks that:
- all odd numbers from 1 to n are present in the graph
- all root nodes have values ≤ n