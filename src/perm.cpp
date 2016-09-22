#include <Rcpp.h>
#include <vector>
#include <algorithm>

// [[Rcpp::export]]
std::vector<int> NextPerm(std::vector<int> x) {
  // Computes the next permutation to x
  //
  // Args:
  //   x   : integer vector
  //
  // Returns:
  //   integer vector
  //
  // Assumes:
  //   x has duplicate values

  // Starting from the end of the vector x,
  // find the first decreasing adjacent values.
  // If find one, then swap that samller value with the
  // next larger value on the right, then
  // reverse the numbers on the right.
  // Example:
  //   x = 1 2 3 4
  //   3 is the first decreased value, swap that with 4.
  //   On the right is just one element 3, so the reversing
  //   does not affect.
  //   result = 1 2 4 3
  //
  //   x = 2 4 3 1
  //   2 is the first decreased value, which is swapped with 3.
  //   On the right is 4 2 1, reversed to 1 2 4
  //   result = 3 1 2 4
  for (int i = x.size()-1; i > 0; i--)
  {
    if (x[i-1] < x[i]) {
      for (int j = x.size()-1; j >= i; j--)
      {
        // Note: I could use binary search here
        //       but the total runtime would be still O(n)
        if (x[i-1] < x[j]) {
          std::swap(x[i-1], x[j]);
          std::reverse(x.begin()+i, x.end());
          break;
        }
      }
      break;
    }
  }
  return x;
}



// [[Rcpp::export]]
std::vector<int> PrevPerm(std::vector<int> x) {
  // Computes the previous permutation to x
  //
  // Args:
  //   x   : integer vector
  //
  // Returns:
  //   integer vector
  //
  // Assumes:
  //   x has duplicate values

  // Same algorithm as NextPerm, except for the direction of inequality
  for (int i = x.size()-1; i > 0; i--)
  {
    if (x[i-1] > x[i]) {
      for (int j = x.size()-1; j >= i; j--)
      {
        // Note: I could use binary search here
        //       but the total runtime would be still O(n)
        //       And practically n won't be so big
        if (x[i-1] > x[j]) {
          std::swap(x[i-1], x[j]);
          std::reverse(x.begin()+i, x.end());
          break;
        }
      }
      break;
    }
  }
  return x;
}


/*** R
x <- 1:5
k <- 1
while (TRUE)
{
  cat(sprintf("%3d : %s\n", k,  paste0(x, collapse = " ")))
  y <- combIter:::NextPerm(x)
  if (all(x == y)) break
  x <- y
  k <- k + 1
}

# NextPerm and PrevPerm are the inverse function for each other
x <- 1:5
k <- 1
while (TRUE)
{
  cat(sprintf("%3d : %s\n", k,  paste0(x, collapse = " ")))
  y <- combIter:::NextPerm(x)
  if (all(x == y)) break
  z <- combIter:::PrevPerm(y)
  stopifnot(all(x == z))
  x <- y
  k <- k + 1
}
*/
