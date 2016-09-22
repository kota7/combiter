#include <Rcpp.h>
#include <vector>
#include <algorithm>

// [[Rcpp::export]]
std::vector<int> NextPerm(std::vector<int> x) {
  for (std::vector<int>::iterator it = x.end(); it != x.begin(); it--)
  {
    if (*it > *(it-1)) {
      std::iter_swap(it, it-1);
      break;
    }
  }
  return x;
}


/*** R
*/
