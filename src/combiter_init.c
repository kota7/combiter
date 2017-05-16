#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP combiter_NextCartes(SEXP, SEXP);
extern SEXP combiter_NextComb(SEXP, SEXP);
extern SEXP combiter_NextPerm(SEXP, SEXP);
extern SEXP combiter_NextSubset(SEXP, SEXP);
extern SEXP combiter_PrevCartes(SEXP, SEXP);
extern SEXP combiter_PrevComb(SEXP, SEXP);
extern SEXP combiter_PrevPerm(SEXP, SEXP);
extern SEXP combiter_PrevSubset(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"combiter_NextCartes", (DL_FUNC) &combiter_NextCartes, 2},
    {"combiter_NextComb",   (DL_FUNC) &combiter_NextComb,   2},
    {"combiter_NextPerm",   (DL_FUNC) &combiter_NextPerm,   2},
    {"combiter_NextSubset", (DL_FUNC) &combiter_NextSubset, 2},
    {"combiter_PrevCartes", (DL_FUNC) &combiter_PrevCartes, 2},
    {"combiter_PrevComb",   (DL_FUNC) &combiter_PrevComb,   2},
    {"combiter_PrevPerm",   (DL_FUNC) &combiter_PrevPerm,   2},
    {"combiter_PrevSubset", (DL_FUNC) &combiter_PrevSubset, 2},
    {NULL, NULL, 0}
};

void R_init_combiter(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
